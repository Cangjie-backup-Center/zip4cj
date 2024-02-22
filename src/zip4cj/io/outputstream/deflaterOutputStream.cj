package zip4cj.io.outputstream

class DeflaterOutputStream <: CompressedOutputStream {
    private var buffer: ?BufferedOutputStream<CipherOutputStream> = None
    private var closed: Bool = false
    private var compressionLevel: CompressionLevel
    private var cipherOutputStream: CipherOutputStream
    private var bufferSize: Int64
    public init(cipherOutputStream: CipherOutputStream, compressionLevel: CompressionLevel, bufferSize: Int64) {
        super(cipherOutputStream)
        this.cipherOutputStream = cipherOutputStream
        this.compressionLevel = compressionLevel
        this.bufferSize = bufferSize
    }

    public func write(b: Array<UInt8>): Unit {
        if (compressionLevel.getLevel() == 0) {
            if (let Some(v) <- this.buffer) {
                v.write(b)
            } else {
                let buf = BufferedOutputStream<CipherOutputStream>(cipherOutputStream, bufferSize)
                buf.write(b)
                this.buffer = buf
            }
            return
        }
        let deflater = match (compressionLevel.getLevel()) {
            case 1 | 2 | 3 => CompressOutputStream(cipherOutputStream, compressLevel: BestSpeed, bufLen: bufferSize)
            case 4 | 5 | 6 => CompressOutputStream(cipherOutputStream, compressLevel: DefaultCompression,
                bufLen: bufferSize)
            case 7 | 8 | 9 => CompressOutputStream(cipherOutputStream, compressLevel: BestCompression,
                bufLen: bufferSize)
            case _ => throw NoneValueException()
        }
        deflater.write(b)
        deflater.close()
    }

    public func closeEntry(): Unit {
        super.closeEntry()
    }
}
