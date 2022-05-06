package zip4cj

from std import math.*
from std import io.*
from std import log.*

/*
 * Parse zip Header information
 * @author      lizhenjie
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

    /*
     *Parse local file header
     */
    public func parseLocalFileHeader(buff: Array<UInt8>, fileType: HashMap<String, CentralDirectoryRecord>): ArrayList<LocalFileHeader> {
        var length = buff.size()
        var localFileHeaderSigStartPosition = ArrayList<Int64>()
        for (index in 0..length) {
            if (index + 3 >= length) {
                break
            }
            var buffer = Array<UInt8>([buff[index], buff[index + 1], buff[index + 2], buff[index + 3]])
            var locSig = readIntLittleEndian(buffer, LOC_HDR_SIG_OFFSET)
            if (locSig == LOCSIG) {
                localFileHeaderSigStartPosition.add(index)
            }
        }
        localFileHeaderSigStartPosition.add(length)
        var size = localFileHeaderSigStartPosition.size()
        var lfhList = ArrayList<LocalFileHeader>()
        for (index in 0..size) {
            if (index + 1 >= size) {
                break
            }
            var start = localFileHeaderSigStartPosition[index]
            var end = localFileHeaderSigStartPosition[index + 1]
            var buffer = subArray(buff, start, end)
            var sig = readIntLittleEndian(buffer, LOC_HDR_SIG_OFFSET)
            var version = readShortLittleEndian(buffer, LOC_HDR_VER_OFFSET)
            var flag = readShortLittleEndian(buffer, LOC_HDR_FLG_OFFSET)
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
            var fileName = String.fromUtf8(fileNameArr, start: 0, length: fileNameLength, isAscii: true)
            var sub = subArray(
                buffer,
                LOC_HDR_FNM_OFFSET + fileNameLength,
                LOC_HDR_FNM_OFFSET + fileNameLength + compressedSize
            )
            var fType = fileType[fileName]
            if (!fType.isDirectory) {
                match (meth) {
                    case 0 => logger.info("No need to decompress!") //STORE
                    case 8 =>
                        //DEFLATE
                        sub = Array(zipInflate(sub))
                        logger.info("Unpack the success")
                    case 99 => //AES_INTERNAL_ONLY
                        logger.info("Compression method:$[meth} does not support!")
                    case _ => throw RuntimeException("Compression method:$[meth} does not support!")
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
            lfhList.add(lfh)
        }
        return lfhList
    }

    /*
     * Zip deflate
     */
    private func zipDeflate(input: Array<UInt8>, param: ZipParams): Array<UInt8> {
        var deflate = Deflate()
        var comprLen = input.size()
        var ret: UInt32 = 0
        ret = deflate.deflateInit(
            wrap: WrapType.DEFLATE,
            level: param.level,
            wbits: DEF_WINDOW_BITS,
            mlevel: DEF_MEM_LEVEL,
            strategy: Z_DEFAULT_STRATEGY
        )
        var outlength = deflate.deflateBound(input.size())
        var outbuf = Array<UInt8>(outlength, {i => 0})
        deflate.setInBuf(input)
        deflate.setOutBuf(outbuf)
        ret = deflate.deflate(Z_FINISH)
        ret = deflate.deflateEnd()
        return outbuf[0..deflate.getOutDataLength()]
    }

    /*
     * Zip inflate
     */
    private func zipInflate(input: Array<UInt8>): ArrayList<UInt8> {
        var retbuf: ArrayList<UInt8> = ArrayList<UInt8>()
        if (input.size() > 0) {
            var inflate = Inflate()
            var comprLen = input.size()
            var ret: UInt32 = 0
            var outbuf = Array<UInt8>(comprLen, @overflowSaturating{i => 0})
            inflate.inflateInit(wrap: WrapType.DEFLATE, wbits: DEF_WINDOW_BITS, ischeck: true)
            inflate.setInBuf(input)
            inflate.setOutBuf(outbuf)
            while (true) {
                ret = inflate.inflate(Z_NO_FLUSH)
                if (ret == Z_OK) {
                    if (inflate.isHaveOutData()) {
                        retbuf.addAll(outbuf[0..inflate.getOutDataLength()])
                        inflate.resetOutBuf()
                    }
                } else if (ret == Z_STREAM_END) {
                    if (inflate.isHaveOutData()) {
                        retbuf.addAll(outbuf[0..inflate.getOutDataLength()])
                        inflate.resetOutBuf()
                    }
                    break
                } else {
                    throw RuntimeException("zip inflate" + inflate.message)
                }
            }
            ret = inflate.inflateEnd()
        }
        return retbuf
    }

    /*
     *Parse central directory record
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
                throw RuntimeException("Parse central directory record faild")
            }
            var versionMadeBy = readShortLittleEndian(buff, CEN_VEM_OFFSET)
            var versionNeededToExtract = readShortLittleEndian(buff, CEN_VER_OFFSET)
            var flag = readShortLittleEndian(buff, CEN_FLG_OFFSET)
            var flagArr = convertToLittleEndian(flag, length: 16)
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
            var fileName = String.fromUtf8(fileNameArr, start: 0, length: fileNameLength, isAscii: true)
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
            var length = flagArr.size()
            cdr.setEncrypted(flagArr[length - 1] != 0)
            cdr.setUtf8(flagArr[length - 11] != 0)
            var file = FileUtils.getFilePath(outPath, cdr.fileName)
            if (outPath != "" && cdr.isDirectory) {
                file = file.slice(0, file.size() - 1).toString()
                var dir = io.DirectoryInfo(file)
                if (!dir.exist()) {
                    dir.create()
                }
            }
            fileType.put(fileName, cdr)
        }

        return fileType
    }

    /*
     *Split central directory record
     */
    private func splitCentralDirectoryRecord(buff: Array<UInt8>, endCDR: EndCDR): HashMap<Int64, Array<UInt8>> {
        let entrieSize = endCDR.totalNumberOfEntriesInCentralDirectory
        let offsetOfStartOfCentralDirectory = endCDR.offsetOfStartOfCentralDirectory
        var cdrBuff = subArray(buff, offsetOfStartOfCentralDirectory, buff.size())
        var size = cdrBuff.size()
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
     *Interception of array
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
     *Parse end of central directory record
     *@param buff
     *return end of central directory record data
     */
    public func parseEndOfCentralDirectory(buff: Array<UInt8>): EndCDR {
        var arr = readEndOfCentralDirectoryRecord(buff)
        var ecdSize = arr.size()
        if (ecdSize < 1) {
            throw RuntimeException("End Of Central Directory Record is empty!")
        }
        var offsetOfEndOfCentralDirectory = buff.size() - arr.size()
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
     *Read end central directory records data
     */
    private func readEndOfCentralDirectoryRecord(buff: Array<UInt8>): Array<UInt8> {
        let length = buff.size()
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
            valArr.add(val % HEXADECIMAL)
            val = val / HEXADECIMAL
            if (val < HEXADECIMAL) {
                valArr.add(val)
                break
            }
        }
        if (valArr.size() % 2 != 0) {
            valArr.add(0)
        }
        valArr.reverse()
        let size = valArr.size() / 2
        var array = ArrayList<UInt8>()
        for (i in 0..size) {
            var first = valArr[i * 2]
            var second = valArr[i * 2 + 1]
            array.add(UInt8(first * HEXADECIMAL + second))
        }
        array.reverse()
        var arr = Array<UInt8>(length, {i => 0})
        for (index in 0..array.size()) {
            arr[index] = array[index]
        }
        return arr
    }

    public func writeCentralDirectoryRecord(cdr: CentralDirectoryRecord): ArrayList<UInt8> {
        var valArr = ArrayList<UInt8>()
        valArr.addAll(convertToLittleEndian(cdr.signature, length: 4))
        valArr.addAll(convertToLittleEndian(cdr.versionMadeBy))
        valArr.addAll(convertToLittleEndian(cdr.versionExtract))
        valArr.addAll(convertToLittleEndian(cdr.generalPurposeBitFlag))
        valArr.addAll(convertToLittleEndian(cdr.compressionMethod))
        valArr.addAll(convertToLittleEndian(cdr.lastModFileTime))
        valArr.addAll(convertToLittleEndian(cdr.lastModFileDate))
        valArr.addAll(convertToLittleEndian(cdr.crc32, length: 4))
        valArr.addAll(convertToLittleEndian(cdr.compressedSize, length: 4))
        valArr.addAll(convertToLittleEndian(cdr.uncompressedSize, length: 4))
        valArr.addAll(convertToLittleEndian(cdr.fileNameLength))
        valArr.addAll(convertToLittleEndian(cdr.extraFieldLength))
        valArr.addAll(convertToLittleEndian(cdr.commentLength))
        valArr.addAll(convertToLittleEndian(cdr.offsetOfStartOfCentralDirectory))
        valArr.addAll(convertToLittleEndian(cdr.internalFileAttributes))
        valArr.addAll(convertToLittleEndian(cdr.externalFileAttributes, length: 4))
        valArr.addAll(convertToLittleEndian(cdr.relativeOffSetOfLocalFileHeader, length: 4))
        valArr.addAll(cdr.fileName.toUtf8Array())
        return valArr
    }
    public func writeLocalFileHeader(lfh: LocalFileHeader): ArrayList<UInt8> {
        var valArr = ArrayList<UInt8>()
        valArr.addAll(convertToLittleEndian(lfh.signature, length: 4))
        valArr.addAll(convertToLittleEndian(lfh.versionExtract))
        valArr.addAll(convertToLittleEndian(lfh.generalPurposeBitFlag))
        valArr.addAll(convertToLittleEndian(lfh.compressionMethod))
        valArr.addAll(convertToLittleEndian(lfh.lastModFileTime))
        valArr.addAll(convertToLittleEndian(lfh.lastModFileDate))
        valArr.addAll(convertToLittleEndian(lfh.crc32, length: 4))
        valArr.addAll(convertToLittleEndian(lfh.compressedSize, length: 4))
        valArr.addAll(convertToLittleEndian(lfh.uncompressedSize, length: 4))
        valArr.addAll(convertToLittleEndian(lfh.fileNameLength))
        valArr.addAll(convertToLittleEndian(lfh.extraFieldLength))
        valArr.addAll(lfh.fileName.toUtf8Array())
        return valArr
    }
    public func writeEndOfCentralDirectoryRecord(endCDR: EndCDR): ArrayList<UInt8> {
        var valArr = ArrayList<UInt8>()
        valArr.addAll(convertToLittleEndian(endCDR.sig, length: 4))
        valArr.addAll(convertToLittleEndian(endCDR.diskNum))
        valArr.addAll(convertToLittleEndian(endCDR.numberOfThisDiskStartOfCentralDir))
        valArr.addAll(convertToLittleEndian(endCDR.totalNumberOfEntriesInCentralDirectoryOnThisDisk))
        valArr.addAll(convertToLittleEndian(endCDR.totalNumberOfEntriesInCentralDirectory))
        valArr.addAll(convertToLittleEndian(endCDR.sizeOfCentralDirectory, length: 4))
        valArr.addAll(convertToLittleEndian(endCDR.offsetOfStartOfCentralDirectory, length: 4))
        valArr.addAll(convertToLittleEndian(endCDR.commentLength))
        if (endCDR.comment != "") {
            valArr.addAll(endCDR.comment.toUtf8Array())
        }
        return valArr
    }

    public func writeZipFile(files: HashSet<String>, zipParam: ZipParams) {
        var fileNum = files.size()
        var time = Time.now(Location.Local)
        var localFileLst = ArrayList<UInt8>()
        var cdrLst = ArrayList<UInt8>()
        for (file in files) {
            let fileData = FileUtils.readFile(file)
            let deflate = zipDeflate(fileData, zipParam)
            let fileName = FileUtils.getFileName(file)
            let fileNameLength = fileName.toUtf8Array().size()
            let compressedSize = deflate.size()
            let uncompressedSize = fileData.size()
            var crc = zlib.crc32(0, fileData, 0, uncompressedSize)
            var lfh: LocalFileHeader = LocalFileHeader(
                LOCSIG,
                20,
                0,
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
            var relativeOffSetOfLocalFileHeader = localFileLst.size()
            var lfhArrayList = writeLocalFileHeader(lfh)
            localFileLst.addAll(lfhArrayList)
            localFileLst.addAll(deflate)
            var cdr: CentralDirectoryRecord = CentralDirectoryRecord(
                CENSIG,
                20,
                20,
                0,
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
            cdrLst.addAll(cdrData)
        }
        var offsetOfStartOfCentralDirectory = localFileLst.size()
        localFileLst.addAll(cdrLst)
        var offsetOfEndOfCentralDirectory = localFileLst.size()
        var sizeOfCentralDirectory = cdrLst.size()
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
        localFileLst.addAll(endCDRLst)
        FileUtils.writeFile(Array(localFileLst), outPath)
    }
}
