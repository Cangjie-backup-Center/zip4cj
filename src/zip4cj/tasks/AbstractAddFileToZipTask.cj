package zip4cj.tasks

public abstract class AbstractAddFileToZipTask<T> <: AsyncZipTask<T> {
    private var zipModel: ZipModel
    private var password: ?Array<Char>
    private var headerWriter: HeaderWriter

    public init(
        zipModel: ZipModel,
        password: ?Array<Char>,
        headerWriter: HeaderWriter,
        asyncTaskParameters: AsyncTaskParameters
    ) {
        super(asyncTaskParameters)
        this.zipModel = zipModel
        this.password = password
        this.headerWriter = headerWriter
    }

    func addFilesToZip(
        filesToAdd: ArrayList<Path>,
        progressMonitor: ProgressMonitor,
        zipParameters: ZipParameters,
        zip4jConfig: Zip4cjConfig
    ) {
        var readBuff = Array<Byte>(zip4jConfig.getBufferSize(), item: 0)
        var updatedFilesToAdd: ArrayList<Path> = removeFilesIfExists(filesToAdd, zipParameters, progressMonitor,
            zip4jConfig)
        var splitOutputStream: SplitOutputStream = SplitOutputStream(
            zipModel.getZipFile().getOrThrow(),
            zipModel.getSplitLength()
        )
        var zipOutputStream: ZipOutputStream = initializeOutputStream(splitOutputStream, zip4jConfig)
        for (fileToAdd in updatedFilesToAdd) {
            verifyIfTaskIsCancelled()
            var clonedZipParameters: ZipParameters = cloneAndAdjustZipParameters(zipParameters, fileToAdd,
                progressMonitor)
            progressMonitor.setFileName(fileToAdd.toCanonical().toString())

            if (fileToAdd.isSymbolicLink()) {
                if (addSymlink(clonedZipParameters)) {
                    addSymlinkToZip(fileToAdd, zipOutputStream, clonedZipParameters, splitOutputStream)

                    if (SymbolicLinkAction.INCLUDE_LINK_ONLY == (clonedZipParameters.getSymbolicLinkAction())) {
                        continue
                    }
                }
            }

            addFileToZip(fileToAdd, zipOutputStream, clonedZipParameters, splitOutputStream, progressMonitor, readBuff)
        }
        zipOutputStream.close()
        splitOutputStream.close()
    }

    private func addSymlinkToZip(
        fileToAdd: Path,
        zipOutputStream: ZipOutputStream,
        zipParameters: ZipParameters,
        splitOutputStream: SplitOutputStream
    ) {
        var clonedZipParameters: ZipParameters = ZipParameters(zipParameters)
        clonedZipParameters.setFileNameInZip(
            replaceFileNameInZip(zipParameters.getFileNameInZip().getOrThrow(), fileToAdd.fileName.getOrThrow()))
        clonedZipParameters.setEncryptFiles(false)
        clonedZipParameters.setCompressionMethod(CompressionMethod.STORE)

        zipOutputStream.putNextEntry(clonedZipParameters)

        var symLinkTarget: String = FileUtils.readSymbolicLink(fileToAdd)
        zipOutputStream.write(symLinkTarget.toArray())

        closeEntry(zipOutputStream, splitOutputStream, fileToAdd, true)
    }

    private func addFileToZip(
        fileToAdd: Path,
        zipOutputStream: ZipOutputStream,
        zipParameters: ZipParameters,
        splitOutputStream: SplitOutputStream,
        progressMonitor: ProgressMonitor,
        readBuff: Array<Byte>
    ) {
        zipOutputStream.putNextEntry(zipParameters)
        var readLen: Int64 = 0
        if (File.exists(fileToAdd) && !fileToAdd.isDirectory()) {
            var inputStream = File(fileToAdd, OpenOption.Open(true, false))
            readLen = inputStream.read(readBuff)
            while (readLen > 0) {
                zipOutputStream.write(readBuff[0..readLen])
                progressMonitor.updateWorkCompleted(readLen)
                verifyIfTaskIsCancelled()
                readLen = inputStream.read(readBuff)
            }
        }
        closeEntry(zipOutputStream, splitOutputStream, fileToAdd, false)
    }

    private func closeEntry(
        zipOutputStream: ZipOutputStream,
        splitOutputStream: SplitOutputStream,
        fileToAdd: Path,
        isSymlink: Bool
    ) {
        var fileHeader: FileHeader = zipOutputStream.closeEntry()
        var fileAttributes: Array<Byte> = FileUtils.getFileAttributes(fileToAdd)
        if (!isSymlink) {
            fileAttributes[3] = BitUtils.unsetBit(fileAttributes[3], 5)
        }

        fileHeader.setExternalFileAttributes(fileAttributes)

        updateLocalFileHeader(fileHeader, splitOutputStream)
    }

    func calculateWorkForFiles(filesToAdd: Collection<Path>, zipParameters: ZipParameters): Int64 {
        var totalWork: Int64 = 0
        for (fileToAdd in filesToAdd) {
            if (!File.exists(fileToAdd)) {
                continue
            }
            if (zipParameters.isEncryptFiles() && zipParameters.getEncryptionMethod() == EncryptionMethod.ZIP_STANDARD) {
                totalWork += (FileInfo(fileToAdd).length * 2) // for CRC calculation
            } else {
                totalWork += FileInfo(fileToAdd).length
            }

            //If an entry already exists, we have to remove that entry first and then add content again.
            //In this case, add corresponding work
            var relativeFileName: String = FileUtils.getRelativeFileName(fileToAdd, zipParameters)
            var fileHeader: ?FileHeader = HeaderUtil.getFileHeader(getZipModel(), relativeFileName)
            if (fileHeader.isSome()) {
                totalWork += (FileInfo(getZipModel().getZipFile().getOrThrow()).length -
                    fileHeader.getOrThrow().getCompressedSize())
            }
        }

        return totalWork
    }

    func initializeOutputStream(splitOutputStream: SplitOutputStream, zip4jConfig: Zip4cjConfig): ZipOutputStream {
        if (File.exists(zipModel.getZipFile().getOrThrow())) {
            splitOutputStream.seek(HeaderUtil.getOffsetStartOfCentralDirectory(zipModel))
        }
        return ZipOutputStream(splitOutputStream, password, zip4jConfig, zipModel)
    }

    func verifyZipParameters(parameteres: ?ZipParameters) {
        if (parameteres.isNone()) {
            throw ZipException("cannot validate zip parameters")
        }
        var parameters = parameteres.getOrThrow()
        if (!(parameters.getCompressionMethod() == CompressionMethod.STORE) &&
            !(parameters.getCompressionMethod() == CompressionMethod.DEFLATE)) {
            throw ZipException("unsupported compression type")
        }

        if (parameters.isEncryptFiles()) {
            if (parameters.getEncryptionMethod() == EncryptionMethod.NONE) {
                throw ZipException("Encryption method has to be set, when encrypt files flag is set")
            }

            if (password.isNone()) {
                throw ZipException("input password is empty or null")
            }
        } else {
            parameters.setEncryptionMethod(EncryptionMethod.NONE)
        }
    }

    func updateLocalFileHeader(fileHeader: FileHeader, splitOutputStream: SplitOutputStream) {
        headerWriter.updateLocalFileHeader(fileHeader, getZipModel(), splitOutputStream)
    }

    private func cloneAndAdjustZipParameters(
        zipParameters: ZipParameters,
        fileToAdd: Path,
        progressMonitor: ProgressMonitor
    ): ZipParameters {
        var clonedZipParameters: ZipParameters = ZipParameters(zipParameters)

        if (fileToAdd.isDirectory()) {
            clonedZipParameters.setEntrySize(0)
        } else {
            clonedZipParameters.setEntrySize(FileInfo(fileToAdd).length)
        }
        // TODO getLastModifiedFileTime
        clonedZipParameters.setWriteExtendedLocalFileHeader(false)

        if (!Zip4cjUtil.isStringNotNullAndNotEmpty(zipParameters.getFileNameInZip())) {
            var relativeFileName: String = FileUtils.getRelativeFileName(fileToAdd, zipParameters)
            clonedZipParameters.setFileNameInZip(relativeFileName)
        }

        if (fileToAdd.isDirectory()) {
            clonedZipParameters.setCompressionMethod(CompressionMethod.STORE)
            clonedZipParameters.setEncryptionMethod(EncryptionMethod.NONE)
            clonedZipParameters.setEncryptFiles(false)
        } else {
            if (clonedZipParameters.isEncryptFiles() && clonedZipParameters.getEncryptionMethod() == EncryptionMethod.
                ZIP_STANDARD) {
                progressMonitor.setCurrentTask(CALCULATE_CRC)
                clonedZipParameters.setEntryCRC(Int64(CrcUtil.computeFileCrc(fileToAdd, progressMonitor)))
                progressMonitor.setCurrentTask(ADD_ENTRY)
            }

            if (FileInfo(fileToAdd).length == 0) {
                clonedZipParameters.setCompressionMethod(STORE)
            }
        }

        return clonedZipParameters
    }

    private func removeFilesIfExists(
        files: ArrayList<Path>,
        zipParameters: ZipParameters,
        progressMonitor: ProgressMonitor,
        zip4jConfig: Zip4cjConfig
    ): ArrayList<Path> {
        var filesToAdd: ArrayList<Path> = files
        if (!File.exists(zipModel.getZipFile().getOrThrow())) {
            return filesToAdd
        }

        for (file in files) {
            // In some OS it is possible to have empty file names (even without any extension).
            // Remove such files from list as this might cause incompatibility with the zip file
            if (!Zip4cjUtil.isStringNotNullAndNotEmpty(file.fileName)) {
                ListRmove(filesToAdd, file)
            }

            var fileName: String = FileUtils.getRelativeFileName(file, zipParameters)

            var fileHeader: ?FileHeader = HeaderUtil.getFileHeader(zipModel, fileName)
            if (fileHeader.isSome()) {
                if (zipParameters.isOverrideExistingFilesInZip()) {
                    progressMonitor.setCurrentTask(REMOVE_ENTRY)
                    removeFile(fileHeader.getOrThrow(), progressMonitor, zip4jConfig)
                    verifyIfTaskIsCancelled()
                    progressMonitor.setCurrentTask(ADD_ENTRY)
                } else {
                    ListRmove(filesToAdd, file)
                }
            }
        }

        return filesToAdd
    }

    func removeFile(fileHeader: FileHeader, progressMonitor: ProgressMonitor, zip4jConfig: Zip4cjConfig) {
        var asyncTaskParameters: AsyncTaskParameters = AsyncTaskParameters(None, false, progressMonitor)
        // TODO RemoveFilesFromZipTask
    }

    protected open func replaceFileNameInZip(fileInZipWithPath: String, newFileName: String): String {
        if (fileInZipWithPath.contains(InternalZipConstants.ZIP_FILE_SEPARATOR)) {
            return fileInZipWithPath[0..fileInZipWithPath.lastIndexOf(InternalZipConstants.ZIP_FILE_SEPARATOR).
                    getOrThrow() + 1] + newFileName
        }

        return newFileName
    }

    protected open func addSymlink(zipParameters: ZipParameters): Bool {
        return SymbolicLinkAction.INCLUDE_LINK_ONLY == (zipParameters.getSymbolicLinkAction()) ||
            SymbolicLinkAction.INCLUDE_LINK_AND_LINKED_FILE == (zipParameters.getSymbolicLinkAction())
    }

    protected open func getTask(): ProgressMonitorTask {
        return ProgressMonitorTask.ADD_ENTRY
    }

    protected open func getZipModel(): ZipModel {
        return zipModel
    }
}
