package zip4cj.io.outputstream

public class CountingOutputStream <: OutputStream & OutputStreamWithSplitZipSupport {
    private var outputStream: OutputStream

    private var numberOfBytesWritten: Int64 = 0

    public init(outputStream: OutputStream) {
        this.outputStream = outputStream
    }

    @OverflowWrapping
    public func write(b: Int32): Unit {
        this.write([UInt8(b)])
    }

    public func write(b: Array<UInt8>): Unit {
        this.outputStream.write(b)
        numberOfBytesWritten += b.size
    }

    public func write(b: Array<UInt8>, off: Int64, len: Int64): Unit {
        this.write(b[off..off + len])
    }

    public func getCurrentSplitFileCounter(): Int32 {
        if (isSplitZipFile()) {
            return (outputStream as SplitOutputStream).getOrThrow().getCurrentSplitFileCounter()
        }
        return 0
    }

    public func getOffsetForNextEntry(): Int64 {
        if (outputStream is SplitOutputStream) {
            return (outputStream as SplitOutputStream).getOrThrow().getFilePointer()
        }

        return numberOfBytesWritten
    }

    public func getSplitLength(): Int64 {
        if (isSplitZipFile()) {
            return (outputStream as SplitOutputStream).getOrThrow().getSplitLength()
        }

        return 0
    }

    public func isSplitZipFile(): Bool {
        if (let Some(output) <- outputStream as SplitOutputStream) {
            output.isSplitZipFile()
        } else {
            false
        }
    }

    public func getNumberOfBytesWritten(): Int64 {
        if (outputStream is SplitOutputStream) {
            return (outputStream as SplitOutputStream).getOrThrow().getFilePointer()
        }

        return numberOfBytesWritten
    }

    public func checkBuffSizeAndStartNextSplitFile(bufferSize: Int32): Bool {
        if (!isSplitZipFile()) {
            return false
        }
        return (outputStream as SplitOutputStream).getOrThrow().checkBufferSizeAndStartNextSplitFile(Int64(bufferSize))
    }

    public func getFilePointer(): Int64 {
        if (outputStream is SplitOutputStream) {
            return (outputStream as SplitOutputStream).getOrThrow().getFilePointer()
        }

        return numberOfBytesWritten
    }

    public func close(): Unit {
        match ((outputStream as Resource)) {
            case Some(v) => v.close()
            case None => ()
        }
    }

    public func flush(): Unit {
        return
    }
}
