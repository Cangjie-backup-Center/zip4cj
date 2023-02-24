/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

/**
 * @file
 *
 * This is a class that provides compressed header information.
 */

package zip4cj.zip

from std import math.*
from std import log.*
from compress import zlib.*
from charset import charset.*
from std import os.*
from std import time.*
from std import collection.*
from std import fs.*
import zip4cj.utils.FileUtils

/*
 * Parse zip Header information
 * @since0.28.4    @author lizhenjie
 */
open class HeaderParser <: ZipSignatures {
    private let HEXADECIMAL = 16
    private let logger = SimpleLogger()
    private var outPath = ""

    public init() {}
    public init(outPath: String) {
        this.outPath = outPath
    }
    public func setOutPath(outPath: String) {
        this.outPath = outPath
    }

    public func findFileHeaderSigStart(buff: Array<UInt8>, endCDR: EndCDR): ArrayList<Int64> {
        var fileStartIndex = 0 //文件开始位置
        var localFileHeaderSigStartPosition = ArrayList<Int64>()
        var fileHeaderBuffer = buff.slice(fileStartIndex, 30)
        var fileCount = 0;
        while (fileCount < endCDR.totalNumberOfEntriesInCentralDirectory) {
            var meth = readShortLittleEndian(fileHeaderBuffer, LOC_HDR_HOW_OFFSET)
            var compressedSize = readIntLittleEndian(fileHeaderBuffer, LOC_HDR_SIZ_OFFSET)
            var flag = readShortLittleEndian(fileHeaderBuffer, LOC_HDR_FLG_OFFSET)
            var flagArr = MsDosUtils.convertToBinary(flag, length: 16)
            var fileNameLength = readShortLittleEndian(fileHeaderBuffer, LOC_HDR_NAM_OFFSET)
            var extraFieldLength = readShortLittleEndian(fileHeaderBuffer, LOC_HDR_EXT_OFFSET)
            fileHeaderBuffer = buff.slice(fileStartIndex, LOC_HDR_FNM_OFFSET + fileNameLength)
            var fileNameArr = subArray(fileHeaderBuffer, LOC_HDR_FNM_OFFSET, (LOC_HDR_FNM_OFFSET + fileNameLength))
            var length = flagArr.size
            var isUtf8: Bool = (flagArr[length - 12] != 0)
            var fileName = ""
            if (isUtf8) {
                fileName = String.fromUtf8(fileNameArr)
            } else {
                fileName = gb18030(fileNameArr)
            }

            //println("解压文件名称:" + fileName)
            
            //println("extraFieldLength=${extraFieldLength}")
            //println("compressedSize=${compressedSize}")
            //println("fileNameLength=${fileNameLength}")
            //println("LOC_HDR_FNM_OFFSET=${LOC_HDR_FNM_OFFSET}")
            localFileHeaderSigStartPosition.append(fileStartIndex)

            //println("------------------------------------------------")
            fileCount++
            fileStartIndex = fileStartIndex + LOC_HDR_FNM_OFFSET + extraFieldLength + compressedSize + fileNameLength
            fileHeaderBuffer = buff.slice(fileStartIndex, 30)
        }
        return localFileHeaderSigStartPosition
    }

    /*
     * Parse local file header
     *
     * @param buff Local file data
     * @param fileType Local file type
     *
     * @return Return the parsed file header
     * @since 0.28.4
     */
    public func parseLocalFileHeader(buff: Array<UInt8>, fileType: HashMap<String, CentralDirectoryRecord>, 
        endCDR: EndCDR): ArrayList<LocalFileHeader> {
        var length = buff.size
        var localFileHeaderSigStartPosition = findFileHeaderSigStart(buff, endCDR)
        var size = localFileHeaderSigStartPosition.size
        var lfhList = ArrayList<LocalFileHeader>()
        for (index in 0..size) {
            if (index >= size) {
                break
            }
            var start = localFileHeaderSigStartPosition[index]
            var end = 0
            if (index + 1 >= size) {
                end = buff.size
            } else {
                end = localFileHeaderSigStartPosition[index+1]
            }
            var buffer = subArray(buff, start, end)
            var sig = readIntLittleEndian(buffer, LOC_HDR_SIG_OFFSET)
            var version = readShortLittleEndian(buffer, LOC_HDR_VER_OFFSET)
            var flag = readShortLittleEndian(buffer, LOC_HDR_FLG_OFFSET)
            var flagArr = MsDosUtils.convertToBinary(flag, length: 16)
            var meth = readShortLittleEndian(buffer, LOC_HDR_HOW_OFFSET)
            var dateTime = readIntLittleEndian(buffer, LOC_HDR_TIM_OFFSET)
            var time = readShortLittleEndian(buffer, LOC_HDR_TIM_OFFSET)
            var date = readShortLittleEndian(buffer, LOC_HDR_DAT_OFFSET)
            var crc = readIntLittleEndian(buffer, LOC_HDR_CRC_OFFSET)
            var compressedSize = readIntLittleEndian(buffer, LOC_HDR_SIZ_OFFSET)
            var uncompressedSize = readIntLittleEndian(buffer, LOC_HDR_LEN_OFFSET)
            var fileNameLength = readShortLittleEndian(buffer, LOC_HDR_NAM_OFFSET)
            var extraFieldLength = readShortLittleEndian(buffer, LOC_HDR_EXT_OFFSET)
            var fileNameArr = subArray(buffer, LOC_HDR_FNM_OFFSET, (LOC_HDR_FNM_OFFSET + fileNameLength))
            var length = flagArr.size
            var isUtf8: Bool = (flagArr[length - 12] != 0)
            var fileName = ""
            if (isUtf8) {
                fileName = String.fromUtf8(fileNameArr)
            } else {
                fileName = gb18030(fileNameArr)
            }
            var sub = Array<UInt8>()
            if (compressedSize > 0) {
                sub = subArray(
                    buffer,
                    LOC_HDR_FNM_OFFSET + fileNameLength,
                    LOC_HDR_FNM_OFFSET + fileNameLength + compressedSize
                )
            }
            var fType = fileType[fileName]
            if (!fType.isDirectory) {
                match (meth) {
                    case 0 => logger.info(fileName + "解压完成") //STORE
                    case 8 =>
                        //zipInflate
                        let tempFile = outPath + "/" + fileName + ".tmp"
                        File.writeTo(tempFile, sub, openOption: OpenOption.CreateOrAppend)
                        sub = Array(zipInflate(tempFile,uncompressedSize))
                        logger.info(fileName + "解压完成")
                    case 99 => //AES_INTERNAL_ONLY
                        logger.info("Compression method:$[meth} does not support!")
                    case _ => throw ZipException("Compression method:$[meth} does not support!")
                }
                if (outPath != "") {
                    var file = FileUtils.getFilePath(outPath, fileName)
                    if (!fType.isDirectory) {
                        FileUtils.writeFile(sub, file)
                    }
                }
            }
            var lfh = LocalFileHeader(
                sig,
                version,
                flag,
                meth,
                time,
                date,
                crc,
                compressedSize,
                uncompressedSize,
                fileNameLength,
                extraFieldLength,
                fileName,
                sub
            )
            lfhList.append(lfh)
        }
        return lfhList
    }

    /*
     * Zip deflate
     */
    private func zipDeflate(input: Array<UInt8>): Array<UInt8> {
        let tempDir = os.tempDir();

        //为读取到的数据文件
        var srcFile = tempDir.createFile("${Time.now().unixTimeStamp().nanoseconds()}")
        if (srcFile.canWrite()) {
            try {
                srcFile.write(input)
            } catch (e: Exception) {
                throw Exception("file write failed: ${e.message}")
            }
        }
        srcFile.close()
        let destFile = tempDir.createFile("${Time.now().unixTimeStamp().nanoseconds()}")
        srcFile = File.openRead(srcFile.info.path)
        if (srcFile.canRead()) {
            var tempBuf: Array<UInt8> = Array<UInt8>(2048, item: 0)
            var retbuf: ArrayList<UInt8> = ArrayList<UInt8>()
            var compressOutputStream: CompressOutputStream = CompressOutputStream(destFile, wrap: DeflateFormat)
            while (true) {
                try {
                    var readNum = srcFile.read(tempBuf)
                    if (readNum > 0) {
                        compressOutputStream.write(tempBuf.slice(0, readNum).toArray())
                    } else {
                        break
                    }
                } catch (e: Exception) {
                    throw Exception("file read failed: ${e.message}")
                }
            }
            compressOutputStream.flush()
            compressOutputStream.close()
        }
        srcFile.close()
        destFile.close()
        let result = FileUtils.readFile(destFile.info.path.toString())
        File.delete(srcFile.info.path)
        File.delete(destFile.info.path)
        return result
    }

    /*
     * Zip inflate
     */
    private func zipInflate(tempFile: String,size:Int64): ArrayList<UInt8> {
        var retbuf: ArrayList<UInt8> = ArrayList<UInt8>()
        var tempBuf: Array<UInt8> = Array<UInt8>(2048, item: 0)
        var srcFile: File = File(tempFile, OpenOption.Open(true, false))
        var decompressInputStream = DecompressInputStream(srcFile, wrap: DeflateFormat)
        while (true) {
            var readNum = decompressInputStream.read(tempBuf)
            if (readNum <= 0) {
                break
            }
            retbuf.appendAll(tempBuf);
        }
        File.delete(tempFile)
        srcFile.close()
        decompressInputStream.close()
        return retbuf[0..size]
    }

    /*
     * Parse central directory record
     *
     * @param buff central directory
     * @param endCDR Define the end of central directory record field
     *
     * @return Return parsed data
     * @since 0.28.4
     */
    public func parseCentralDirectoryRecord(buff: Array<UInt8>, endCDR: EndCDR): HashMap<String, CentralDirectoryRecord> {
        var cdrData = splitCentralDirectoryRecord(buff, endCDR)
        var fileType = HashMap<String, CentralDirectoryRecord>()
        for (key in cdrData.keys()) {
            var entryData = cdrData.get(key)
            var buff = Array<UInt8>()
            match (entryData) {
                case Some(data) => buff = data
                case None => break
            }
            var sig = readIntLittleEndian(buff, CEN_SIG_OFFSET)
            if (CENSIG != sig) {
                throw ZipException("Parse central directory record faild")
            }
            var versionMadeBy = readShortLittleEndian(buff, CEN_VEM_OFFSET)
            var versionNeededToExtract = readShortLittleEndian(buff, CEN_VER_OFFSET)
            var flag = readShortLittleEndian(buff, CEN_FLG_OFFSET)
            var flagArr = MsDosUtils.convertToBinary(flag, length: 16)
            var compressionMethod = readShortLittleEndian(buff, CEN_HOW_OFFSET)
            var lastModifiedTime = readShortLittleEndian(buff, CEN_TIM_OFFSET)
            var lastModifiedDate = readShortLittleEndian(buff, CEN_DAT_OFFSET)
            var crc = readLongLittleEndian(buff, CEN_CRC_OFFSET)
            var compressedSize = readLongLittleEndian(buff, CEN_SIZ_OFFSET)
            var uncompressedSize = readLongLittleEndian(buff, CEN_LEN_OFFSET)
            var fileNameLength = readShortLittleEndian(buff, CEN_NAM_OFFSET)
            var extraFieldLength = readShortLittleEndian(buff, CEN_EXT_OFFSET)
            var fileCommentLength = readShortLittleEndian(buff, CEN_COM_OFFSET)
            var diskNumberStart = readShortLittleEndian(buff, CEN_DSK_OFFSET)
            var internalFileAttributes = readShortLittleEndian(buff, CEN_ATT_OFFSET)
            var externalFileAttributes = readLongLittleEndian(buff, CEN_ATX_OFFSET)
            var offsetLocalHeader = readLongLittleEndian(buff, CEN_OFF_OFFSET)
            var fileNameArr = Array<UInt8>(fileNameLength, {i => 0})
            var j = 0
            for (index in CEN_FNM_OFFSET..CEN_FNM_OFFSET + fileNameLength) {
                fileNameArr[j] = buff[index]
                j++
            }
            var length = flagArr.size
            var isUtf8: Bool = (flagArr[length - 12] != 0)
            var fileName = ""
            if (isUtf8) {
                fileName = String.fromUtf8(fileNameArr)
            } else {
                fileName = gb18030(fileNameArr)
            }
            var isDirectory = (fileName != "" && (fileName.endsWith("/") || fileName.endsWith("\\")))
            var cdr = CentralDirectoryRecord(
                CENSIG,
                versionMadeBy,
                versionNeededToExtract,
                flag,
                compressionMethod,
                lastModifiedTime,
                lastModifiedDate,
                crc,
                compressedSize,
                uncompressedSize,
                fileNameLength,
                extraFieldLength,
                fileCommentLength,
                diskNumberStart,
                internalFileAttributes,
                externalFileAttributes,
                offsetLocalHeader,
                fileName,
                isDirectory
            )
            cdr.setEncrypted(flagArr[length - 1] != 0)
            cdr.setUtf8(isUtf8)
            var file = FileUtils.getFilePath(outPath, cdr.fileName)
            if (outPath != "" && cdr.isDirectory) {
                file = file.slice(0, file.size - 1).toString()
                if (!Directory.exists(file)) {
                    Directory.create(file, recursive: true)
                }
            }
            fileType.put(fileName, cdr)
        }

        return fileType
    }

    /*
     * Split central directory record
     */
    private func splitCentralDirectoryRecord(buff: Array<UInt8>, endCDR: EndCDR): HashMap<Int64, Array<UInt8>> {
        let entrieSize = endCDR.totalNumberOfEntriesInCentralDirectory
        let offsetOfStartOfCentralDirectory = endCDR.offsetOfStartOfCentralDirectory
        var cdrBuff = subArray(buff, offsetOfStartOfCentralDirectory, buff.size)
        var size = cdrBuff.size
        var sigPositionArr = Array<Int64>(entrieSize, {i => 0})
        var startPos = 0
        var nextPos = 0
        var map = HashMap<Int64, Array<UInt8>>()
        var entryIndex = 0
        for (index in 0..size) {
            if (index + 3 >= size) {
                var arr = Array<UInt8>(size - nextPos, {i => 0})
                var j = 0
                for (i in nextPos..size) {
                    arr[j] = cdrBuff[i]
                    j++
                }
                map.put(entryIndex, arr)
                break
            }
            var buffer = Array<UInt8>([cdrBuff[index], cdrBuff[index + 1], cdrBuff[index + 2], cdrBuff[index + 3]])
            let sig = readIntLittleEndian(buffer, 0)
            if (sig == CENSIG) {
                startPos = nextPos
                nextPos = index
                if (startPos != nextPos) {
                    var arr = Array<UInt8>(nextPos - startPos, {i => 0})
                    var j = 0
                    for (i in startPos..nextPos) {
                        arr[j] = cdrBuff[i]
                        j++
                    }
                    map.put(entryIndex, arr)
                    entryIndex++
                }
            }
        }
        return map
    }

    /*
     * Interception of array
     */
    private func subArray(arr: Array<UInt8>, fromIndex: Int64, toIndex: Int64): Array<UInt8> {
        var array = Array<UInt8>(toIndex - fromIndex, {i => 0})
        var i = 0
        for (index in fromIndex..toIndex) {
            array[i] = arr[index]
            i++
        }
        return array
    }

    /*
     * Parse end of central directory record
     *
     * @param buff The end of central directory record
     *
     * @return Return end of central directory record data
     * @since
     */
    public func parseEndOfCentralDirectory(buff: Array<UInt8>): EndCDR {
        var arr = readEndOfCentralDirectoryRecord(buff)
        var ecdSize = arr.size
        if (ecdSize < 1) {
            throw ZipException("End Of Central Directory Record is empty!")
        }
        var offsetOfEndOfCentralDirectory = buff.size - arr.size
        var sig = readIntLittleEndian(arr, END_SIG_OFFSET)
        var numberOfThisDisk = readShortLittleEndian(arr, END_NMD_OFFSET)
        var numberOfThisDiskStartOfCentralDir = readShortLittleEndian(arr, END_DSK_OFFSET)
        var totalNumberOfEntriesInCentralDirectoryOnThisDisk = readShortLittleEndian(arr, END_TOD_OFFSET)
        var totalNumberOfEntriesInCentralDirectory = readShortLittleEndian(arr, END_TOT_OFFSET)
        var sizeOfCentralDirectory = readIntLittleEndian(arr, END_SIZ_OFFSET)
        var offsetOfStartOfCentralDirectory = readIntLittleEndian(arr, END_OFF_OFFSET)
        var commentLength = readShortLittleEndian(arr, END_COM_OFFSET)
        var endCdr = EndCDR(
            sig,
            numberOfThisDisk,
            numberOfThisDiskStartOfCentralDir,
            totalNumberOfEntriesInCentralDirectoryOnThisDisk,
            totalNumberOfEntriesInCentralDirectory,
            sizeOfCentralDirectory,
            offsetOfEndOfCentralDirectory,
            offsetOfStartOfCentralDirectory,
            commentLength,
            ""
        )
        return endCdr
    }

    /*
     * Read end central directory records data
     */
    private func readEndOfCentralDirectoryRecord(buff: Array<UInt8>): Array<UInt8> {
        let length = buff.size
        if (length < END_HDR_SIZE) {
            return Array<UInt8>()
        }
        var startPos = 0
        if (readIntLittleEndian(buff, length - END_HDR_SIZE) == ENDSIG) {
            startPos = length - END_HDR_SIZE
        } else {
            for (index in length - 1..=0 : -1) {
                if (index - 3 < 0) {
                    return Array<UInt8>()
                }
                var buffer = Array<UInt8>([buff[index], buff[index - 1], buff[index - 2], buff[index - 3]])
                buffer.reverse()
                var endSig = readIntLittleEndian(buffer, 0)
                if (endSig == ENDSIG) {
                    startPos = index - 3
                    break
                }
            }
        }
        var arr = Array<UInt8>(length - startPos, {i => 0})
        var i = 0
        for (index in startPos..length) {
            arr[i] = buff[index]
            i++
        }
        return arr
    }
    private func readLongLittleEndian(buff: Array<UInt8>, pos: Int64): Int64 {
        var longBuff = Array<Int64>(8, {i => 0})
        var position = pos
        for (index in 0..4) {
            longBuff[index] = Int64(buff[position])
            position++
        }
        var temp: Int64 = 0
        temp |= longBuff[7] & 0xff
        temp = rotate(temp, 8)
        temp |= longBuff[6] & 0xff
        temp = rotate(temp, 8)
        temp |= longBuff[5] & 0xff
        temp = rotate(temp, 8)
        temp |= longBuff[4] & 0xff
        temp = rotate(temp, 8)
        temp |= longBuff[3] & 0xff
        temp = rotate(temp, 8)
        temp |= longBuff[2] & 0xff
        temp = rotate(temp, 8)
        temp |= longBuff[1] & 0xff
        temp = rotate(temp, 8)
        temp |= longBuff[0] & 0xff
        return temp
    }

    private func readIntLittleEndian(b: Array<UInt8>, pos: Int64): Int64 {
        var index0 = Int64(b[pos])
        var index1 = rotate(Int64(b[pos + 1]), 8)
        var index2 = Int64(b[pos + 2])
        var index3 = rotate((Int64(b[pos + 3])), 8)
        return rotate(index3 | index2, 16) | index1 | index0
    }

    private func readShortLittleEndian(buff: Array<UInt8>, position: Int64): Int64 {
        return Int64(buff[position]) | rotate(Int64(buff[1 + position]), 8)
    }

    /*
     * Convert the data to ZIP bytes
     */
    private func convertToLittleEndian(value: Int64, length!: Int64 = 2): Array<UInt8> {
        var val = value
        var valArr = ArrayList<Int64>()
        while (true) {
            valArr.append(val % HEXADECIMAL)
            val = val / HEXADECIMAL
            if (val < HEXADECIMAL) {
                valArr.append(val)
                break
            }
        }
        if (valArr.size % 2 != 0) {
            valArr.append(0)
        }
        valArr.reverse()
        let size = valArr.size / 2
        var array = ArrayList<UInt8>()
        for (i in 0..size) {
            var first = valArr[i * 2]
            var second = valArr[i * 2 + 1]
            array.append(UInt8(first * HEXADECIMAL + second))
        }
        array.reverse()
        var arr = Array<UInt8>(length, {i => 0})
        for (index in 0..array.size) {
            arr[index] = array[index]
        }
        return arr
    }

    /*
     * Write central cirectory rcecord
     *
     * @param cdr Central directory record
     *
     * @return Return the data after write
     * @since
     */
    public func writeCentralDirectoryRecord(cdr: CentralDirectoryRecord): ArrayList<UInt8> {
        var valArr = ArrayList<UInt8>()
        valArr.appendAll(convertToLittleEndian(cdr.signature, length: 4))
        valArr.appendAll(convertToLittleEndian(cdr.versionMadeBy))
        valArr.appendAll(convertToLittleEndian(cdr.versionExtract))
        valArr.appendAll(convertToLittleEndian(cdr.generalPurposeBitFlag))
        valArr.appendAll(convertToLittleEndian(cdr.compressionMethod))
        valArr.appendAll(convertToLittleEndian(cdr.lastModFileTime))
        valArr.appendAll(convertToLittleEndian(cdr.lastModFileDate))
        valArr.appendAll(convertToLittleEndian(cdr.crc32, length: 4))
        valArr.appendAll(convertToLittleEndian(cdr.compressedSize, length: 4))
        valArr.appendAll(convertToLittleEndian(cdr.uncompressedSize, length: 4))
        valArr.appendAll(convertToLittleEndian(cdr.fileNameLength))
        valArr.appendAll(convertToLittleEndian(cdr.extraFieldLength))
        valArr.appendAll(convertToLittleEndian(cdr.commentLength))
        valArr.appendAll(convertToLittleEndian(cdr.offsetOfStartOfCentralDirectory))
        valArr.appendAll(convertToLittleEndian(cdr.internalFileAttributes))
        valArr.appendAll(convertToLittleEndian(cdr.externalFileAttributes, length: 4))
        valArr.appendAll(convertToLittleEndian(cdr.relativeOffSetOfLocalFileHeader, length: 4))
        valArr.appendAll(cdr.fileName.toUtf8Array())
        return valArr
    }

    /*
     * Write local file header
     *
     * @param lfh Local file header information
     *
     * @return Return data after writing
     * @since
     */
    public func writeLocalFileHeader(lfh: LocalFileHeader): ArrayList<UInt8> {
        var valArr = ArrayList<UInt8>()
        valArr.appendAll(convertToLittleEndian(lfh.signature, length: 4))
        valArr.appendAll(convertToLittleEndian(lfh.versionExtract))
        valArr.appendAll(convertToLittleEndian(lfh.generalPurposeBitFlag))
        valArr.appendAll(convertToLittleEndian(lfh.compressionMethod))
        valArr.appendAll(convertToLittleEndian(lfh.lastModFileTime))
        valArr.appendAll(convertToLittleEndian(lfh.lastModFileDate))
        valArr.appendAll(convertToLittleEndian(lfh.crc32, length: 4))
        valArr.appendAll(convertToLittleEndian(lfh.compressedSize, length: 4))
        valArr.appendAll(convertToLittleEndian(lfh.uncompressedSize, length: 4))
        valArr.appendAll(convertToLittleEndian(lfh.fileNameLength))
        valArr.appendAll(convertToLittleEndian(lfh.extraFieldLength))
        valArr.appendAll(lfh.fileName.toUtf8Array())
        return valArr
    }

    /*
     * Write the end of central directory record field
     *
     * @param endCDR Define the end of central directory record field
     *
     * @return Return data after operation
     * @since 0.28.4
     */
    public func writeEndOfCentralDirectoryRecord(endCDR: EndCDR): ArrayList<UInt8> {
        var valArr = ArrayList<UInt8>()
        valArr.appendAll(convertToLittleEndian(endCDR.sig, length: 4))
        valArr.appendAll(convertToLittleEndian(endCDR.diskNum))
        valArr.appendAll(convertToLittleEndian(endCDR.numberOfThisDiskStartOfCentralDir))
        valArr.appendAll(convertToLittleEndian(endCDR.totalNumberOfEntriesInCentralDirectoryOnThisDisk))
        valArr.appendAll(convertToLittleEndian(endCDR.totalNumberOfEntriesInCentralDirectory))
        valArr.appendAll(convertToLittleEndian(endCDR.sizeOfCentralDirectory, length: 4))
        valArr.appendAll(convertToLittleEndian(endCDR.offsetOfStartOfCentralDirectory, length: 4))
        valArr.appendAll(convertToLittleEndian(endCDR.commentLength))
        if (endCDR.comment != "") {
            valArr.appendAll(endCDR.comment.toUtf8Array())
        }
        return valArr
    }

    /*
     * Write data to Zip File
     *
     * @param files Zip File data
     * @param zipParam Zip param
     *
     * @since 0.28.4
     */
    public func writeZipFile(files: HashSet<String>, zipParam: ZipParams) {
        var fileNum = files.size
        var time = Time.now(Location.Local)
        var localFileLst = ArrayList<UInt8>()
        var cdrLst = ArrayList<UInt8>()
        for (file in files) {
            let fileData = FileUtils.readFile(file)
            let deflate = zipDeflate(fileData)
            let fileName = FileUtils.getFileName(file)
            let fileNameLength = fileName.toUtf8Array().size
            let compressedSize = deflate.size
            println("压缩后大小：${compressedSize}")
            let uncompressedSize = fileData.size
            var crc = crc32(fileData)
            var lfh: LocalFileHeader = LocalFileHeader(LOCSIG, 20, generalPurposeBitFlag(), CompressionMethod.DEFLATE, MsDosUtils.getLastModFileTime(time), MsDosUtils.getLastModFileDate(time), Int64(crc), compressedSize, uncompressedSize, fileNameLength, 0, fileName, Array<UInt8>())
            var relativeOffSetOfLocalFileHeader = localFileLst.size
            var lfhArrayList = writeLocalFileHeader(lfh)
            localFileLst.appendAll(lfhArrayList)
            localFileLst.appendAll(deflate)
            var cdr: CentralDirectoryRecord = CentralDirectoryRecord(CENSIG, 20, 20, generalPurposeBitFlag(), CompressionMethod.DEFLATE, MsDosUtils.getLastModFileTime(time), MsDosUtils.getLastModFileDate(time), Int64(crc), compressedSize, uncompressedSize, fileNameLength, 0,0,0,0,0, relativeOffSetOfLocalFileHeader, fileName)
            var cdrData = writeCentralDirectoryRecord(cdr)
            cdrLst.appendAll(cdrData)
        }
        var offsetOfStartOfCentralDirectory = localFileLst.size
        localFileLst.appendAll(cdrLst)
        var offsetOfEndOfCentralDirectory = localFileLst.size
        var sizeOfCentralDirectory = cdrLst.size
        var endCDR: EndCDR = EndCDR(ENDSIG, 0, 0, fileNum, fileNum, sizeOfCentralDirectory, offsetOfEndOfCentralDirectory, offsetOfStartOfCentralDirectory, 0, "")
        var endCDRLst = writeEndOfCentralDirectoryRecord(endCDR)
        localFileLst.appendAll(endCDRLst)
        FileUtils.writeFile(Array(localFileLst), outPath)
    }

    private func gb18030(arr: Array<UInt8>): String {
        var charset = Charsets.forName("gb18030").getOrThrow()
        var decoder = charset.newDecoder()
        return decoder.decode(arr);
    }

    private func generalPurposeBitFlag(utf8!: Int64 = 1, encrypted!: Int64 = 0): Int64 {
        var flagArr = Array<Int64>(GENERAL_PURPOSE_BIT_FLAG_SIZE, {i => 0})
        flagArr[GENERAL_PURPOSE_BIT_FLAG_SIZE - 12] = utf8
        flagArr[GENERAL_PURPOSE_BIT_FLAG_SIZE - 1] = encrypted
        var sum: Int64 = 0
        for (index in 0..GENERAL_PURPOSE_BIT_FLAG_SIZE) {
            sum += flagArr[index] * (2 ** UInt64(GENERAL_PURPOSE_BIT_FLAG_SIZE - index - 1))
        }
        return sum
    }

    let CRC_TABLE = [
        0x00000000,
        0x77073096,
        0xEE0E612C,
        0x990951BA,
        0x076DC419,
        0x706AF48F,
        0xE963A535,
        0x9E6495A3,
        0x0EDB8832,
        0x79DCB8A4,
        0xE0D5E91E,
        0x97D2D988,
        0x09B64C2B,
        0x7EB17CBD,
        0xE7B82D07,
        0x90BF1D91,
        0x1DB71064,
        0x6AB020F2,
        0xF3B97148,
        0x84BE41DE,
        0x1ADAD47D,
        0x6DDDE4EB,
        0xF4D4B551,
        0x83D385C7,
        0x136C9856,
        0x646BA8C0,
        0xFD62F97A,
        0x8A65C9EC,
        0x14015C4F,
        0x63066CD9,
        0xFA0F3D63,
        0x8D080DF5,
        0x3B6E20C8,
        0x4C69105E,
        0xD56041E4,
        0xA2677172,
        0x3C03E4D1,
        0x4B04D447,
        0xD20D85FD,
        0xA50AB56B,
        0x35B5A8FA,
        0x42B2986C,
        0xDBBBC9D6,
        0xACBCF940,
        0x32D86CE3,
        0x45DF5C75,
        0xDCD60DCF,
        0xABD13D59,
        0x26D930AC,
        0x51DE003A,
        0xC8D75180,
        0xBFD06116,
        0x21B4F4B5,
        0x56B3C423,
        0xCFBA9599,
        0xB8BDA50F,
        0x2802B89E,
        0x5F058808,
        0xC60CD9B2,
        0xB10BE924,
        0x2F6F7C87,
        0x58684C11,
        0xC1611DAB,
        0xB6662D3D,
        0x76DC4190,
        0x01DB7106,
        0x98D220BC,
        0xEFD5102A,
        0x71B18589,
        0x06B6B51F,
        0x9FBFE4A5,
        0xE8B8D433,
        0x7807C9A2,
        0x0F00F934,
        0x9609A88E,
        0xE10E9818,
        0x7F6A0DBB,
        0x086D3D2D,
        0x91646C97,
        0xE6635C01,
        0x6B6B51F4,
        0x1C6C6162,
        0x856530D8,
        0xF262004E,
        0x6C0695ED,
        0x1B01A57B,
        0x8208F4C1,
        0xF50FC457,
        0x65B0D9C6,
        0x12B7E950,
        0x8BBEB8EA,
        0xFCB9887C,
        0x62DD1DDF,
        0x15DA2D49,
        0x8CD37CF3,
        0xFBD44C65,
        0x4DB26158,
        0x3AB551CE,
        0xA3BC0074,
        0xD4BB30E2,
        0x4ADFA541,
        0x3DD895D7,
        0xA4D1C46D,
        0xD3D6F4FB,
        0x4369E96A,
        0x346ED9FC,
        0xAD678846,
        0xDA60B8D0,
        0x44042D73,
        0x33031DE5,
        0xAA0A4C5F,
        0xDD0D7CC9,
        0x5005713C,
        0x270241AA,
        0xBE0B1010,
        0xC90C2086,
        0x5768B525,
        0x206F85B3,
        0xB966D409,
        0xCE61E49F,
        0x5EDEF90E,
        0x29D9C998,
        0xB0D09822,
        0xC7D7A8B4,
        0x59B33D17,
        0x2EB40D81,
        0xB7BD5C3B,
        0xC0BA6CAD,
        0xEDB88320,
        0x9ABFB3B6,
        0x03B6E20C,
        0x74B1D29A,
        0xEAD54739,
        0x9DD277AF,
        0x04DB2615,
        0x73DC1683,
        0xE3630B12,
        0x94643B84,
        0x0D6D6A3E,
        0x7A6A5AA8,
        0xE40ECF0B,
        0x9309FF9D,
        0x0A00AE27,
        0x7D079EB1,
        0xF00F9344,
        0x8708A3D2,
        0x1E01F268,
        0x6906C2FE,
        0xF762575D,
        0x806567CB,
        0x196C3671,
        0x6E6B06E7,
        0xFED41B76,
        0x89D32BE0,
        0x10DA7A5A,
        0x67DD4ACC,
        0xF9B9DF6F,
        0x8EBEEFF9,
        0x17B7BE43,
        0x60B08ED5,
        0xD6D6A3E8,
        0xA1D1937E,
        0x38D8C2C4,
        0x4FDFF252,
        0xD1BB67F1,
        0xA6BC5767,
        0x3FB506DD,
        0x48B2364B,
        0xD80D2BDA,
        0xAF0A1B4C,
        0x36034AF6,
        0x41047A60,
        0xDF60EFC3,
        0xA867DF55,
        0x316E8EEF,
        0x4669BE79,
        0xCB61B38C,
        0xBC66831A,
        0x256FD2A0,
        0x5268E236,
        0xCC0C7795,
        0xBB0B4703,
        0x220216B9,
        0x5505262F,
        0xC5BA3BBE,
        0xB2BD0B28,
        0x2BB45A92,
        0x5CB36A04,
        0xC2D7FFA7,
        0xB5D0CF31,
        0x2CD99E8B,
        0x5BDEAE1D,
        0x9B64C2B0,
        0xEC63F226,
        0x756AA39C,
        0x026D930A,
        0x9C0906A9,
        0xEB0E363F,
        0x72076785,
        0x05005713,
        0x95BF4A82,
        0xE2B87A14,
        0x7BB12BAE,
        0x0CB61B38,
        0x92D28E9B,
        0xE5D5BE0D,
        0x7CDCEFB7,
        0x0BDBDF21,
        0x86D3D2D4,
        0xF1D4E242,
        0x68DDB3F8,
        0x1FDA836E,
        0x81BE16CD,
        0xF6B9265B,
        0x6FB077E1,
        0x18B74777,
        0x88085AE6,
        0xFF0F6A70,
        0x66063BCA,
        0x11010B5C,
        0x8F659EFF,
        0xF862AE69,
        0x616BFFD3,
        0x166CCF45,
        0xA00AE278,
        0xD70DD2EE,
        0x4E048354,
        0x3903B3C2,
        0xA7672661,
        0xD06016F7,
        0x4969474D,
        0x3E6E77DB,
        0xAED16A4A,
        0xD9D65ADC,
        0x40DF0B66,
        0x37D83BF0,
        0xA9BCAE53,
        0xDEBB9EC5,
        0x47B2CF7F,
        0x30B5FFE9,
        0xBDBDF21C,
        0xCABAC28A,
        0x53B39330,
        0x24B4A3A6,
        0xBAD03605,
        0xCDD70693,
        0x54DE5729,
        0x23D967BF,
        0xB3667A2E,
        0xC4614AB8,
        0x5D681B02,
        0x2A6F2B94,
        0xB40BBE37,
        0xC30C8EA1,
        0x5A05DF1B,
        0x2D02EF8D
    ]
    
    public func crc32(bytes: Array<UInt8>): Int64 {
        var crc = 0xffffffff;
        for (b in bytes) {
            crc = (Int64(UInt64(crc) >> UInt64(8)) ^ CRC_TABLE[(crc ^ Int64(b)) & 0xff])
        }

        crc = crc ^ 0xffffffff
        return crc
    }
}
