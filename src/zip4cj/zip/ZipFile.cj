/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

/**
 * @file
 *
 * This is a class library that implements compression file functions.
 * Provides streaming compression interfaces such as deflateInit, deflate, deflateEnd, deflateBound, setGzipHeader, and setDictionary.
 */

package zip4cj.zip

from compress import zlib.*
from std import convert.*


/**
 * Provide compressed file function
 * @since 0.28.4
 */
public open class ZipFile {
    private var filePath: String = ""
    private var outPath: String = ""
    private var zipParam: ZipParams = ZipParams()
    private var fileList = HashSet<String>()
    private let headerParser: HeaderParser = HeaderParser()

    /**
     * Zip decompression initialization
     *
     * @since 0.28.4
     */
    public init() {}

    /**
     * Zip compression initialization
     *
     * @param filePath File path to be unzipped
     *
     * @since 0.28.4
     */
    public init(filePath: String) {
        this.filePath = filePath
    }

    func checkFile(files: HashSet<String>) {
        for (file in files) {
            var path = Path(file)
            if (!File.exists(path)) {
                throw ZipException(path.fileName.getOrThrow() + " file does not exist")
            }
        }
    }

    /**
     * Add compressed file
     *
     * @param file Add path to compressed file
     *
     * @since 0.28.4
     */
    public func addFile(file: String) {
        var path = Path(file)
        if (!File.exists(path)) {
            throw ZipException(path.fileName.getOrThrow() + " file does not exist")
        }
        fileList.put(file)
    }

    /**
     * The Function is addFiles
     *
     * @param The param is files of HashSet<String>
     *
     * @since 0.28.4
     */
    public func addFiles(files: HashSet<String>) {
        if (files.size == 0) {
            throw ZipException("The number of added files cannot be empty!")
        }
        checkFile(files)
        fileList.putAll(files)
    }

    /**
     * Zip compress
     *
     * @since 0.28.4
     */
    public func writeZip() {
        if (!outPath.endsWith(".zip")) {
            throw ZipException("Output file type should be zip!")
        }
        headerParser.setOutPath(outPath)
        headerParser.writeZipFile(fileList, zipParam)
    }

    private func checkFile() {
        if (filePath == "") {
            throw ZipException("file Path is null or invalid")
        }
        if (outPath == "") {
            throw ZipException("out Path is null or invalid")
        }
        var fPath = Path(filePath)
        if (!File.exists(fPath)) {
            throw ZipException("file not exist!")
        }
    }

    /**
     * Extract all decompressed data
     *
     * @since 0.28.4
     */
    public func extractAll(): ArrayList<LocalFileHeader> {
        checkFile()
        let oPath=Path(outPath);
        if (!Directory.exists(oPath)) {
            Directory.create(oPath, recursive: true)
        }
        return unzip()
    }
    private func unzip(): ArrayList<LocalFileHeader> {
        checkFile()
        headerParser.setOutPath(outPath)
        var buff = FileUtils.readFile(filePath)
        var eocd = headerParser.parseEndOfCentralDirectory(buff)
        var cdrs = headerParser.parseCentralDirectoryRecord(buff, eocd)
        return headerParser.parseLocalFileHeader(buff, cdrs)
    }

    /**
     * Gets the directory inside the compressed package
     *
     * @since 0.28.4
     */
    public func nameList(): Array<String> {
        var path = Path(filePath)
        if (!File.exists(path)) {
            throw ZipException(path.fileName.getOrThrow() + "file does not exist")
        }
        headerParser.setOutPath(outPath)
        var buff = FileUtils.readFile(filePath)
        var eocd = headerParser.parseEndOfCentralDirectory(buff)
        var cdrs = headerParser.parseCentralDirectoryRecord(buff, eocd)
        return cdrs.keys().toArray()
    }

    /**
     * The Function is setOutPath
     *
     * @param The param is outPath of String
     *
     * @since 0.28.4
     */
    public func setOutPath(outPath: String) {
        this.outPath = outPath
    }
}
