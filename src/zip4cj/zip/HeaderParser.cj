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
from std import io.*

/*
 * Parse zip Header information
 * @since0.28.4    @author lizhenjie
 */
open class HeaderParser <: ZipSignatures {
    private let HEXADECIMAL = 16
    private let logger = SimpleLogger()
    private var outPath = ""
    private static let CRC32_TABLE = crcTable();
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
            readShortLittleEndian(fileHeaderBuffer, LOC_HDR_HOW_OFFSET)
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
            localFileHeaderSigStartPosition.append(fileStartIndex)
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
    public func parseLocalFileHeader(
        buff: Array<UInt8>,
        fileType: HashMap<String, CentralDirectoryRecord>,
        endCDR: EndCDR
    ): ArrayList<LocalFileHeader> {
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
                end = localFileHeaderSigStartPosition[index + 1]
            }
            var buffer = subArray(buff, start, end)
            var sig = readIntLittleEndian(buffer, LOC_HDR_SIG_OFFSET)
            var version = readShortLittleEndian(buffer, LOC_HDR_VER_OFFSET)
            var flag = readShortLittleEndian(buffer, LOC_HDR_FLG_OFFSET)
            var flagArr = MsDosUtils.convertToBinary(flag, length: 16)
            var meth = readShortLittleEndian(buffer, LOC_HDR_HOW_OFFSET)
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
                    LOC_HDR_FNM_OFFSET + fileNameLength + extraFieldLength,
                    LOC_HDR_FNM_OFFSET + fileNameLength + extraFieldLength + compressedSize
                )
            }
            var fType = fileType[fileName]
            if (!fType.isDirectory) {
                match (meth) {
                    case 0 => logger.info(fileName + "解压完成") //STORE
                    case 8 =>
                        sub = Array(zipInflate(sub, uncompressedSize))
                        logger.info(fileName + "解压完成")
                    case 99 => //AES_INTERNAL_ONLY
                        logger.info("Compression method:${meth} does not support!")
                    case _ => throw ZipException("Compression method:${meth} does not support!")
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
    private func zipDeflate(fileData: Array<UInt8>): Array<UInt8> {
        var outputDataStream: ByteArrayStream = ByteArrayStream()
        var cos = CompressOutputStream(outputDataStream, wrap: DeflateFormat)
        cos.write(fileData)
        cos.flush()
        cos.close()
        return outputDataStream.bytes()
    }
    private func zipInflate(data: Array<UInt8>, size: Int64): ArrayList<UInt8> {
        var retbuf: ArrayList<UInt8> = ArrayList<UInt8>()
        var tempBuf: Array<UInt8> = Array<UInt8>(2048, item: 0)
        var bas: ByteArrayStream = ByteArrayStream()
        bas.write(data)
        var decompressInputStream = DecompressInputStream(bas, wrap: DeflateFormat)
        while (true) {
            var readNum = decompressInputStream.read(tempBuf)
            if (readNum <= 0) {
                break
            }
            retbuf.appendAll(tempBuf);
        }
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
            var fileNameArr = Array<UInt8>(fileNameLength, item: 0)
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
            if (outPath != "" && cdr.isDirectory) {
                var file = FileUtils.getFilePath(outPath, cdr.fileName)
                file = String(file.toRuneArray().slice(0, file.toRuneArray().size - 1))
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
        let offsetOfStartOfCentralDirectory = endCDR.offsetOfStartOfCentralDirectory
        var cdrBuff = subArray(buff, offsetOfStartOfCentralDirectory, buff.size)
        var size = cdrBuff.size
        var startPos = 0
        var nextPos = 0
        var map = HashMap<Int64, Array<UInt8>>()
        var entryIndex = 0
        for (index in 0..size) {
            if (index + 3 >= size) {
                var arr = Array<UInt8>(size - nextPos, item: 0)
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
                    var arr = Array<UInt8>(nextPos - startPos, item: 0)
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
        if (toIndex - fromIndex < 0) {
            throw ZipException("The zip file is corrupted.")
        }
        return arr[fromIndex..toIndex]
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
        var arr = Array<UInt8>(length - startPos, item: 0)
        var i = 0
        for (index in startPos..length) {
            arr[i] = buff[index]
            i++
        }
        return arr
    }
    private func readLongLittleEndian(buff: Array<UInt8>, pos: Int64): Int64 {
        var longBuff = Array<Int64>(8, item: 0)
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

    func convertToLittleEndian(value: Int64, length!: Int64 = 2): Array<UInt8> {
        var result = Array<UInt8>(length, item: 0)
        var num = value
        for (i in 0..length) {
            result[i] = UInt8(num & 0xff)
            num >>= 8
        }
        return result
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
        valArr.appendAll(cdr.fileName.toArray())
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
        valArr.appendAll(lfh.fileName.toArray())
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
            valArr.appendAll(endCDR.comment.toArray())
        }
        return valArr
    }

    /*
     * Write data to Zip File
     *
     * @param files Zip File data
     *
     * @since 0.28.4
     */
    public func writeZipFile(files: HashSet<String>) {
        var fileNum = files.size
        var time = DateTime.now()
        var localFileLst = ArrayList<UInt8>()
        var cdrLst = ArrayList<UInt8>()
        for (file in files) {
            let fileData = FileUtils.readFile(file)
            let deflate = zipDeflate(fileData)
            let fileName = FileUtils.getFileName(file)
            let fileNameLength = fileName.toArray().size
            let compressedSize = deflate.size
            let uncompressedSize = fileData.size
            var crc = crc32(fileData)
            var lfh: LocalFileHeader = LocalFileHeader(
                LOCSIG,
                20,
                generalPurposeBitFlag(),
                CompressionMethod.DEFLATE,
                MsDosUtils.getLastModFileTime(time),
                MsDosUtils.getLastModFileDate(time),
                Int64(crc),
                compressedSize,
                uncompressedSize,
                fileNameLength,
                0,
                fileName,
                Array<UInt8>()
            )
            var relativeOffSetOfLocalFileHeader = localFileLst.size
            var lfhArrayList = writeLocalFileHeader(lfh)
            localFileLst.appendAll(lfhArrayList)
            localFileLst.appendAll(deflate)
            var cdr: CentralDirectoryRecord = CentralDirectoryRecord(
                CENSIG,
                20,
                20,
                generalPurposeBitFlag(),
                CompressionMethod.DEFLATE,
                MsDosUtils.getLastModFileTime(time),
                MsDosUtils.getLastModFileDate(time),
                Int64(crc),
                compressedSize,
                uncompressedSize,
                fileNameLength,
                0,
                0,
                0,
                0,
                0,
                relativeOffSetOfLocalFileHeader,
                fileName
            )
            var cdrData = writeCentralDirectoryRecord(cdr)
            cdrLst.appendAll(cdrData)
        }
        var offsetOfStartOfCentralDirectory = localFileLst.size
        localFileLst.appendAll(cdrLst)
        var offsetOfEndOfCentralDirectory = localFileLst.size
        var sizeOfCentralDirectory = cdrLst.size
        var endCDR: EndCDR = EndCDR(
            ENDSIG,
            0,
            0,
            fileNum,
            fileNum,
            sizeOfCentralDirectory,
            offsetOfEndOfCentralDirectory,
            offsetOfStartOfCentralDirectory,
            0,
            ""
        )
        var endCDRLst = writeEndOfCentralDirectoryRecord(endCDR)
        localFileLst.appendAll(endCDRLst)
        FileUtils.writeFile(Array(localFileLst), outPath)
    }

    public func writeZipFile(dir: Directory) {
        var dirPath = dir.info.path.toString()
        var dirPathArr = dirPath.split("/")
        var files = getAllFile(dir)
        files.insert(0, dir.info)
        var fileNum = files.size
        var time = DateTime.now()
        var localFileLst = ArrayList<UInt8>()
        var cdrLst = ArrayList<UInt8>()
        for (file in files) {
            var fileData = Array<UInt8>()
            var deflate = Array<UInt8>()
            var compressionMethod = CompressionMethod.STORE
            var path = file.path.toString()
            var indexOf: Option<Int64> = path.indexOf(dirPathArr[dirPathArr.size - 1])
            var fileName = String(path.toRuneArray().slice(indexOf.getOrThrow(), path.toRuneArray().size - indexOf.getOrThrow()))
            if (file.isFile()) {
                fileData = File.readFrom(file.path)
                deflate = zipDeflate(fileData)
                compressionMethod = CompressionMethod.DEFLATE
            } else {
                fileName = fileName + "/"
            }

            let fileNameLength = fileName.toArray().size
            let compressedSize = deflate.size
            let uncompressedSize = fileData.size
            var crc = crc32(fileData)
            var lfh: LocalFileHeader = LocalFileHeader(
                LOCSIG,
                20,
                generalPurposeBitFlag(),
                compressionMethod,
                MsDosUtils.getLastModFileTime(time),
                MsDosUtils.getLastModFileDate(time),
                Int64(crc),
                compressedSize,
                uncompressedSize,
                fileNameLength,
                0,
                fileName,
                Array<UInt8>()
            )
            var relativeOffSetOfLocalFileHeader = localFileLst.size
            var lfhArrayList = writeLocalFileHeader(lfh)
            localFileLst.appendAll(lfhArrayList)
            localFileLst.appendAll(deflate)
            var cdr: CentralDirectoryRecord = CentralDirectoryRecord(
                CENSIG,
                20,
                20,
                generalPurposeBitFlag(),
                compressionMethod,
                MsDosUtils.getLastModFileTime(time),
                MsDosUtils.getLastModFileDate(time),
                Int64(crc),
                compressedSize,
                uncompressedSize,
                fileNameLength,
                0,
                0,
                0,
                0,
                0,
                relativeOffSetOfLocalFileHeader,
                fileName
            )
            var cdrData = writeCentralDirectoryRecord(cdr)
            cdrLst.appendAll(cdrData)
        }
        var offsetOfStartOfCentralDirectory = localFileLst.size
        localFileLst.appendAll(cdrLst)
        var offsetOfEndOfCentralDirectory = localFileLst.size
        var sizeOfCentralDirectory = cdrLst.size
        var endCDR: EndCDR = EndCDR(
            ENDSIG,
            0,
            0,
            fileNum,
            fileNum,
            sizeOfCentralDirectory,
            offsetOfEndOfCentralDirectory,
            offsetOfStartOfCentralDirectory,
            0,
            ""
        )
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
        var flagArr = Array<Int64>(GENERAL_PURPOSE_BIT_FLAG_SIZE, item: 0)
        flagArr[GENERAL_PURPOSE_BIT_FLAG_SIZE - 12] = utf8
        flagArr[GENERAL_PURPOSE_BIT_FLAG_SIZE - 1] = encrypted
        var sum: Int64 = 0
        for (index in 0..GENERAL_PURPOSE_BIT_FLAG_SIZE) {
            sum += flagArr[index] * (2 ** UInt64(GENERAL_PURPOSE_BIT_FLAG_SIZE - index - 1))
        }
        return sum
    }

    private static func crcTable(): Array<Int64> {
        var crcTable = Array<Int64>(256, item: 0)
        for (i in 0..256) {
            var crc = i
            for (j in 0..8) {
                (j)
                if ((crc & 1) == 1) {
                    crc = Int64(UInt64(crc) >> UInt64(1)) ^ 0xEDB88320
                } else {
                    crc = Int64(UInt64(crc) >> UInt64(1))
                }
            }
            crcTable[i] = crc
        }
        return crcTable
    }

    public func crc32(bytes: Array<UInt8>): Int64 {
        var crc = 0xffffffff;
        for (b in bytes) {
            crc = (Int64(UInt64(crc) >> UInt64(8)) ^ CRC32_TABLE[(crc ^ Int64(b)) & 0xff])
        }
        crc = crc ^ 0xffffffff
        return crc
    }
    private func getAllFile(dir: Directory): ArrayList<FileInfo> {
        let fileList = ArrayList<FileInfo>()
        for (item in dir.entryList()) {
            fileList.append(item)
            if (item.isDirectory()) {
                fileList.appendAll(getAllFile(Directory(item.path)))
            }
        }
        return fileList
    }
}
