package zip4cj

public class CompressionMethod {
    /**
     * No compression is performed
     */
    public static let STORE = 0

    /**
     * The Deflate compression is used.
     * @see java.util.zip.Deflater
     */
    public static let DEFLATE = 8
}
