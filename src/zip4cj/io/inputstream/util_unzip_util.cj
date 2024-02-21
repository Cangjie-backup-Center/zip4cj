package zip4cj.io.inputstream

public class UnzipUtil {
    private init() {}
    public static func createZipInputStream(zipModel: ZipModel, fileHeader: FileHeader, password: ?Array<Char>): ZipInputStream {
        var splitInputStream: ?SplitFileInputStream = None
        try {
            splitInputStream = createSplitInputStream(zipModel)
            splitInputStream.getOrThrow().prepareExtractionForFileHeader(fileHeader)

            var zipInputStream = ZipInputStream(splitInputStream.getOrThrow(), password)
            if (zipInputStream.getNextEntry(fileHeader, false).isNone()) {
                throw ZipException("Could not locate local file header for corresponding file header")
            }
            return zipInputStream
        } catch (e: IOException | ZipIOException) {
            if (let Some(v) <- splitInputStream) {
                v.close()
            }
            throw e
        }
    }

    public static func applyFileAttributes(fileHeader: FileHeader, path: Path) {
        try {
            FileUtils.setFileAttributes(path, fileHeader.getExternalFileAttributes().getOrThrow())
            FileUtils.setFileLastModifiedTime(path, fileHeader.getLastModifiedTime())
        } catch (e: Exception) {
            FileUtils.setFileLastModifiedTimeWithoutNio(path, fileHeader.getLastModifiedTime())
        }
    }

    public static func createSplitInputStream(zipModel: ZipModel): SplitFileInputStream {
        var zipFile = zipModel.getZipFile().getOrThrow()

        if (zipFile.fileName.getOrThrow().endsWith(InternalZipConstants.SEVEN_ZIP_SPLIT_FILE_EXTENSION_PATTERN)) {
            return NumberedSplitFileInputStream(zipModel.getZipFile().getOrThrow())
        }

        return ZipStandardSplitFileInputStream(zipModel.getZipFile().getOrThrow(), zipModel.isSplitArchive(),
            Int64(zipModel.getEndOfCentralDirectoryRecord().getNumberOfThisDisk()))
    }
}
