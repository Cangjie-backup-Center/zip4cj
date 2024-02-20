package zip4cj.tasks

public abstract class AbstractZipTaskParameters {
    protected var zip4jConfig: Zip4cjConfig

    protected init(zip4jConfig: Zip4cjConfig) {
        this.zip4jConfig = zip4jConfig
    }
}

public class ExtractAllFilesTaskParameters <: AbstractZipTaskParameters {
    let outputPath: String

    public ExtractAllFilesTaskParameters(outputPath: String, zip4jConfig: Zip4cjConfig) {
        super(zip4jConfig)
        this.outputPath = outputPath
    }
}

public class RemoveFilesFromZipTaskParameters <: AbstractZipTaskParameters {
    let filesToRemove: Collection<String>

    public init(filesToRemove: Collection<String>, zip4jConfig: Zip4cjConfig) {
        super(zip4jConfig)
        this.filesToRemove = filesToRemove
    }
}

public class AddFolderToZipTaskParameters <: AbstractZipTaskParameters {
    let folderToAdd: Path
    let zipParameters: ZipParameters

    public init(folderToAdd: Path, zipParameters: ZipParameters, zip4jConfig: Zip4cjConfig) {
        super(zip4jConfig)
        this.folderToAdd = folderToAdd
        this.zipParameters = zipParameters
    }
}

public class AddStreamToZipTaskParameters <: AbstractZipTaskParameters {
    let inputStream: InputStream
    let zipParameters: ZipParameters

    public AddStreamToZipTaskParameters(
        inputStream: InputStream,
        zipParameters: ZipParameters,
        zip4jConfig: Zip4cjConfig
    ) {
        super(zip4jConfig)
        this.inputStream = inputStream
        this.zipParameters = zipParameters
    }
}

public class ExtractFileTaskParameters <: AbstractZipTaskParameters {
    var outputPath: String
    var fileToExtract: String
    var newFileName: ?String

    public ExtractFileTaskParameters(
        outputPath: String,
        fileToExtract: String,
        newFileName: ?String,
        zip4jConfig: Zip4cjConfig
    ) {
        super(zip4jConfig)
        this.outputPath = outputPath
        this.fileToExtract = fileToExtract
        this.newFileName = newFileName
    }
}

public class MergeSplitZipFileTaskParameters <: AbstractZipTaskParameters {
    var outputZipFile: Path

    public MergeSplitZipFileTaskParameters(outputZipFile: Path, zip4jConfig: Zip4cjConfig) {
        super(zip4jConfig)
        this.outputZipFile = outputZipFile
    }
}

public class RenameFilesTaskParameters <: AbstractZipTaskParameters {
    let fileNamesMap: Map<String, String>

    public RenameFilesTaskParameters(fileNamesMap: Map<String, String>, zip4jConfig: Zip4cjConfig) {
        super(zip4jConfig)
        this.fileNamesMap = fileNamesMap
    }
}

public class SetCommentTaskTaskParameters <: AbstractZipTaskParameters {
    var comment: String

    public SetCommentTaskTaskParameters(comment: String, zip4jConfig: Zip4cjConfig) {
        super(zip4jConfig)
        this.comment = comment
    }
}

public class AddFilesToZipTaskParameters <: AbstractZipTaskParameters {
    let filesToAdd: Collection<Path>
    let zipParameters: ZipParameters

    public init(filesToAdd: Collection<Path>, zipParameters: ZipParameters, zip4jConfig: Zip4cjConfig) {
        super(zip4jConfig)
        this.filesToAdd = filesToAdd
        this.zipParameters = zipParameters
    }
}
