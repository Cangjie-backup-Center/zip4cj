/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights resvered.
 */
package zip4cj.io.inputstream

public class UnzipUtil {
    private init() {}
    public static func createZipInputStream(zipModel: ZipModel, fileHeader: FileHeader, password: ?Array<Char>): ZipInputStream {
        var splitInputStream: ?SplitFileInputStream = None
        try {
            let split = createSplitInputStream(zipModel)
            splitInputStream = split
            split.prepareExtractionForFileHeader(fileHeader)
            let zipInputStream = ZipInputStream(split, password: password)
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
        if (let Some(zipFile) <- zipModel.getZipFile()) {
            if (zipFile.fileName.getOrThrow().endsWith(InternalZipConstants.SEVEN_ZIP_SPLIT_FILE_EXTENSION_PATTERN)) {
                return NumberedSplitFileInputStream(zipFile)
            }

            return ZipStandardSplitFileInputStream(zipFile, zipModel.isSplitArchive(),
                Int64(zipModel.getEndOfCentralDirectoryRecord().getNumberOfThisDisk()))
        } else {
            throw NoneValueException("zipFile is null")
        }
    }
}
