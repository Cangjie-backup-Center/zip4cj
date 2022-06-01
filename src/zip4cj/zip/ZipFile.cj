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
from std import io.*
from compress import zlib.*
from std import collection.*
from std import convert.*
import zip4cj.utils.FileUtils

/**
 * Provide compressed file function
 * @since 0.28.4
 */
public open class ZipFile {
    private var filePath: String = ""
    private var passwd: String = ""
    private var outPath: String = ""
    private var zipParam: ZipParams = ZipParams()
    private var fileList = HashSet<String>()
    private let headerParser: HeaderParser=HeaderParser()
    /**
     * Zip decompression initialization
     *
     * @since 0.28.4
     */
    public init() {
    }

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
            var fileInfo = FileInfo(file)
            if (!fileInfo.exist()) {
                throw RuntimeException(FileUtils.getFileName(file) + " file does not exist")
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
        var fileInfo = FileInfo(file)
        if (!fileInfo.exist()) {
            throw RuntimeException(FileUtils.getFileName(file) + " file does not exist")
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
        if (files.size() == 0) {
            throw RuntimeException("The number of added files cannot be empty!")
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
            throw RuntimeException("Output file type should be zip!")
        }
        headerParser.setOutPath(outPath)
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
    /**
     * Extract all decompressed data
     *
     * @since 0.28.4
     */
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

    /**
     *  Gets the directory inside the compressed package
     *
     * @since 0.28.4
     */
    public func nameList(): Array<String> {
        var fileInfo = FileInfo(filePath)
        if (!fileInfo.exist()) {
            throw RuntimeException(FileUtils.getFileName(filePath) + " file does not exist")
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

    /*
     * Set password for compressed files
     *
     * @param passwd Compress password
     *
     * @since 0.28.4
     */
    public func setOutPasswd(passwd: String) {
        this.passwd = passwd
    }

    /*
     * Set compression parameters
     *
     * @param zipParam compression parameters
     *
     * @since 0.28.4
     */
    public func setZipParams(zipParam: ZipParams) {
        this.zipParam = zipParam
    }
}
