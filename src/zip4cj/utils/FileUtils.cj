/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

/**
 * @file
 *
 * This is a class that provides file operations.
 * Provide some methods, such as getFilePath getFileName readFile writeFile.
 */

package zip4cj.utils
from std import io.*

/*
 * The class is providing some methods of file operations.
 * @since 0.28.4
 */
public open class FileUtils {

    /*
     * Get file path
     *
     * @param outPath File path
     * @param fileName File name
     *
     * @return Returns the file path of string type
     * @since 0.28.4
     */
    public static  func getFilePath(outPath: String, fileName: String): String {
        if (outPath.contains("/")) {
            var lastIndex = outPath.lastIndexOf("/")
            match (lastIndex) {
                case Some(index) =>
                    var lastName = outPath.slice(index, outPath.size() - index).toString()
                    if (fileName.startsWith(lastName)) {
                        return outPath.slice(0, index) + "/" + fileName
                    } else {
                        return outPath + "/" + fileName
                    }
                case None =>
                    throw RuntimeException("Get file path exception!")
            }
        } else if (outPath.contains("\\")) {
            var lastIndex = outPath.lastIndexOf("\\")
            match (lastIndex) {
                case Some(index) =>
                    var lastName = outPath.slice(index, outPath.size() - index).toString()
                    if (fileName.startsWith(lastName)) {
                        return outPath.slice(0, index) + "\\" + fileName
                    } else {
                        return outPath + "\\" + fileName
                    }
                case None =>
                    throw RuntimeException("Get file path exception!")
            }
        }
        return ""
    }

    /*
     * Get file name
     *
     * @param path File path
     *
     * @return Returns the file name of a string type
     * @since 0.28.4
     */
    public static  func getFileName(path: String): String {
        var start = 0
        if (path.contains("\\")) {
            match (path.lastIndexOf('\\')) {
                case Some(value) => start = value
                case None => start = 0
            }
        } else {
            match (path.lastIndexOf('/')) {
                case Some(value) => start = value
                case None => start = 0
            }
        }
        return path.slice(start + 1, path.size() - start - 1).toString()
    }

    /*
     * Read files according to the file path
     *
     * @param path File path
     *
     * @return Returns the contents of the file. Type is Array<UInt8>
     * @since 0.28.4
     */
    public static  func readFile(path: String): Array<UInt8> {
        var data = Array<UInt8>()
        var fs = FileStream(path, ReadOnly)
        var readnum: Int64 = 0
        if (fs.openFile()) {
            var size = fs.seek(0, EndPos)
            fs.seek(0, BeginPos)
            data = Array<UInt8>(size, {i => 0})
            readnum = fs.read(data, 0, size)
            if (readnum != size) {
                println("read file failed: ${path}")
            }
            fs.flush()
        }
        fs.close()
        return data
    }

    /*
     * Writes data to a file
     *
     * @param outData content
     * @param filePath Content output path
     *
     * @since 0.28.4
     */
    public static  func writeFile(outData: Array<UInt8>, filePath: String) {
        var fileInfo = FileInfo(filePath)
        if (!fileInfo.exist()) {
            fileInfo.create()
        }
        var writeFile = FileStream(fileInfo)
        if (writeFile.openFile()) {
            writeFile.write(outData)
            writeFile.flush()
        }
        writeFile.close()
    }
}
