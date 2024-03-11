package zip4cj

from std import collection.*
from std import io.*
from std import fs.*
from charset import charset.*
from charset import charset.encoding.*
public import zip4cj.io.inputstream.*
public import zip4cj.io.outputstream.*
public import zip4cj.util.*
public import zip4cj.model.*
public import zip4cj.tasks.*
public import zip4cj.util.*
public import zip4cj.crypto.*
public import zip4cj.headers.*
public import zip4cj.progress.*
public import zip4cj.exception.*
public import zip4cj.model.enums.*
public import zip4cj.util.internals.*

public class ZipFile {
    private let zipFile: Path

    private var zipModelOpt: ZipModel = unsafe { zeroValue<ZipModel>() }

    private prop zipModel: ZipModel {
        get() {
            if (isNullzipModel) {
                throw NoneValueException("ZipModel not initialized.")
            }
            this.zipModelOpt
        }
    }
    private var isNullzipModel: Bool = true
    private var isEncrypte: Bool = false
    private var progressMonitor: ProgressMonitor
    private var runInThread: Bool
    private var password: ?Array<Char>
    private let headerWriter = HeaderWriter()
    private var charset: ?Charset = None
    private var executorService: ExecutorService = unsafe { zeroValue<ExecutorService>() }
    private var bufferSize: Int64 = InternalZipConstants.BUFF_SIZE
    private let openInputStreams = ArrayList<InputStream>()
    private var useUtf8CharsetForPasswords = InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING

    public init(zipFile: String, password!: ?Array<Char> = None) {
        this(Path(zipFile), password: password)
    }

    public init(zipFile: Path, password!: ?Array<Char> = None) {
        this.zipFile = zipFile
        this.password = password
        this.runInThread = false
        this.progressMonitor = ProgressMonitor()
    }

    public func createSplitZipFile(
        filesToAdd: Collection<Path>,
        parameters: ZipParameters,
        splitArchive: Bool,
        splitLength: Int64
    ) {
        if (File.exists(zipFile)) {
            throw ZipException(
                "zip file: ${zipFile} already exists. To add files to existing zip file use addFile method")
        }
        if (filesToAdd.size == 0) {
            throw ZipException("input file List is None, cannot create zip file")
        }
        createNewZipModel()
        zipModel.setSplitArchive(splitArchive)
        zipModel.setSplitLength(if (splitArchive) {
            splitLength
        } else {
            -1
        })
        AddFilesToZipTask(zipModel, password, headerWriter, buildAsyncParameters()).execute(
            AddFilesToZipTaskParameters(filesToAdd, parameters, buildConfig()))
    }

    public func createSplitZipFile(
        inputStream: InputStream,
        parameters: ZipParameters,
        splitArchive: Bool,
        splitLength: Int64
    ) {
        if (File.exists(zipFile)) {
            throw ZipException(
                "zip file: ${zipFile} already exists. To add files to existing zip file use addFile method")
        }
        createNewZipModel()
        zipModel.setSplitArchive(splitArchive)
        zipModel.setSplitLength(if (splitArchive) {
            splitLength
        } else {
            -1
        })
        AddStreamToZipTask(zipModel, password, headerWriter, buildAsyncParameters()).execute(
        AddStreamToZipTaskParameters(inputStream, parameters, buildConfig()))
    }

    public func createSplitZipFileFromFolder(
        folderToAdd: Path,
        parameters: ZipParameters,
        splitArchive: Bool,
        splitLength: Int64
    ) {
        createNewZipModel()
        zipModel.setSplitArchive(splitArchive)
        if (splitArchive) {
            zipModel.setSplitLength(splitLength)
        }
        addFolder(folderToAdd, parameters: parameters, checkSplitArchive: false)
    }

    public func addFile(fileToAdd: String, parameters!: ZipParameters = ZipParameters()) {
        if (!Zip4cjUtil.isStringNotNullAndNotEmpty(fileToAdd)) {
            throw ZipException("file to add is None or empty")
        }
        addFiles([Path(fileToAdd)], parameters: parameters)
    }

    public func addFile(fileToAdd: Path, parameters!: ZipParameters = ZipParameters()) {
        addFiles([fileToAdd], parameters: parameters)
    }

    public func addFiles(filesToAdd: Collection<Path>, parameters!: ZipParameters = ZipParameters()) {
        if (filesToAdd.size == 0) {
            throw ZipException("input file List is None or empty")
        }
        this.readZipInfo()
        if (File.exists(zipFile) && zipModel.isSplitArchive()) {
            throw ZipException("Zip file already exists. Zip file format does not allow updating split/spanned files")
        }
        AddFilesToZipTask(zipModel, password, headerWriter, buildAsyncParameters()).execute(
            AddFilesToZipTaskParameters(filesToAdd, parameters, buildConfig()))
    }

    public func addFolder(folderToAdd: Path, parameters!: ZipParameters = ZipParameters(), checkSplitArchive!: Bool = true) {
        if (!folderToAdd.isDirectory()) {
            throw ZipException("input folder is not a directory")
        }
        this.readZipInfo()
        if (checkSplitArchive) {
            if (zipModel.isSplitArchive()) {
                throw ZipException(
                    "This is a split archive. Zip file format does not allow updating split/spanned files")
            }
        }
        AddFolderToZipTask(zipModel, password, headerWriter, buildAsyncParameters()).execute(
            AddFolderToZipTaskParameters(folderToAdd, parameters, buildConfig()))
    }

    public func addStream(inputStream: InputStream, parameters: ZipParameters) {
        this.setRunInThread(false)
        this.readZipInfo()
        if (File.exists(zipFile) && zipModel.isSplitArchive()) {
            throw ZipException("Zip file already exists. Zip file format does not allow updating split/spanned files")
        }
        AddStreamToZipTask(zipModel, password, headerWriter, buildAsyncParameters()).execute(
            AddStreamToZipTaskParameters(inputStream, parameters, buildConfig()));
    }

    public func extractAll(destinationPath: String, unzipParameters!: UnzipParameters = UnzipParameters()) {
        if (!Zip4cjUtil.isStringNotNullAndNotEmpty(destinationPath)) {
            throw ZipException("output path is None or invalid")
        }
        if (!Zip4cjUtil.createDirectoryIfNotExists(Path(destinationPath))) {
            throw ZipException("invalid output path")
        }
        if (isNullzipModel) {
            this.readZipInfo()
        }
        // Throw an exception if zipModel is still None
        if (isNullzipModel) {
            throw ZipException("Internal error occurred when extracting zip file")
        }
        ExtractAllFilesTask(zipModel, password, unzipParameters, buildAsyncParameters()).execute(
            ExtractAllFilesTaskParameters(destinationPath, buildConfig()))
    }

    public func extractFile(
        fileHeader: FileHeader,
        destinationPath: String,
        newFileName!: ?String = None,
        parameters!: UnzipParameters = UnzipParameters()
    ) {
        extractFile(fileHeader.getFileName().getOrThrow(), destinationPath, newFileName: newFileName, parameters: parameters)
    }

    public func extractFile(
        fileName: String,
        destinationPath: String,
        newFileName!: ?String = None,
        parameters!: UnzipParameters = UnzipParameters()
    ) {
        
        if (!Zip4cjUtil.isStringNotNullAndNotEmpty(fileName)) {
            throw ZipException("file to extract is None or empty, cannot extract file")
        }
        if (!Zip4cjUtil.isStringNotNullAndNotEmpty(destinationPath)) {
            throw ZipException("destination path is empty or None, cannot extract file")
        }
        this.readZipInfo()
        ExtractFileTask(zipModel, password, parameters, buildAsyncParameters()).execute(
            ExtractFileTaskParameters(destinationPath, fileName, newFileName, buildConfig()));
    }

    public func getFileHeaders(): ArrayList<FileHeader> {
        readZipInfo()
        match(zipModel.getCentralDirectory()) {
            case Some(v) => v.getFileHeaders()
            case None => ArrayList<FileHeader>()
        }
    }

    public func getFileHeader(fileName: String ): ?FileHeader {
        if (!Zip4cjUtil.isStringNotNullAndNotEmpty(fileName)) {
            throw ZipException("file name is empty or None, cannot remove file")
        }
        readZipInfo()
        if (zipModel.getCentralDirectory().isNone()) {
            return None
        }
        return HeaderUtil.getFileHeader(zipModel, fileName)
    }

    public func isEncrypted(): Bool {
        if (isNullzipModel) {
            readZipInfo()
            if (isNullzipModel) {
                throw ZipException("Zip Model is null")
            }
        }
        match (zipModel.getCentralDirectory()) {
            case Some(v) => 
                for (fileHeader in v.getFileHeaders() where fileHeader.isEncrypted()) {
                    isEncrypte = true
                    break
                }
            case None => throw ZipException("invalid zip file")
        }
        return isEncrypte
    }

    public func isSplitArchive(): Bool {
        if (isNullzipModel) {
            this.readZipInfo()
            if (isNullzipModel) {
                throw ZipException("Zip Model is None")
            }
        }
        return zipModel.isSplitArchive()
    }

    public func removeFile(fileHeader: FileHeader) {
        removeFile(fileHeader.getFileName().getOrThrow())
    }

    public func removeFile(fileName: String) {
        if (!Zip4cjUtil.isStringNotNullAndNotEmpty(fileName)) {
            throw ZipException("file name is empty or None, cannot remove file")
        }
        removeFiles([fileName])
    }

    public func removeFiles(fileNames: Collection<String>) {
        if (fileNames.isEmpty()) {
            return
        }
        if (isNullzipModel) {
            this.readZipInfo()
        }
        if (zipModel.isSplitArchive()) {
            throw ZipException("Zip file format does not allow updating split/spanned files")
        }
        RemoveFilesFromZipTask(zipModel, headerWriter, buildAsyncParameters()).execute(
            RemoveFilesFromZipTaskParameters(fileNames, buildConfig()))
    }

    public func renameFile(fileHeader: FileHeader, newFileName: String) {
        if (let Some(v) <- fileHeader.getFileName()) {
            renameFile(v, newFileName)
        } else {
            throw NoneValueException("The fileName of the FileHeader class is None.")
        }
    }

    public func renameFile(fileNameToRename: String, newFileName: String) {
        if (Zip4cjUtil.isStringNullOrEmpty(fileNameToRename)) {
            throw ZipException("file name to be changed is None or empty")
        }
        if (Zip4cjUtil.isStringNullOrEmpty(newFileName)) {
            throw ZipException("newFileName is None or empty")
        }
        renameFiles(HashMap<String, String>([(fileNameToRename, newFileName)]))
    }

    public func renameFiles(fileNamesMap: Map<String, String>) {
        if (fileNamesMap.size == 0) {
            return
        }
        this.readZipInfo()
        if (zipModel.isSplitArchive()) {
            throw ZipException("Zip file format does not allow updating split/spanned files")
        }
        var asyncTaskParameters: AsyncTaskParameters = buildAsyncParameters()
        RenameFilesTask(zipModel, headerWriter, RawIO(), asyncTaskParameters).execute(
            RenameFilesTaskParameters(fileNamesMap, buildConfig()))
    }

    public func mergeSplitFiles(outputZipFile: Path) {
        if (File.exists(outputZipFile)) {
            throw ZipException("output Zip File already exists")
        }
        this.readZipInfo()
        if (this.isNullzipModel) {
            throw ZipException("zip model is None, corrupt zip file?")
        }
        MergeSplitZipFileTask(zipModel, buildAsyncParameters()).execute(
            MergeSplitZipFileTaskParameters(outputZipFile, buildConfig()))
    }

    public func setComment(comment: String): Unit {
        if (!File.exists(this.zipFile)) {
            throw ZipException("zip file does not exist, cannot set comment for zip file")
        }
        readZipInfo()
        SetCommentTask(zipModel, buildAsyncParameters()).execute(
            SetCommentTaskTaskParameters(comment, buildConfig()))
    }

    public func getComment(): String {
        if (!File.exists(this.zipFile)) {
            throw ZipException("zip file does not exist, cannot read comment")
        }
        readZipInfo()
        return zipModel.getEndOfCentralDirectoryRecord().getComment()
    }


    public func getInputStream(fileHeader: FileHeader): ZipInputStream {
        this.readZipInfo()
        if (isNullzipModel) {
            throw ZipException("zip model is None, cannot get inputstream")
        }
        var zipInputStream = UnzipUtil.createZipInputStream(zipModel, fileHeader, password)
        openInputStreams.append(zipInputStream)
        return zipInputStream
    }

    public func isValidZipFile(): Bool {
        if (!File.exists(zipFile)) {
            return false
        }
        try {
            this.readZipInfo()
            if (zipModel.isSplitArchive() && !this.verifyAllSplitFilesOfZipExists(this.getSplitZipFiles())) {
                return false
            }
            return true
        } catch (e: Exception) {
            return false
        }
    }
    public func getSplitZipFiles(): ArrayList<Path> {
        this.readZipInfo()
        return FileUtils.getSplitZipFiles(zipModel)
    }

    public func close(): Unit {
        for (input in openInputStreams) {
            match ((input as Resource)) {
                case Some(v) => v.close()
                case None => ()
            }
        }
        openInputStreams.clear()
    }

    public func setPassword(password: ?Array<Char>) {
        this.password = password
    }

    public func getBufferSize() {
        return bufferSize
    }

    public func setBufferSize(bufferSize: Int64) {
        if (bufferSize < InternalZipConstants.MIN_BUFF_SIZE) {
            throw IllegalArgumentException(
                "Buffer size cannot be less than ${InternalZipConstants.MIN_BUFF_SIZE} bytes")
        }
        this.bufferSize = bufferSize
    }

    private func readZipInfo() {
        if (!isNullzipModel) {
            return 
        }
        try (randomAccessFile = initializeRandomAccessFileForHeaderReading(zipFile)) {
            var headerReader = HeaderReader()
            this.zipModelOpt = headerReader.readAllHeaders(randomAccessFile, buildConfig())
            isNullzipModel = false
            zipModel.setZipFile(zipFile)
        } catch (e: ZipException) {
            throw e
        } catch (e: IOException | ZipIOException) {
            throw ZipException(e.message)
        }
    }

    private func createNewZipModel() {
        this.zipModelOpt = ZipModel()
        isNullzipModel = false
        zipModel.setZipFile(zipFile)
    }

    private func buildAsyncParameters(): AsyncTaskParameters {
        if (runInThread) {
            executorService = ExecutorService.new()
        }
        return AsyncTaskParameters(executorService, runInThread, progressMonitor)
    }

    private func verifyAllSplitFilesOfZipExists(allSplitFiles: ArrayList<Path>): Bool {
        for (splitFile in allSplitFiles) {
            if (!File.exists(splitFile)) {
                return false
            }
        }
        return true
    }

    public func getProgressMonitor(): ProgressMonitor {
        return progressMonitor
    }

    public func isRunInThread(): Bool {
        return runInThread
    }

    public func setRunInThread(runInThread: Bool) {
        this.runInThread = runInThread
    }

    public func getFile() {
        return zipFile
    }

    public func getCharset(): Charset {
        if (charset.isNone()) {
            return InternalZipConstants.CHARSET_UTF_8
        }
        return charset.getOrThrow()
    }

    public func setCharset(charset: Charset) {
        this.charset = charset
    }

    public func getExecutorService(): ExecutorService {
        return executorService
    }

    public func toString(): String {
        return zipFile.toString()
    }

    private func buildConfig(): Zip4cjConfig {
        return Zip4cjConfig(charset, bufferSize, useUtf8CharsetForPasswords)
    }

    public func isUseUtf8CharsetForPasswords(): Bool {
        return useUtf8CharsetForPasswords
    }

    public func setUseUtf8CharsetForPasswords(useUtf8CharsetForPasswords: Bool) {
        this.useUtf8CharsetForPasswords = useUtf8CharsetForPasswords
    }
}

