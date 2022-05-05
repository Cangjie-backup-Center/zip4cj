package zip4cj

/*
 * Create a custom type called CentralDirectoryRecord.
 * Define the central directory field.
 *
 * @author      lizhenjie
 */
record CentralDirectoryRecord {
    public var signature: Int64 = 0
    public var sizeOfZip64EndOfCentral: Int64 = 0
    public var directoryRecord: Int64 = 0
    public var versionMadeBy: Int64 = 0
    public var versionExtract: Int64 = 0
    public var generalPurposeBitFlag: Int64 = 0
    public var compressionMethod: Int64 = 0
    public var lastModFileTime: Int64 = 0
    public var lastModFileDate: Int64 = 0
    public var crc32: Int64 = 0
    public var compressedSize: Int64 = 0
    public var uncompressedSize: Int64 = 0
    public var fileNameLength: Int64 = 0
    public var commentLength: Int64 = 0
    public var extraFieldLength: Int64 = 0
    public var offsetOfStartOfCentralDirectory: Int64 = 0
    public var internalFileAttributes: Int64 = 0
    public var externalFileAttributes: Int64 = 0
    public var relativeOffSetOfLocalFileHeader: Int64 = 0
    public var fileName: String = ""
    public var isDirectory: Bool = false
    public var isEncrypted = false
    public var isUtf8 = false
    public init(
        signature: Int64,
        versionMadeBy: Int64,
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
        commentLength: Int64,
        offsetOfStartOfCentralDirectory: Int64,
        internalFileAttributes: Int64,
        externalFileAttributes: Int64,
        relativeOffSetOfLocalFileHeader: Int64,
        fileName: String,
        isDirectory: Bool
    ) {
        this.signature = signature
        this.versionMadeBy = versionMadeBy
        this.versionExtract = versionExtract
        this.generalPurposeBitFlag = generalPurposeBitFlag
        this.compressionMethod = compressionMethod
        this.lastModFileTime = lastModFileTime
        this.lastModFileDate = lastModFileDate
        this.crc32 = crc32
        this.compressedSize = compressedSize
        this.uncompressedSize = uncompressedSize
        this.fileNameLength = fileNameLength
        this.commentLength = commentLength
        this.extraFieldLength = extraFieldLength
        this.offsetOfStartOfCentralDirectory = offsetOfStartOfCentralDirectory
        this.internalFileAttributes = internalFileAttributes
        this.externalFileAttributes = externalFileAttributes
        this.relativeOffSetOfLocalFileHeader = relativeOffSetOfLocalFileHeader
        this.fileName = fileName
        this.isDirectory = isDirectory
    }
    public init(
        signature: Int64,
        versionMadeBy: Int64,
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
        commentLength: Int64,
        offsetOfStartOfCentralDirectory: Int64,
        internalFileAttributes: Int64,
        externalFileAttributes: Int64,
        relativeOffSetOfLocalFileHeader: Int64,
        fileName: String
    ) {
        this.signature = signature
        this.versionMadeBy = versionMadeBy
        this.versionExtract = versionExtract
        this.generalPurposeBitFlag = generalPurposeBitFlag
        this.compressionMethod = compressionMethod
        this.lastModFileTime = lastModFileTime
        this.lastModFileDate = lastModFileDate
        this.crc32 = crc32
        this.compressedSize = compressedSize
        this.uncompressedSize = uncompressedSize
        this.fileNameLength = fileNameLength
        this.commentLength = commentLength
        this.extraFieldLength = extraFieldLength
        this.offsetOfStartOfCentralDirectory = offsetOfStartOfCentralDirectory
        this.internalFileAttributes = internalFileAttributes
        this.externalFileAttributes = externalFileAttributes
        this.relativeOffSetOfLocalFileHeader = relativeOffSetOfLocalFileHeader
        this.fileName = fileName
    }
    public mut func setEncrypted(isEncrypted: Bool) {
        this.isEncrypted = isEncrypted
    }
    public mut func setUtf8(isUtf8: Bool) {
        this.isUtf8 = isUtf8
    }
}
