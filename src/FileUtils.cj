package zip4cj
from std import io.*

open class FileUtils {
    static public func getFilePath(outPath: String, fileName: String): String {
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
     *  Get file name
     *  @param file path
     */
    static public func getFileName(path: String): String {
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

    /**
     * Read files according to the file path
     * @param path   the file path
     */
    static func readFile(path: String): Array<UInt8> {
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

    /**
     * Writes data to a file
     * @param outData    content
     * @param filePath   Content output path
     */
    static func writeFile(outData: Array<UInt8>, filePath: String) {
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
