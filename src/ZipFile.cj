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
    public init() {}
    public init(filePath: String) {
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
        var hp = HeaderParser(outPath)
        hp.writeZipFile(fileList,zipParam)
    }

    public func extractAll() {
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
        var dirInfo = io.DirectoryInfo(outPath)
        if (!dirInfo.exist()) {
            dirInfo.create()
        }
        unzip()
    }
    private func unzip() {
        var hp = HeaderParser(outPath)
        var buff = FileUtils.readFile(filePath)
        var eocd = hp.parseEndOfCentralDirectory(buff)
        var cdrs = hp.parseCentralDirectoryRecord(buff, eocd)
        hp.parseLocalFileHeader(buff, cdrs)
        return
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
