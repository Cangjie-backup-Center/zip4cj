/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

/**
 * @file
 *
 * This is a class that provides decompression functions.
 * Provides function such as  deCompress.
 */
package zip4cj.tar

from std import convert.*
from std import io.*
import zip4cj.utils.FileUtils

/**
 * This class provides  decompression of tar
 * @since  0.29.3    @author lizhenjie
 */
public class TarFile {
    private let RECORD_SIZE: Int64 = 512
    private let NAM_SIZ: Int64 = 100
    private let TUNM_LEN: Int64 = 32
    private let TGNM_LEN: Int64 = 32
    public var outPath = ""
    public init() {}
    private func parseInt(sizeStr: String): Int64 {
        var sum = 0
        var len = sizeStr.size()
        var tempNum = 0
        for (index in len..0 : -1) {
            var number = parseInt64("${sizeStr.charAt(index)}")
            match (number) {
                case Some(num) =>
                    sum += num * (8 ** tempNum)
                    tempNum++
                case None => sum += 0
            }
        }
        return sum
    }

    /*
     *  decompressed tar file
     *  @param file
     */
    public func extractTar(file: Array<UInt8>): Unit {
        if (outPath == "") {
            throw RuntimeException("The output path cannot be empty")
        }
        var nextFileSize = file.size()

        //-name 
        var name = file.slice(0, 100).toArray()
        var nameStr = String.fromUtf8(name, start: 0, length: name.size(), isAscii: true)
        if (nameStr.charAt(0) == '\0') {
            return
        }

        //size
        var size = file.slice(124, 12).toArray()
        var sizeStr = String.fromUtf8(size, start: 0, length: size.size(), isAscii: true)
        var fileSize = parseInt(sizeStr)
        var rarFileSize = fileSize + (RECORD_SIZE - fileSize % RECORD_SIZE)
        if (fileSize == 0) {
            rarFileSize = 0
        }

        //var linkflag: String = ""
        var linkflag = file.slice(156, 1).toArray()
        var linkflagStr = chr(UInt32(linkflag[0]))
        var filedate = file.slice(512, fileSize).toArray()
        writeFile(linkflagStr, outPath + nameStr, filedate)
        extractTar(file.slice(RECORD_SIZE + rarFileSize, nextFileSize - RECORD_SIZE - rarFileSize).toArray())
    }
    private func writeFile(linkflag: Char, fileName: String, filedate: Array<UInt8>) {
        println(fileName)
        match (linkflag) {
            case '0' => createNormalDiskFile(fileName, filedate)
            case '5' => createDir(fileName)
            case _ => throw RuntimeException("This format is not currently supported")
        }
    }
    private func createDir(fileName: String) {
        if (fileName.contains("/")) {
            var path: String = ""
            for (fname in fileName.split("/", removeEmpty: true)) {
                path += "/" + fname
                var dirInfo = io.DirectoryInfo(path)
                if (!dirInfo.exist()) {
                    dirInfo.create()
                }
            }
        }
    }
    private func createNormalDiskFile(fileName: String, filedate: Array<UInt8>) {
        if (fileName.contains("/")) {
            var lastIndex = fileName.lastIndexOf("/")
            var lastIndexNum = 0
            match (lastIndex) {
                case Some(index) => lastIndexNum = index
                case None => throw RuntimeException("The file path is incorrect")
            }
            var dir = fileName.slice(0, lastIndexNum).toString()
            createDir(dir)
            FileUtils.writeFile(filedate, fileName)
        }
    }
}
