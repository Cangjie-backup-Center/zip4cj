package zip4cj.tasks

public class ExtractAllFilesTask <: AbstractExtractFileTask<ExtractAllFilesTaskParameters> {
    private let password: ?Array<Char>
    private var splitInputStream: SplitFileInputStream = unsafe { zeroValue<SplitFileInputStream>() }
    private var isSplitInputStream: Bool = false

    public init(
        zipModel: ZipModel,
        password: ?Array<Char>,
        unzipParameters: UnzipParameters,
        asyncTaskParameters: AsyncTaskParameters
    ) {
        super(zipModel, unzipParameters, asyncTaskParameters)
        this.password = password
    }

    protected func executeTask(taskParameters: ExtractAllFilesTaskParameters, progressMonitor: ProgressMonitor) {
        let zipInputStream = prepareZipInputStream(taskParameters.zip4jConfig)
        try {
            for (fileHeader in getZipModel().getCentralDirectory().getOrThrow().getFileHeaders()) {
                if (fileHeader.getFileName().getOrThrow().startsWith("__MACOSX")) {
                    progressMonitor.updateWorkCompleted(fileHeader.getUncompressedSize())
                    continue
                }

                splitInputStream.prepareExtractionForFileHeader(fileHeader)

                var readBuff = Array<Byte>(taskParameters.zip4jConfig.getBufferSize(), item: 0)
                extractFile(zipInputStream, fileHeader, taskParameters.outputPath, None, progressMonitor, readBuff)
                verifyIfTaskIsCancelled()
            }
        } finally {
            // TODO  Resource close
        }
    }

    protected func calculateTotalWork(taskParameters: ExtractAllFilesTaskParameters): Int64 {
        return HeaderUtil.getTotalUncompressedSizeOfAllFileHeaders(getZipModel().getCentralDirectory().getOrThrow().getFileHeaders())
    }

    private func prepareZipInputStream(zip4jConfig: Zip4cjConfig): ZipInputStream {
        splitInputStream = UnzipUtil.createSplitInputStream(getZipModel())
        if (let Some(fileHeader) <- getFirstFileHeader(getZipModel())) {
            splitInputStream.prepareExtractionForFileHeader(fileHeader)
        }
        return ZipInputStream(splitInputStream, password, zip4jConfig)
    }

    private func getFirstFileHeader(zipModel: ZipModel): ?FileHeader {
        if (zipModel.getCentralDirectory().getOrThrow().getFileHeaders().size == 0) {
            return None
        }
        return zipModel.getCentralDirectory().getOrThrow().getFileHeaders()[0]
    }
}
