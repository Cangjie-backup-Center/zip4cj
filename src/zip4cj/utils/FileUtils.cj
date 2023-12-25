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

from std import fs.*
from std import collection.*
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
    public static func getFilePath(outPath: String, fileName: String): String {
        var temp = outPath.replace("\\\\", "/")
        var arrayChar: Array<Char> = temp.toRuneArray()
        arrayChar.reverse()
        var lastIndex = 0
        for (i in 0..arrayChar.size) {
            if (arrayChar[i] == '/') {
                lastIndex = arrayChar.size - i - 1
                break
            }
        }
        var lastName = String(temp.toRuneArray().slice(lastIndex, temp.toRuneArray().size - lastIndex))
        if (fileName.startsWith(lastName)) {
            return String(temp.toRuneArray().slice(0, lastIndex)) + "/" + fileName
        } else {
            return temp + "/" + fileName
        }
    }

    /*
     * Get file name
     *
     * @param path File path
     *
     * @return Returns the file name of a string type
     * @since 0.28.4
     */
    public static func getFileName(path: String): String {
        return FileInfo(path).path.fileName.getOrThrow()
    }

    /*
     * Read files according to the file path
     *
     * @param path File path
     *
     * @return Returns the contents of the file. Type is Array<UInt8>
     * @since 0.28.4
     */
    public static func readFile(path: String): Array<UInt8> {
        var data = Array<UInt8>()
        var or = File.openRead(path)
        if (or.canRead()) {
            try {
                or.seek(SeekPosition.Begin(0))
                data = or.readToEnd()
                or.flush()
            } catch (e: Exception) {
                throw Exception("file read failed: ${e.message}")
            }
        }
        or.close()
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
    public static func writeFile(outData: Array<UInt8>, filePath: String) {
        var fileInfo = Path(filePath)
        if (!File.exists(fileInfo)) {
            var file = File.create(fileInfo)
            file.close()
        }
        try {
            File.writeTo(fileInfo, outData, openOption: OpenOption.Truncate(true))
        } catch (e: Exception) {
            throw Exception("file write failed: ${e.message}")
        }
    }
}
