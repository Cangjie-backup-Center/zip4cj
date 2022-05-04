package zip4cj
/*
 * Create a custom type called LocalFileHeader.
 * Define the local file header field.
 *
 * @author      lizhenjie
 */
record LocalFileHeader {

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
    public init() {
        
    }
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
    public mut func setSignature(signature: Int64) {
        this.signature = signature
    }
    public mut func setVersionExtract(versionExtract: Int64) {
        this.versionExtract = versionExtract
    }
    public mut func setGeneralPurposeBitFlag(generalPurposeBitFlag: Int64) {
        this.generalPurposeBitFlag = generalPurposeBitFlag
    }
    public mut func setCompressionMethod(compressionMethod: Int64) {
        this.compressionMethod = compressionMethod
    }
    public mut func setLastModFileTime(lastModFileTime: Int64) {
        this.lastModFileTime = lastModFileTime
    }
    public mut func setLastModFileDate(lastModFileDate: Int64) {
        this.lastModFileDate = lastModFileDate
    }
    public mut func setCrc32(crc32: Int64) {
        this.crc32 = crc32
    }
    public mut func setCompressedSize(compressedSize: Int64) {
        this.compressedSize = compressedSize
    }
    public mut func setUncompressedSize(uncompressedSize: Int64) {
        this.uncompressedSize = uncompressedSize
    }
    public mut func setFileNameLength(fileNameLength: Int64) {
        this.fileNameLength = fileNameLength
    }
    public mut func setExtraFieldLength(extraFieldLength: Int64) {
        this.extraFieldLength = extraFieldLength
    }
    public mut func setFileName(fileName: String) {
        this.fileName = fileName
    }
    public mut func setExtraField(extraField: Int64) {
        this.extraField = extraField
    }
}
