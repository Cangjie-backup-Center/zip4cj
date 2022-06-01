/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.
 */

/**
 * @file
 *
 * This is a custom type that provides local headers.
 */

package zip4cj.zip

/*
 * Create a custom type called LocalFileHeader.
 * Define the local file header field.
 *
 * @since 0.28.4    @author lizhenjie
 */
public record LocalFileHeader {

    public var signature: Int64 = 0
    public var versionExtract: Int64 = 0
    public var generalPurposeBitFlag: Int64 = 0
    public var compressionMethod: Int64 = 0
    public var lastModFileTime: Int64 = 0
    public var lastModFileDate: Int64 = 0
    public var crc32: Int64 = 0
    public var compressedSize: Int64 = 0
    public var uncompressedSize: Int64 = 0
    public var fileNameLength: Int64 = 0
    public var extraFieldLength: Int64 = 0
    public var fileName: String = ""
    public var extraField: Int64 = 0
    public var inflateData=Array<UInt8>()
    public LocalFileHeader(
        signature:Int64,
        versionExtract: Int64,
        generalPurposeBitFlag: Int64,
        compressionMethod: Int64,
        lastModFileTime: Int64,
        lastModFileDate: Int64,
        crc32: Int64,
        compressedSize: Int64,
        uncompressedSize: Int64,
        fileNameLength: Int64,
        extraFieldLength: Int64,
        fileName: String,
        inflateData:Array<UInt8>
    ) {
        this.signature = signature
        this.versionExtract = versionExtract
        this.generalPurposeBitFlag = generalPurposeBitFlag
        this.compressionMethod = compressionMethod
        this.lastModFileTime = lastModFileTime
        this.lastModFileDate = lastModFileDate
        this.crc32 = crc32
        this.compressedSize = compressedSize
        this.uncompressedSize = uncompressedSize
        this.fileNameLength = fileNameLength
        this.extraFieldLength = extraFieldLength
        this.fileName = fileName
        this.inflateData=inflateData
    }
}
