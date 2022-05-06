package zip4cj

from std import io.*
from compress import zlib.*
from std import collection.*
from std import convert.*

public open class ZipFile {
    private var filePath: String = ""
    private var passwd: String = ""
    private var outPath: String = ""
    private var zipParam: ZipParams = ZipParams()
    private var fileList = HashSet<String>()
    private let headerParser: HeaderParser
    public init() {
        headerParser = HeaderParser()
    }
    public init(filePath: String) {
        headerParser = HeaderParser()
        this.filePath = filePath
    }
    func checkFile(files: HashSet<String>) {
        for (file in fileList) {
            var fileInfo = FileInfo(file)
            if (!fileInfo.exist()) {
                throw RuntimeException(FileUtils.getFileName(file) + " file does not exist")
            }
        }
    }
    public func addFile(file: String) {
        var fileInfo = FileInfo(file)
        if (!fileInfo.exist()) {
            throw RuntimeException(FileUtils.getFileName(file) + " file does not exist")
        }
        fileList.put(file)
    }
    public func addFiles(files: HashSet<String>) {
        if (files.size() == 0) {
            throw RuntimeException("The number of added files cannot be empty!")
        }
        checkFile(files)
        fileList.putAll(files)
    }
    public func writeZip() {
        if (!outPath.endsWith(".zip")) {
            throw RuntimeException("Output file type should be zip!")
        }
        headerParser.writeZipFile(fileList, zipParam)
    }
    private func checkFile() {
        if (filePath == "") {
            throw RuntimeException("file Path is null or invalid")
        }
        if (outPath == "") {
            throw RuntimeException("out Path is null or invalid")
        }
        var fileInfo = FileInfo(filePath)
        if (!fileInfo.exist()) {
            throw RuntimeException("file not exist!")
        }
    }
    public func extractAll(): ArrayList<LocalFileHeader> {
        checkFile()
        var dirInfo = io.DirectoryInfo(outPath)
        if (!dirInfo.exist()) {
            dirInfo.create()
        }
        return unzip()
    }
    private func unzip(): ArrayList<LocalFileHeader>  {
        checkFile()
        headerParser.setOutPath(outPath)
        var buff = FileUtils.readFile(filePath)
        var eocd = headerParser.parseEndOfCentralDirectory(buff)
        var cdrs = headerParser.parseCentralDirectoryRecord(buff, eocd)
        return headerParser.parseLocalFileHeader(buff, cdrs)
    }

    /*
     *Gets the directory inside the compressed package
     */
    public func nameList(): Array<String> {
        checkFile()
        headerParser.setOutPath(outPath)
        var buff = FileUtils.readFile(filePath)
        var eocd = headerParser.parseEndOfCentralDirectory(buff)
        var cdrs = headerParser.parseCentralDirectoryRecord(buff, eocd)
        return cdrs.keys().toArray()
    }

    public func setOutPath(outPath: String) {
        this.outPath = outPath
    }
    public func setOutPasswd(passwd: String) {
        this.passwd = passwd
    }
    public func setZipParams(zipParam: ZipParams) {
        this.zipParam = zipParam
    }
}
