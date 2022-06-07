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
from std import collection.*
from std import time.*

/**
 * This class provides  decompression of tar
 * @since  0.29.3    @author lizhenjie
 */
public class TarFile {
    private let RECORD_SIZE: Int64 = 512
    private let NAM_SIZ: Int64 = 100
    private let TUNM_LEN: Int64 = 32
    private let TGNM_LEN: Int64 = 32
    private let FILE_RECORD: ArrayList<String> = ArrayList<String>()
    private var DIR_MODE = "0040777"
    private var FILE_MODE = "0100777"
    public var outPath = ""
    private var SEPARATOR=""
    public init() {
    }
    private func parseInt(sizeStr: String): Int64 {
        var sum = 0
        var len = sizeStr.size()
        var tempNum = 0
        for (index in len..=0 : -1) {
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

    /*
     *  Write the extracted files to disk
     *  @param linkflag  type  '0': normal disk file
     *                         '5': directory
     *  @param fileName
     *  @param fileData
     */
    private func writeFile(linkflag: Char, fileName: String, fileData: Array<UInt8>) {
        match (linkflag) {
            case '0' => createNormalDiskFile(fileName, fileData)
            case '5' => createDir(fileName)
            case _ => throw RuntimeException("This format is not currently supported")
        }
    }

    /*
     * Write the extracted dir to disk
     * @param fileName   dir
     */
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

    /*
     *  Write the extracted files to disk
     *  @param fileName
     *  @param fileData
     */
    private func createNormalDiskFile(fileName: String, fileData: Array<UInt8>) {
        if (fileName.contains("/")) {
            var lastIndex = fileName.lastIndexOf("/")
            var lastIndexNum = 0
            match (lastIndex) {
                case Some(index) => lastIndexNum = index
                case None => throw RuntimeException("The file path is incorrect")
            }
            var dir = fileName.slice(0, lastIndexNum).toString()
            createDir(dir)
            FileUtils.writeFile(fileData, fileName)
        }
    }

    /*
     * Calculates the sum of checkSum
     */
    private func sum(checkSum: Int64, ascii: Array<UInt8>): Int64 {
        var sum = checkSum
        for (val in ascii) {
            sum += Int64(val)
        }
        return sum
    }

    /*
     *  Read the target file
     *  @param filePath
     *  @param targetDir
     *  @param fi
     */
    private func readTargetFile(filePath: String, targetDir: String, fi: FileStream): Unit {
        if (!FILE_RECORD.contains(targetDir + "/")) {
            writeFile(targetDir, targetDir + "/", DIR_MODE, '5', fi)
            FILE_RECORD.add(targetDir + "/")
        }
        var dir = io.DirectoryInfo(filePath)
        var dirs = dir.getDirectories()
        for (dr in dirs) {
            var path = dr.getPath()
            var index = path.indexOf(targetDir).getOrThrow()
            path.slice(index, path.size() - index).toString()
            var relativePath = path.slice(index, path.size() - index).toString()
            if (!FILE_RECORD.contains(relativePath + "/")) {
                writeFile(path, relativePath + "/", DIR_MODE, '5', fi)
                FILE_RECORD.add(relativePath + "/")
                readTargetFile(dr.getPath(), targetDir, fi)
            }
        }
        var files = dir.getFiles()
        for (file in files) {
            var path: String = file.getPath()
            var index = path.indexOf(targetDir).getOrThrow()
            var relativePath = path.slice(index, path.size() - index).toString()
            writeFile(path, relativePath, FILE_MODE, '0', fi)
            FILE_RECORD.add(relativePath)
        }
        return
    }

    /*
     * Format the data
     */
    private func formatVal(fieldArr: Array<UInt8>, dataArr: Array<UInt8>) {
        if (dataArr.size() > 0) {
            for (index in 0..dataArr.size()) {
                fieldArr[index] = dataArr[index]
            }
        }
    }

    /*
     *  Converts data to octal strings
     */
    private func convertsToOctal(num: Int64): String {
        var number = num
        var str = StringBuilder()
        if (num < 8) {
            return str.append(num).toString()
        }
        do {
            str.append(number % 8)
            number = number / 8
        } while (number > 8)
        str.append(number)
        return str.toString().reverse()
    }

    /*
     *  Write the normal  file and directory to disk
     *  @param filePath
     *  @param relativePath
     *  @param modeField
     *  @param flag
     *  @param fi
     */
    private func writeFile(filePath: String, relativePath: String, modeField: String, flag: Char, fi: FileStream) {
        var arrayList = ArrayList<UInt8>()
        var checkSum: Int64 = 0

        // name
        var name: Array<UInt8> = Array<UInt8>(100, {i => 0})
        name[99] = UInt8(ord('\0'))
        var nameArr = relativePath.toUtf8Array()
        formatVal(name, nameArr)
        arrayList.addAll(name)
        checkSum = sum(checkSum, nameArr)
        var fileSize = 0
        var rarFileSize = 0
        var fileData = Array<UInt8>()
        if (flag == '0') {
            fileData = FileUtils.readFile(filePath)
            fileSize = fileData.size()
            rarFileSize = fileSize + (RECORD_SIZE - fileSize % RECORD_SIZE)
        }
        var fileDataArr = Array<UInt8>(rarFileSize, {i => 0})
        formatVal(fileDataArr, fileData)
        var modeArr: Array<UInt8> = Array<UInt8>(8, @overflowThrowing{i => 0})
        formatVal(modeArr, modeField.toUtf8Array())
        arrayList.addAll(modeArr)
        checkSum = sum(checkSum, modeArr)
        var uid: Array<UInt8> = Array<UInt8>(8, @overflowThrowing{i => 48})
        uid[7] = 0
        arrayList.addAll(uid)
        checkSum = sum(checkSum, uid)
        var gid: Array<UInt8> = Array<UInt8>(8, @overflowThrowing{i => 48})
        gid[7] = 0
        checkSum = sum(checkSum, gid)
        arrayList.addAll(gid)
        var size: Array<UInt8> = Array<UInt8>(12, @overflowThrowing{i => 48})
        if (fileSize == 0) {
            size[11] = 0
            arrayList.addAll(size)
            checkSum = sum(checkSum, size)
        } else {
            var octalSize = convertsToOctal(fileSize)
            let octallen = octalSize.size()
            octalSize = "0".repeat(12 - octallen) + octalSize
            size = octalSize.toUtf8Array()
            arrayList.addAll(size)
            checkSum = sum(checkSum, size)
        }
        var mtime: Array<UInt8> = Array<UInt8>(12, {i => 0})
        var time = Time.now(Location.Local)
        formatVal(mtime, convertsToOctal(time.unix()).toUtf8Array())
        checkSum = sum(checkSum, mtime)

        var linkflag: Array<UInt8> = Array<UInt8>(1, @overflowThrowing{i => 0})
        linkflag[0] = UInt8(ord(flag))
        checkSum = sum(checkSum, linkflag)
        var linkname: Array<UInt8> = Array<UInt8>(100, @overflowThrowing{i => 0})
        linkname[99] = UInt8(ord('\0'))
        checkSum = sum(checkSum, linkname)
        var magic: Array<UInt8> = Array<UInt8>(8, @overflowThrowing{i => 0})
        magic[6] = UInt8(48)
        magic[7] = UInt8(48)
        formatVal(magic, "ustar".toUtf8Array())
        checkSum = sum(checkSum, magic)
        var uname: Array<UInt8> = Array<UInt8>(32, @overflowThrowing{i => 0})
        uname[31] = UInt8(ord('\0'))
        checkSum = sum(checkSum, uname)
        var gname: Array<UInt8> = Array<UInt8>(32, @overflowThrowing{i => 0})
        gname[31] = UInt8(ord('\0'))
        checkSum = sum(checkSum, gname)
        var devmajor: Array<UInt8> = Array<UInt8>(8, @overflowThrowing{i => 0})
        checkSum = sum(checkSum, devmajor)
        var devminor: Array<UInt8> = Array<UInt8>(8, @overflowThrowing{i => 0})
        checkSum = sum(checkSum, devminor)
        var prefix: Array<UInt8> = Array<UInt8>(155, @overflowThrowing{i => 0})
        checkSum = sum(checkSum, prefix)
        var padding: Array<UInt8> = Array<UInt8>(12, @overflowThrowing{i => 0})
        checkSum = sum(checkSum, padding)
        var chksum: Array<UInt8> = Array<UInt8>(8, @overflowThrowing{i => 0})
        formatVal(chksum, convertsToOctal(checkSum + 256).toUtf8Array())
        arrayList.addAll(mtime)
        arrayList.addAll(chksum)
        arrayList.addAll(linkflag)
        arrayList.addAll(linkname)
        arrayList.addAll(magic)
        arrayList.addAll(uname)
        arrayList.addAll(gname)
        arrayList.addAll(devmajor)
        arrayList.addAll(devminor)
        arrayList.addAll(prefix)
        arrayList.addAll(padding)
        if (fileDataArr.size() > 0) {
            arrayList.addAll(fileDataArr)
        }
        fi.write(arrayList.toArray(), 0, arrayList.size())
    }
    /*
     * Store tar 
     * @param targetFile  target dir example:/mnt/c/Users/lizhenjie/Desktop/water_analysis
     * 
     */
    public func storeTar(targetFile: String) {
        if (outPath == "") {
            throw RuntimeException("The output path cannot be empty")
        }
        if(!outPath.endsWith(".tar")){
            throw RuntimeException("The output file must end .tar")
        }
        var file = FileInfo(outPath)
        if (!file.exist()) {
            file.create()
        }
        var lastIndex = targetFile.lastIndexOf("/").getOrThrow()
        var targetDir = targetFile.slice(lastIndex + 1, targetFile.size() - lastIndex - 1).toString()
        var fi = FileStream(file)
        if (fi.openFile()) {
            readTargetFile(targetFile, targetDir, fi)
            var array = Array<UInt8>(RECORD_SIZE, {i => 0})
            fi.write(array, 0, RECORD_SIZE)
            fi.close()
        }
    }
}
