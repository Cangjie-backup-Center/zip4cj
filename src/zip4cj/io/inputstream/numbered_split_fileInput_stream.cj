package zip4cj.io.inputstream

public class NumberedSplitFileInputStream <: SplitFileInputStream {
    private var randomAccessFile: RandomAccessFile

    public init(zipFile: Path) {
        this.randomAccessFile = NumberedSplitRandomAccessFile(zipFile, RandomAccessFileMode.READ.getValue())
    }

    public func read(): Int64 {
        return randomAccessFile.read()
    }

    public func read(b: Array<Byte>): Int64 {
        return this.read(b, 0, b.size)
    }

    public func read(b: Array<Byte>, off: Int64, len: Int64): Int64 {
        return randomAccessFile.read(b, off, len)
    }

    public func prepareExtractionForFileHeader(fileHeader: FileHeader): Unit {
        randomAccessFile.seek(fileHeader.getOffsetLocalHeader())
    }

    public func close(): Unit {
        randomAccessFile.close()
    }
}
