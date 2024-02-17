package zip4cj.io.outputstream

public class ZipEntryOutputStream <: OutputStream {
    private var numberOfBytesWrittenForThisEntry: Int64 = 0
    var outputStream: OutputStream
    var entryClosed: Bool

    public init(outputStream: OutputStream) {
        this.outputStream = outputStream
        entryClosed = false
    }

    @OverflowThrowing
    public func write(b: Int32): Unit {
        this.write([UInt8(b)])
    }

    public func write(b: Array<UInt8>): Unit {
        if (entryClosed) {
            throw Exception("ZipEntryOutputStream is closed")
        }
        this.outputStream.write(b)
        numberOfBytesWrittenForThisEntry += b.size
    }

    public func write(b: Array<UInt8>, off: Int64, len: Int64): Unit {
        this.write(b[off..off + len])
        numberOfBytesWrittenForThisEntry += Int64(len)
    }

    public func closeEntry(): Unit {
        entryClosed = true
    }

    public func getNumberOfBytesWrittenForThisEntry(): Int64 {
        return numberOfBytesWrittenForThisEntry
    }

    public func flush(): Unit {}
}

extend ZipEntryOutputStream <: Resource {
    public func isClosed(): Bool {
        entryClosed
    }

    public func close(): Unit {
        // Do nothing
        // Do not close the outputstream yet. This will be closed by countingOutputStream
    }
}
