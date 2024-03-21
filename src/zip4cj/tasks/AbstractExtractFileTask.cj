package zip4cj.tasks

public abstract class AbstractExtractFileTask<T> <: AsyncZipTask<T> {
    private let zipModel: ZipModel
    private let unzipParameters: UnzipParameters

    public init(zipModel: ZipModel, unzipParameters: UnzipParameters, asyncTaskParameters: AsyncTaskParameters) {
        super(asyncTaskParameters)
        this.zipModel = zipModel
        this.unzipParameters = unzipParameters
    }

    protected func extractFile(
        zipInputStream: ZipInputStream,
        fileHeader: FileHeader,
        output: String,
        newFileName: ?String,
        progressMonitor: ProgressMonitor,
        readBuff: Array<Byte>
    ) {
        var outputPath = output
        var isSymbolicLink = isSymbolicLink(fileHeader)
        if (isSymbolicLink && !unzipParameters.isExtractSymbolicLinks()) {
            return
        }
        if (!outputPath.endsWith(InternalZipConstants.FILE_SEPARATOR)) {
            outputPath += InternalZipConstants.FILE_SEPARATOR
        }
        var outputFile: Path = determineOutputFile(fileHeader, outputPath, newFileName)
        // progressMonitor.setFileName(outputFile.toCanonical().toString()) // Fix Run it later, there will be an error when running here
        if (let Some(fileName) <- outputFile.fileName) {
            progressMonitor.setFileName(
                outputFile.directoryName.getOrThrow().toString() + FileSeparator + outputFile.fileName.getOrThrow()) // Fix Run it later, there will be an error when running here
        } else {
            progressMonitor.setFileName(outputFile.directoryName.getOrThrow().toString())
        }

        // TODO assertCanonicalPathsAreSame
        verifyNextEntry(zipInputStream, fileHeader)
        if (fileHeader.isDirectory()) {
            if (!Directory.exists(outputFile)) {
                Directory.create(outputFile, recursive: true)
            }
        } else if (isSymbolicLink) {
            // TODO createSymLink
        } else {
            checkOutputDirectoryStructure(outputFile)
            unzipFile(zipInputStream, outputFile, progressMonitor, readBuff)
        }

        if (!isSymbolicLink) {
            UnzipUtil.applyFileAttributes(fileHeader, outputFile)
        }
    }

    protected func isSymbolicLink(fileHeader: FileHeader): Bool {
        var externalFileAttributes = fileHeader.getExternalFileAttributes()
        if (externalFileAttributes.isNone() || externalFileAttributes.getOrThrow().size < 4) {
            return false
        }
        return BitUtils.isBitSet(externalFileAttributes.getOrThrow()[3], 5)
    }

    private func unzipFile(
        inputStream: ZipInputStream,
        outputFile: Path,
        progressMonitor: ProgressMonitor,
        buff: Array<Byte>
    ) {
        if (let Some(parentDir) <- outputFile.directoryName) {
            if (!Directory.exists(parentDir)) {
                Directory.create(parentDir, recursive: true)
            }
        }
        try (file = File(outputFile, OpenOption.CreateOrTruncate(true))) {
            let outputStream = BufferedOutputStream<File>(file)
            var readLength = inputStream.read(buff)
            while (readLength > 0) {
                outputStream.write(buff[0..readLength])
                progressMonitor.updateWorkCompleted(readLength)
                verifyIfTaskIsCancelled()
                readLength = inputStream.read(buff)
            }
            outputStream.flush()
        } catch (e: Exception) {
            if (File.exists(outputFile)) {
                File.delete(outputFile)
            }
            throw e
        }
    }

    private func verifyNextEntry(zipInputStream: ZipInputStream, fileHeader: FileHeader) {
        if (BitUtils.isBitSet(fileHeader.getGeneralPurposeFlag().getOrThrow()[0], 6)) {
            throw ZipException(
                "Entry with name ${fileHeader.getFileName()} is encrypted with Strong Encryption. Zip4j does not support Strong Encryption, as this is patented."
            )
        }
        var localFileHeader = zipInputStream.getNextEntry(fileHeader, false)
        if (localFileHeader.isNone()) {
            throw ZipException(
                "Could not read corresponding local file header for file header: ${fileHeader.getFileName()}")
        }

        if (!(fileHeader.getFileName() == (localFileHeader.getOrThrow().getFileName()))) {
            throw ZipException("File header and local file header mismatch")
        }
    }

    // TODO check Output Directory Structure
    private func checkOutputDirectoryStructure(outputFile: Path) {
        outputFile
        return
    }

    private func determineOutputFile(fileHeader: FileHeader, outputPath: String, newFileName: ?String): Path {
        var outputFileName = fileHeader.getFileName() ?? ""
        if (Zip4cjUtil.isStringNotNullAndNotEmpty(newFileName)) {
            outputFileName = newFileName.getOrThrow()
        }
        if (!Directory.exists(outputPath)) {
            Directory.create(outputPath)
        }
        return Path(outputPath).join(getFileNameWithSystemFileSeparators(outputFileName))
    }

    private func getFileNameWithSystemFileSeparators(fileNameToReplace: String): String {
        return fileNameToReplace.replace(":\\\\", "_").replace("/", FileSeparator).replace("\\\\", FileSeparator)
    }

    protected func getTask(): ProgressMonitorTask {
        return ProgressMonitorTask.EXTRACT_ENTRY
    }

    public func getZipModel(): ZipModel {
        return zipModel
    }
}
