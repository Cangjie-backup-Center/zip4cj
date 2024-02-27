package zip4cj.tasks

public class AddFilesToZipTask <: AbstractAddFileToZipTask<AddFilesToZipTaskParameters> {
    public AddFilesToZipTask(
        zipModel: ZipModel,
        password: ?Array<Char>,
        headerWriter: HeaderWriter,
        asyncTaskParameters: AsyncTaskParameters
    ) {
        super(zipModel, password, headerWriter, asyncTaskParameters)
    }

    protected func executeTask(taskParameters: AddFilesToZipTaskParameters, progressMonitor: ProgressMonitor) {
        verifyZipParameters(taskParameters.zipParameters)
        var filesToAdd = determineActualFilesToAdd(taskParameters)
        addFilesToZip(filesToAdd, progressMonitor, taskParameters.zipParameters, taskParameters.zip4cjConfig)
    }

    protected func calculateTotalWork(taskParameters: AddFilesToZipTaskParameters): Int64 {
        return calculateWorkForFiles(taskParameters.filesToAdd, taskParameters.zipParameters)
    }

    private func determineActualFilesToAdd(taskParameters: AddFilesToZipTaskParameters): ArrayList<Path> {
        var filesToAdd = ArrayList<Path>()

        for (inputFile in taskParameters.filesToAdd) {
            filesToAdd.append(inputFile)
            var isSymLink = FileUtils.isSymbolicLink(inputFile)
            var symbolicLinkAction = taskParameters.zipParameters.getSymbolicLinkAction()
            if (isSymLink && !(SymbolicLinkAction.INCLUDE_LINK_ONLY == (symbolicLinkAction))) {
                filesToAdd.appendAll(FileUtils.getFilesInDirectoryRecursive(inputFile, taskParameters.zipParameters))
            }
        }

        return filesToAdd
    }

    protected func getTask(): ProgressMonitorTask {
        return super.getTask()
    }
}
