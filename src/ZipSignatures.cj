package zip4cj

abstract class ZipSignatures <: ZipConstants {
    /*
     * Local file (LOC) header signature
     */
    static let LOCSIG: Int64 = 0x04034b50 // "PK\003\004"

    /*
     * The data descriptor record  signature
     */
    static let EXTSIG: Int64 = 0x08074b50 // "PK\007\008"

    /*
     * Central directory file (CEN) header signature
     */
    static let CENSIG: Int64 = 0x02014b50 // "PK\001\002"

    /*
     * End of central directory(END) signature
     */
    static let ENDSIG: Int64 = 0x06054b50 // "PK\005\006"

    /*
     * ZIP64 end of central directory(ZIP64_END) signature
     */
    static let ZIP64_ENDSIG: Int64 = 0x06064b50 // "PK\006\006"

    /*
     *  ZIP64 local file (ZIP64_LOC) header signature
     */
    static let ZIP64_LOCSIG: Int64 = 0x07064b50 // "PK\006\007"
}
