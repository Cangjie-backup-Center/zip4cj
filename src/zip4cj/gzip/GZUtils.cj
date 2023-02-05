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
from std import fs.*
from std import math.*
/**
 * This class provides compression and decompression of gzip
 * @since 0.28.4    @author lizhenjie
 */
public open class GZUtils {

    /**
     * Gzip compression method
     *
     * @param filePath 需要压缩的文件
     * @param outPath  压缩后输出的文件位置
     *
     * @return 返回压缩状态，小于等于 0 表示失败，大于 0 成功
     * @since 0.28.4
     */
    public static func compress(filePath: String, outPath: String): Int64 {
        if (!File.exists(filePath)) {
            throw GzipException("file not exist!")
        }
        if (!Directory.exists(outPath)) {
            Directory.create(outPath, recursive: true)
        }
        var file = File.openRead(filePath)
        var input = Array<UInt8>()
        if (file.canRead()) {
            input = file.readToEnd()
        }
        let fileName = file.info.path.fileName.getOrThrow()
        var count: Int64 = 0
        var srcFile: File = File(filePath, OpenOption.Open(true, false))
        var destFile: File = File(outPath + "/" + fileName + ".gz", OpenOption.Create(false))
        var tempBuf: Array<UInt8> = Array<UInt8>(1024, item: 0)
        var compressOutputStream: CompressOutputStream = CompressOutputStream(destFile, wrap: GzipFormat, bufLen: 10000)
        while (true) {
            var readNum = srcFile.read(tempBuf)
            if (readNum > 0) {
                compressOutputStream.write(tempBuf.slice(0, readNum).toArray())
                count += readNum
            } else {
                break
            }
        }
        compressOutputStream.flush()
        compressOutputStream.close()
        srcFile.close()
        destFile.close()
        return count
    }

    /**
     * decompressed gzip file
     *
     * @param filePath 需要解压的文件
     * @param outPath  解压后输出的文件位置
     *
     * @return 返回解压缩状态，小于等于 0 表示失败，大于 0 成功
     * @since 0.28.4
     */
    public static func decompress(filePath: String, outPath: String): Int64 {
        if (!File.exists(filePath)) {
            throw GzipException("file not exist!")
        }
        
        var count: Int64 = 0
        var srcFile: File = File(filePath, OpenOption.Open(true, false))
        var destFile: File = File(outPath, OpenOption.Create(false))
        var tempBuf: Array<UInt8> = Array<UInt8>(1024, item: 0)
        var decompressInputStream: DecompressInputStream = DecompressInputStream(
            srcFile,
            wrap: GzipFormat,
            bufLen: 10000
        )
        while (true) {
            var readNum = decompressInputStream.read(tempBuf)
            if (readNum <= 0) {
                break
            } 
            destFile.write(tempBuf.slice(0, readNum).toArray())
            count += readNum
        }
        decompressInputStream.close()
        srcFile.close()
        destFile.close()
        return count
    }
}
