package zip4cj.io.outputstream

public open class CompressedOutputStream <: OutputStream & Resource {
    private var cipherOutputStream: CipherOutputStream
    public init(cipherOutputStream: CipherOutputStream) {
        this.cipherOutputStream = cipherOutputStream
    }

    public open func write(b: Array<UInt8>): Unit {
        cipherOutputStream.write(b)
    }

    public open func closeEntry(): Unit {
        cipherOutputStream.closeEntry()
    }

    public open func close(): Unit {
        cipherOutputStream.close()
    }

    public open func isClosed(): Bool {
        (cipherOutputStream as Resource).getOrThrow().isClosed()
    }

    public open func getCompressedSize(): Int64 {
        return cipherOutputStream.getNumberOfBytesWrittenForThisEntry()
    }

    public open func flush(): Unit {}
}
