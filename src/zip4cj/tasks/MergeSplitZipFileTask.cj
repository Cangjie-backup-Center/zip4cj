package zip4cj.tasks

public class MergeSplitZipFileTask <: AsyncZipTask<MergeSplitZipFileTaskParameters> {
    private let zipModel: ZipModel
    private let rawIO = RawIO()

    public MergeSplitZipFileTask(zipModel: ZipModel, asyncTaskParameters: AsyncTaskParameters) {
        super(asyncTaskParameters)
        this.zipModel = zipModel
    }

    protected func executeTask(taskParameters: MergeSplitZipFileTaskParameters, progressMonitor: ProgressMonitor): Unit {
        if (!zipModel.isSplitArchive()) {
            var e = ZipException("archive not a split zip file")
            progressMonitor.endProgressMonitor(e)
            throw e
        }
        try (outputStream = File(taskParameters.outputZipFile, OpenOption.CreateOrTruncate(true))) {
            var totalBytesWritten = 0
            var totalNumberOfSplitFiles = zipModel.getEndOfCentralDirectoryRecord().getNumberOfThisDisk()
            if (totalNumberOfSplitFiles <= 0) {
                throw ZipException("zip archive not a split zip file")
            }

            var signatureOverheadSplit = 0
            for (i in 0..totalNumberOfSplitFiles) {
                try (randomAccessFile = createSplitZipFileStream(zipModel, Int64(i))) {
                    var start = 0
                    var end = randomAccessFile.length

                    if (i == 0) {
                        if (Int64(rawIO.readIntLittleEndian(randomAccessFile)) == HeaderSignature.SPLIT_ZIP.getValue()) {
                            signatureOverheadSplit = 4
                            start = 4
                        } else {
                            randomAccessFile.seek(0)
                        }
                    }

                    if (i == totalNumberOfSplitFiles) {
                        end = zipModel.getEndOfCentralDirectoryRecord().getOffsetOfStartOfCentralDirectory()
                    }

                    FileUtils.copyFile(randomAccessFile, outputStream, start, end, progressMonitor, taskParameters.zip4cjConfig.getBufferSize())
                    totalBytesWritten += (end - start)
                    if (i == 0) {
                        updateFileHeaderOffsetsForIndex(zipModel.getCentralDirectory().getOrThrow().getFileHeaders(), 0, Int64(i),
                            signatureOverheadSplit)
                    } else {
                        updateFileHeaderOffsetsForIndex(zipModel.getCentralDirectory().getOrThrow().getFileHeaders(),
                            totalBytesWritten, Int64(i), signatureOverheadSplit)
                    }
                    verifyIfTaskIsCancelled()
                }
            }
            updateHeadersForMergeSplitFileAction(zipModel, totalBytesWritten, outputStream,
                taskParameters.zip4cjConfig.getCharset().getOrThrow())
            progressMonitor.endProgressMonitor()
        } catch (e: Exception) {
            throw ZipException(e.message)
        }
    }

    protected func calculateTotalWork(taskParameters: MergeSplitZipFileTaskParameters): Int64 {
        taskParameters
        if (!zipModel.isSplitArchive()) {
            return 0
        }

        var totalSize = 0
        for (i in 0..zipModel.getEndOfCentralDirectoryRecord().getNumberOfThisDisk()) {
            totalSize += FileInfo(getNextSplitZipFile(zipModel, Int64(i))).length
        }
        return totalSize
    }

    private func updateFileHeaderOffsetsForIndex(
        fileHeaders: ArrayList<FileHeader>,
        offsetToAdd: Int64,
        index: Int64,
        signatureOverheadSplit: Int64
    ) {
        for (fileHeader in fileHeaders) {
            if (fileHeader.getDiskNumberStart() == index) {
                fileHeader.setOffsetLocalHeader(fileHeader.getOffsetLocalHeader() + offsetToAdd - signatureOverheadSplit
                )
                fileHeader.setDiskNumberStart(0)
            }
        }
    }

    private func getNextSplitZipFile(zipModel: ZipModel, partNumber: Int64): Path {
        if (partNumber == Int64(zipModel.getEndOfCentralDirectoryRecord().getNumberOfThisDisk())) {
            return zipModel.getZipFile().getOrThrow()
        }

        var splitZipExtension = ".z0"
        if (partNumber >= 9) {
            splitZipExtension = ".z"
        }
        var rootZipFile = zipModel.getZipFile().getOrThrow().toString()
        var nextSplitZipFileName = String(
            zipModel.getZipFile().getOrThrow().toString().toRuneArray()[0..rootZipFile.lastIndexOf(".").getOrThrow()]) +
            splitZipExtension + "${partNumber + 1}"
        return Path(nextSplitZipFileName)
    }

    private func createSplitZipFileStream(zipModel: ZipModel, partNumber: Int64): RandomAccessFile {
        var splitFile = getNextSplitZipFile(zipModel, partNumber)
        return RandomAccessFile(splitFile, OpenOption.Open(true, false))
    }

    private func updateHeadersForMergeSplitFileAction(
        zipModel: ZipModel,
        totalBytesWritten: Int64,
        outputStream: OutputStream,
        charset: Charset
    ) {
        var newZipModel = zipModel.clone()
        newZipModel.getEndOfCentralDirectoryRecord().setOffsetOfStartOfCentralDirectory(totalBytesWritten)

        updateSplitZipModel(newZipModel, totalBytesWritten)

        var headerWriter: HeaderWriter = HeaderWriter()
        headerWriter.finalizeZipFileWithoutValidations(newZipModel, outputStream, charset)
    }

    private func updateSplitZipModel(zipModel: ZipModel, totalFileSize: Int64) {
        zipModel.setSplitArchive(false)
        updateSplitEndCentralDirectory(zipModel)

        if (zipModel.isZip64Format()) {
            updateSplitZip64EndCentralDirLocator(zipModel, totalFileSize)
            updateSplitZip64EndCentralDirRec(zipModel, totalFileSize)
        }
    }

    private func updateSplitEndCentralDirectory(zipModel: ZipModel) {
        var numberOfFileHeaders: Int64 = zipModel.getCentralDirectory().getOrThrow().getFileHeaders().size
        var endOfCentralDirectoryRecord: EndOfCentralDirectoryRecord = zipModel.getEndOfCentralDirectoryRecord()
        endOfCentralDirectoryRecord.setNumberOfThisDisk(0)
        endOfCentralDirectoryRecord.setNumberOfThisDiskStartOfCentralDir(0)
        endOfCentralDirectoryRecord.setTotalNumberOfEntriesInCentralDirectory(numberOfFileHeaders)
        endOfCentralDirectoryRecord.setTotalNumberOfEntriesInCentralDirectoryOnThisDisk(Int32(numberOfFileHeaders))
    }

    private func updateSplitZip64EndCentralDirLocator(zipModel: ZipModel, totalFileSize: Int64) {
        var zip64EndOfCentralDirectoryLocator: Zip64EndOfCentralDirectoryLocator = zipModel.
            getZip64EndOfCentralDirectoryLocator().getOrThrow()
        zip64EndOfCentralDirectoryLocator.setNumberOfDiskStartOfZip64EndOfCentralDirectoryRecord(0)
        zip64EndOfCentralDirectoryLocator.setOffsetZip64EndOfCentralDirectoryRecord(
            zip64EndOfCentralDirectoryLocator.getOffsetZip64EndOfCentralDirectoryRecord() + totalFileSize)
        zip64EndOfCentralDirectoryLocator.setTotalNumberOfDiscs(1)
    }

    private func updateSplitZip64EndCentralDirRec(zipModel: ZipModel, totalFileSize: Int64) {

        var zip64end: Zip64EndOfCentralDirectoryRecord = zipModel.
            getZip64EndOfCentralDirectoryRecord()
        zip64end.setNumberOfThisDisk(0)
        zip64end.setNumberOfThisDiskStartOfCentralDirectory(0)
        zip64end.setTotalNumberOfEntriesInCentralDirectoryOnThisDisk(
            zipModel.getEndOfCentralDirectoryRecord().getTotalNumberOfEntriesInCentralDirectory())
        zip64end.setOffsetStartCentralDirectoryWRTStartDiskNumber(
            zip64end.getOffsetStartCentralDirectoryWRTStartDiskNumber() + totalFileSize)
    }

    protected func getTask(): ProgressMonitorTask {
        return ProgressMonitorTask.MERGE_ZIP_FILES
    }
}
