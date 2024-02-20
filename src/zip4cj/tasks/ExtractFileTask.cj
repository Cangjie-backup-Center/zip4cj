package zip4cj.tasks

public class ExtractFileTask <: AbstractExtractFileTask<ExtractFileTaskParameters> {
    private var password: ?Array<Char>
    private var splitInputStream: SplitFileInputStream = unsafe { zeroValue<SplitFileInputStream>() }

    public ExtractFileTask(
        zipModel: ZipModel,
        password: ?Array<Char>,
        unzipParameters: UnzipParameters,
        asyncTaskParameters: AsyncTaskParameters
    ) {
        super(zipModel, unzipParameters, asyncTaskParameters)
        this.password = password
    }

    protected func executeTask(taskParameters: ExtractFileTaskParameters, progressMonitor: ProgressMonitor) {
        var fileHeadersUnderDirectory = getFileHeadersToExtract(taskParameters.fileToExtract)
        var zipInputStream = createZipInputStream(taskParameters.zip4jConfig)
        try {
            var readBuff = Array<Byte>(taskParameters.zip4jConfig.getBufferSize(), item: 0)
            for (fileHeader in fileHeadersUnderDirectory) {
                splitInputStream.prepareExtractionForFileHeader(fileHeader)
                var newFileName = determineNewFileName(taskParameters.newFileName.getOrThrow(), taskParameters.fileToExtract,
                    fileHeader)
                extractFile(zipInputStream, fileHeader, taskParameters.outputPath, newFileName, progressMonitor,
                    readBuff)
            }
        } finally {
            // TODO  Resource close
        }
    }

    protected func calculateTotalWork(taskParameters: ExtractFileTaskParameters): Int64 {
        var fileHeadersUnderDirectory = getFileHeadersToExtract(taskParameters.fileToExtract)
        return HeaderUtil.getTotalUncompressedSizeOfAllFileHeaders(fileHeadersUnderDirectory)
    }

    private func getFileHeadersToExtract(fileNameToExtract: String): ArrayList<FileHeader> {
        if (!FileUtils.isZipEntryDirectory(fileNameToExtract)) {
            var fileHeader = HeaderUtil.getFileHeader(getZipModel(), fileNameToExtract)
            if (fileHeader.isNone()) {
                throw ZipException("No file found with name " + fileNameToExtract + " in zip file", FILE_NOT_FOUND)
            }
            return ArrayList<FileHeader>([fileHeader.getOrThrow()])
        }

        return HeaderUtil.getFileHeadersUnderDirectory(
            getZipModel().getCentralDirectory().getOrThrow().getFileHeaders(),
            fileNameToExtract
        )
    }

    private func createZipInputStream(zip4jConfig: Zip4cjConfig): ZipInputStream {
        splitInputStream = UnzipUtil.createSplitInputStream(getZipModel())
        return ZipInputStream(splitInputStream, password, zip4jConfig)
    }

    private func determineNewFileName(
        newFileName: String,
        fileNameToExtract: String,
        fileHeaderBeingExtracted: FileHeader
    ): String {
        if (!Zip4cjUtil.isStringNotNullAndNotEmpty(newFileName)) {
            return newFileName
        }

        if (!FileUtils.isZipEntryDirectory(fileNameToExtract)) {
            return newFileName
        }

        var fileSeparator = InternalZipConstants.ZIP_FILE_SEPARATOR
        if (newFileName.endsWith(InternalZipConstants.ZIP_FILE_SEPARATOR)) {
            fileSeparator = ""
        }
        let str = fileHeaderBeingExtracted.getFileName().getOrThrow()
        var arr = str.split(fileNameToExtract, 2)
        return "${arr[0]}${newFileName + fileSeparator}${arr[1]}"
    }
}
