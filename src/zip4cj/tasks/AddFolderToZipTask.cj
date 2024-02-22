package zip4cj.tasks

public class AddFolderToZipTask <: AbstractAddFileToZipTask<AddFolderToZipTaskParameters> {
    public AddFolderToZipTask(
        zipModel: ZipModel,
        password: ?Array<Char>,
        headerWriter: HeaderWriter,
        asyncTaskParameters: AsyncTaskParameters
    ) {
        super(zipModel, password, headerWriter, asyncTaskParameters)
    }

    protected func executeTask(taskParameters: AddFolderToZipTaskParameters, progressMonitor: ProgressMonitor) {
        var filesToAdd = getFilesToAdd(taskParameters)
        setDefaultFolderPath(taskParameters)
        addFilesToZip(filesToAdd, progressMonitor, taskParameters.zipParameters, taskParameters.zip4cjConfig)
    }

    protected func calculateTotalWork(taskParameters: AddFolderToZipTaskParameters): Int64 {
        var filesToAdd = getFilesToAdd(taskParameters)

        if (taskParameters.zipParameters.isIncludeRootFolder()) {
            filesToAdd.append(taskParameters.folderToAdd)
        }

        return calculateWorkForFiles(filesToAdd, taskParameters.zipParameters)
    }

    private func setDefaultFolderPath(taskParameters: AddFolderToZipTaskParameters) {
        var folderToAdd = taskParameters.folderToAdd
        let rootFolderPath: Path = if (taskParameters.zipParameters.isIncludeRootFolder()) {
            var parentFile = folderToAdd.toCanonical().directoryName
            if (parentFile.isNone()) {
                folderToAdd.toCanonical()
            } else {
                folderToAdd.toCanonical().directoryName.getOrThrow().toCanonical()
            }
        } else {
            folderToAdd.toCanonical()
        }

        taskParameters.zipParameters.setDefaultFolderPath(rootFolderPath.toString())
    }

    private func getFilesToAdd(taskParameters: AddFolderToZipTaskParameters): ArrayList<Path> {
        // TODO getFilesInDirectoryRecursive
        var filesToAdd: ArrayList<Path> = FileUtils.getFilesInDirectoryRecursive(
            taskParameters.folderToAdd,
            taskParameters.zipParameters
        )
        if (taskParameters.zipParameters.isIncludeRootFolder()) {
            filesToAdd.append(taskParameters.folderToAdd)
        }

        return filesToAdd
    }
}
