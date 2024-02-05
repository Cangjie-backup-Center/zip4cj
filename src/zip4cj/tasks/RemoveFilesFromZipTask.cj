package zip4cj.tasks

public class RemoveFilesFromZipTask <: AbstractModifyFileTask<RemoveFilesFromZipTaskParameters> {
    private let zipModel: ZipModel
    private let headerWriter: HeaderWriter

    public RemoveFilesFromZipTask(
        zipModel: ZipModel,
        headerWriter: HeaderWriter,
        asyncTaskParameters: AsyncTaskParameters
    ) {
        super(asyncTaskParameters)
        this.zipModel = zipModel
        this.headerWriter = headerWriter
    }

    protected func executeTask(taskParameters: RemoveFilesFromZipTaskParameters, progressMonitor: ProgressMonitor): Unit {
        if (zipModel.isSplitArchive()) {
            throw ZipException("This is a split archive. Zip file format does not allow updating split/spanned files")
        }

        var entriesToRemove: ArrayList<String> = filterNonExistingEntries(taskParameters.filesToRemove)

        if (entriesToRemove.isEmpty()) {
            return
        }

        var temporaryZipFile: Path = getTemporaryFile(zipModel.getZipFile().getOrThrow().toString())
        var successFlag: Bool = false

        try {
            var outputStream: SplitOutputStream = SplitOutputStream(temporaryZipFile)
            var inputStream: RandomAccessFile = RandomAccessFile(
                zipModel.getZipFile().getOrThrow().toString(),
                OpenOption.Open(true, false)
            )
            var currentFileCopyPointer: Int64 = 0
            var sortedFileHeaders: ArrayList<FileHeader> = cloneAndSortFileHeadersByOffset(
                zipModel.getCentralDirectory().getFileHeaders())

            for (fileHeader in sortedFileHeaders) {
                var lengthOfCurrentEntry: Int64 = getOffsetOfNextEntry(sortedFileHeaders, fileHeader, zipModel) -
                    outputStream.getFilePointer()
                if (shouldEntryBeRemoved(fileHeader, entriesToRemove)) {
                    updateHeaders(sortedFileHeaders, fileHeader, lengthOfCurrentEntry)

                    ListRmove(zipModel.getCentralDirectory().getFileHeaders(), fileHeader)
                    currentFileCopyPointer += lengthOfCurrentEntry
                } else {
                    // copy complete entry without any changes
                    currentFileCopyPointer += super.copyFile(inputStream, outputStream, currentFileCopyPointer,
                        lengthOfCurrentEntry, progressMonitor, taskParameters.zip4jConfig.getBufferSize())
                }
                verifyIfTaskIsCancelled()
            }
            headerWriter.finalizeZipFile(zipModel, outputStream, taskParameters.zip4jConfig.getCharset())
            successFlag = true
        } finally {
            cleanupFile(successFlag, zipModel.getZipFile().getOrThrow(), temporaryZipFile)
        }
    }

    protected func calculateTotalWork(taskParameters: RemoveFilesFromZipTaskParameters): Int64 {
        let file: File = File(zipModel.getZipFile().getOrThrow(), OpenOption.Open(true, false))
        return file.length
    }

    private func filterNonExistingEntries(filesToRemove: Collection<String>): ArrayList<String> {
        var filteredFilesToRemove = ArrayList<String>()

        for (fileToRemove in filesToRemove) {
            if (HeaderUtil.getFileHeader(zipModel, fileToRemove).isSome()) {
                filteredFilesToRemove.append(fileToRemove)
            }
        }

        return filteredFilesToRemove
    }

    private func shouldEntryBeRemoved(fileHeaderToBeChecked: FileHeader, fileNamesToBeRemoved: ArrayList<String>): Bool {
        for (fileNameToBeRemoved in fileNamesToBeRemoved) {
            // If any of the files to be removed is a directory, check if the fileHeaderToBeChecked is a sub-file or
            // a sub-directory of that directory
            if (fileNameToBeRemoved.endsWith(InternalZipConstants.ZIP_FILE_SEPARATOR) &&
                fileHeaderToBeChecked.getFileName().getOrThrow().startsWith(fileNameToBeRemoved)) {
                return true
            } else if (fileHeaderToBeChecked.getFileName().getOrThrow() == (fileNameToBeRemoved)) {
                return true
            }
        }

        return false
    }

    private func updateHeaders(
        sortedFileHeaders: ArrayList<FileHeader>,
        fileHeaderThatWasRemoved: FileHeader,
        offsetToSubtract: Int64
    ) {
        updateOffsetsForAllSubsequentFileHeaders(sortedFileHeaders, zipModel, fileHeaderThatWasRemoved,
            negate(offsetToSubtract))

        var endOfCentralDirectoryRecord: EndOfCentralDirectoryRecord = zipModel.getEndOfCentralDirectoryRecord()
        endOfCentralDirectoryRecord.setOffsetOfStartOfCentralDirectory(
            endOfCentralDirectoryRecord.getOffsetOfStartOfCentralDirectory() - offsetToSubtract)
        endOfCentralDirectoryRecord.setTotalNumberOfEntriesInCentralDirectory(
            endOfCentralDirectoryRecord.getTotalNumberOfEntriesInCentralDirectory() - 1)

        if (endOfCentralDirectoryRecord.getTotalNumberOfEntriesInCentralDirectoryOnThisDisk() > 0) {
            endOfCentralDirectoryRecord.setTotalNumberOfEntriesInCentralDirectoryOnThisDisk(
                endOfCentralDirectoryRecord.getTotalNumberOfEntriesInCentralDirectoryOnThisDisk() - 1)
        }

        if (zipModel.isZip64Format()) {
            zipModel.getZip64EndOfCentralDirectoryRecord().setOffsetStartCentralDirectoryWRTStartDiskNumber(
                zipModel.getZip64EndOfCentralDirectoryRecord().getOffsetStartCentralDirectoryWRTStartDiskNumber() -
                offsetToSubtract)

            zipModel.getZip64EndOfCentralDirectoryRecord().setTotalNumberOfEntriesInCentralDirectoryOnThisDisk(
                zipModel.getZip64EndOfCentralDirectoryRecord().getTotalNumberOfEntriesInCentralDirectory() - 1)

            zipModel.getZip64EndOfCentralDirectoryLocator().getOrThrow().setOffsetZip64EndOfCentralDirectoryRecord(
                zipModel.getZip64EndOfCentralDirectoryLocator().getOrThrow().getOffsetZip64EndOfCentralDirectoryRecord() -
                offsetToSubtract)
        }
    }

    private func negate(val: Int64): Int64 {
        if (val == -9223372036854775808) {
            throw ArithmeticException("long overflow")
        }

        return -val
    }

    protected func getTask(): ProgressMonitorTask {
        return ProgressMonitorTask.REMOVE_ENTRY
    }
}
