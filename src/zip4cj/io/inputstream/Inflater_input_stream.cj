package zip4cj.io.inputstream

public class InflaterInputStream <: DecompressedInputStream {
    private var inflater: DecompressInputStream
    private var buff: Array<Byte>
    private var singleByteBuffer = Array<Byte>(1, item: 0)
    private var len: Int64 = 0

    public init(cipherInputStream: CipherInputStream, bufferSize: Int64) {
        super(cipherInputStream)
        this.inflater = DecompressInputStream(cipherInputStream, bufLen: bufferSize)
        buff = Array<Byte>(bufferSize, item: 0)
    }

    public func read(): Int64 {
        if (read(singleByteBuffer) <= 0) {
            return -1
        }
        return Int64(singleByteBuffer[0])
    }

    public func read(b: Array<Byte>): Int64 {
        return inflater.read(b)
    }

    public func read(b: Array<Byte>, off: Int64, len: Int64): Int64 {
        this.read(b[off..off + len])
    }

    public func endOfEntryReached(inputStream: InputStream, numberOfBytesPushedBack: Int64) {
        //inflater.end()
        super.endOfEntryReached(inputStream, numberOfBytesPushedBack)
    }

    // TODO pushBackInputStreamIfNecessary func

    public func close(): Unit {
        inflater.close()
        super.close()
    }

    private func fill(): Unit {
        len = super.read(buff, 0, buff.size)
        if (len == -1) {
            throw Exception("Unexpected end of input stream")
        }
    }
}
