package zip4cj.io.inputstream

public abstract class DecompressedInputStream <: InputStream {
    private var cipherInputStream: CipherInputStream
    protected var oneByteBuffer: Array<Byte> = Array<Byte>(1, item: 0)

    public init(cipherInputStream: CipherInputStream) {
        this.cipherInputStream = cipherInputStream
    }

    public open func read(): Int64 {
        if (read(oneByteBuffer) == -1) {
            return -1
        }
        return Int64(oneByteBuffer[0])
    }

    public open func read(b: Array<Byte>): Int64 {
        return cipherInputStream.read(b)
    }

    public open func read(b: Array<Byte>, off: Int64, len: Int64): Int64 {
        return this.read(b[off..off + len])
    }

    public open func close(): Unit {
        cipherInputStream.close()
    }

    public open func endOfEntryReached(inputStream: InputStream, numberOfBytesPushedBack: Int64): Unit {
        cipherInputStream.endOfEntryReached(inputStream, numberOfBytesPushedBack)
    }

    public open func pushBackInputStreamIfNecessary(pushbackInputStream: PushbackInputStream): Int64 {
        // Do nothing by default
        return 0
    }

    protected func getLastReadRawDataCache(): Array<Byte> {
        return cipherInputStream.getLastReadRawDataCache()
    }
}
