/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

/**
 * @file
 *
 * This is a class that provides compression and decompression functions.
 * Provides function such as compress deCompress.
 */

package zip4cj.gzip
from compress import zlib.*
from std import collection.*
from std import io.*
import zip4cj.utils.FileUtils

/**
 * This class provides compression and decompression of gzip
 * @since 0.28.4    @author lizhenjie
 */
public open class GZUtils {

    /**
     * Gzip compression method
     *
     * @param filePath Compressed file path
     * @param level Compressed level
     * @param outFileName Output file name after compression
     *
     * @return Returns the file name and compressed data
     * @since 0.28.4
     */
     
   public static func compress(filePath: String, level: UInt32, outFileName: String): (String, Array<UInt8>) {
        var fileInfo = FileInfo(filePath)
        if (!fileInfo.exist()) {
            throw RuntimeException("file not exist!")
        }
        var fileStream = FileStream(fileInfo)
        var input = Array<UInt8>()
        if (fileStream.openFile()) {
            input = fileStream.readAllBytes()
        }
        var path = fileInfo.getPath()
        var start = 0
        if (path.contains("\\")) {
            match (path.lastIndexOf('\\')) {
                case Some(value) => start = value
                case None => start = 0
            }
        }else {
            match (path.lastIndexOf('/')) {
                case Some(value) => start = value
                case None => start = 0
            }
        }
        let fileName = path.slice(start+1, path.size()-start-1)
        var retbuf = Array<UInt8>()
        if (input.size() > 0) {
            var deflate = Deflate()
            var comprLen = input.size()
            var ret: UInt32 = 0
            deflate.deflateInit(
                wrap: WrapType.GZIP,
                level: level,
                wbits: DEF_WINDOW_BITS,
                mlevel: DEF_MEM_LEVEL,
                strategy: Z_DEFAULT_STRATEGY
            )
            var outlength = deflate.deflateBound(input.size())
            var outbuf = Array<UInt8>(outlength, {i => 0})
            deflate.setInBuf(input)
            deflate.setOutBuf(outbuf)
            var gzhead = GzHeader()
            gzhead.name = Buffer(fileName.toUtf8Array())
            deflate.setGzipHeader(gzhead)
            ret = deflate.deflate(Z_FINISH)
            ret = deflate.deflateEnd()
            var fileName = ""
            if (outFileName.endsWith(".gz")) {
                fileName = outFileName
            } else {
                fileName = outFileName + ".gz"
            }
            return (fileName, outbuf[0..deflate.getOutDataLength()])
        }
        return ("", retbuf)
    }

    /**
     * decompressed gzip file
     *
     * @param filePath The path of the file that needs to be unzipped
     *
     * @return Returns the file name and compressed data
     * @since 0.28.4
     */
    public static func deCompress(filePath: String): (String, ArrayList<UInt8>) {
        return deCompress(FileUtils.readFile(filePath))
    }

    /**
     * decompressed gzip file
     *
     * @param input Data to be decompressed
     *
     * @return Returns the unzipped file name and compressed data
     * @since 0.28.4
     */
   public static  func  deCompress(input: Array<UInt8>): (String, ArrayList<UInt8>) {
        var retbuf: ArrayList<UInt8> = ArrayList<UInt8>()
        if (input.size() > 0) {
            var inflate = Inflate()
            var comprLen = input.size()
            var ret: UInt32 = 0
            var outbuf = Array<UInt8>(comprLen, {i => 0})
            inflate.inflateInit(wrap: WrapType.GZIP, wbits: DEF_WINDOW_BITS, ischeck: true)
            inflate.setInBuf(input)
            inflate.setOutBuf(outbuf)
            var gzhead = GzHeader()
            inflate.getGzipHeader(gzhead)
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
                    println("err zlibUnCompressGz()" + inflate.message)
                    break
                }
            }
            ret = inflate.inflateEnd()
            var nameArr = Array<UInt8>(gzhead.name)
            var fileName = String.fromUtf8(nameArr, start: 0, length: nameArr.size(), isAscii: true)
            return (fileName, retbuf)
        }
        return ("", retbuf)
    }
}
