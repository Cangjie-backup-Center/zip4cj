package zip4cj.io.outputstream

public open class CompressedOutputStream <: OutputStream {
    private var cipherOutputStream: CipherOutputStream

    public init(cipherOutputStream: CipherOutputStream) {
        this.cipherOutputStream = cipherOutputStream
    }

    @OverflowWrapping
    public open func write(b: Int32): Unit {
        cipherOutputStream.write([UInt8(b)])
    }

    public open func write(b: Array<UInt8>): Unit {
        cipherOutputStream.write(b)
    }

    public open func write(b: Array<UInt8>, off: Int64, len: Int64): Unit {
        this.write(b[off..off + len])
    }

    public open func closeEntry(): Unit {
        cipherOutputStream.closeEntry()
    }

    public open func close(): Unit {
        cipherOutputStream.close()
    }

    public open func getCompressedSize(): Int64 {
        return cipherOutputStream.getNumberOfBytesWrittenForThisEntry()
    }

    public open func flush(): Unit {}
}
