package zip4cj.io.outputstream

public class SplitOutputStream <: OutputStream & OutputStreamWithSplitZipSupport & Resource {
    private var raf: RandomAccessFile
    private var splitLength: Int64
    private var zipFile: Path
    private var currSplitFileCounter: Int32
    private var bytesWrittenForThisPart: Int64
    private var rawIO = RawIO()
    private var isClose = false

    public init(file: Path) {
        this(file, -1)
    }

    public init(file: Path, splitLength: Int64) {
        if (splitLength >= 0 && splitLength < InternalZipConstants.MIN_SPLIT_LENGTH) {
            throw ZipException(
                "split length less than minimum allowed split length of ${InternalZipConstants.MIN_SPLIT_LENGTH} Bytes")
        }
        this.raf = if (File.exists(file)) {
            RandomAccessFile(file, OpenOption.Open(true, true))
        } else {
            RandomAccessFile(file, OpenOption.CreateOrTruncate(true))
        }
        this.splitLength = splitLength
        this.zipFile = file
        this.currSplitFileCounter = 0
        this.bytesWrittenForThisPart = 0
    }

    public func write(b: Array<Byte>) {
        let len = b.size
        if (len <= 0) {
            return
        }
        if (splitLength == -1) {
            raf.write(b)
            bytesWrittenForThisPart += len
            return
        }
        if (bytesWrittenForThisPart >= splitLength) {
            startNextSplitFile()
            raf.write(b)
            bytesWrittenForThisPart = len
        } else if (bytesWrittenForThisPart + len > splitLength) {
            if (isHeaderData(b)) {
                startNextSplitFile()
                raf.write(b)
                bytesWrittenForThisPart = len
            } else {
                raf.write(b[0..splitLength - bytesWrittenForThisPart])
                startNextSplitFile()
                raf.write(b[splitLength - bytesWrittenForThisPart..len])
                bytesWrittenForThisPart = len - (splitLength - bytesWrittenForThisPart)
            }
        } else {
            raf.write(b)
            bytesWrittenForThisPart += len
        }
    }

    private func startNextSplitFile() {
        var zipFileWithoutExt = zipFile.fileNameWithoutExtension.getOrThrow()
        var zipFileName = zipFile.toCanonical()
        var parentPath = match (zipFileName.directoryName) {
            case Some(v) => v.toString()
            case None => ""
        }
        var fileExtension =  if (currSplitFileCounter >= 9) {
            ".z${currSplitFileCounter + 1}"
        } else {
            ".z0${currSplitFileCounter + 1}"
        }

        var currSplitFile = Path(parentPath).join(zipFileWithoutExt + fileExtension)
        raf.flush()
        raf.close()

        if (File.exists(currSplitFile)) {
            throw ZipException(
                "split file: ${currSplitFile} already exists in the current directory, cannot rename this file")
        }

        if (File.exists(currSplitFile)) {
            throw ZipException("cannot rename newly created split file")
        }
        File.move(zipFileName, currSplitFile, true)
        raf = RandomAccessFile(zipFile, OpenOption.Create(true))
        currSplitFileCounter++
    }

    private func isHeaderData(buff: Array<Byte>): Bool {
        var signature = Int64(rawIO.readIntLittleEndian(buff))
        for (headerSignature in HeaderSignature.values()) {
            //Ignore split signature
            if (headerSignature != HeaderSignature.SPLIT_ZIP && headerSignature.getValue() == signature) {
                return true
            }
        }
        return false
    }

    /**
     * Checks if the buffer size is sufficient for the current split file. If not
     * a new split file will be started.
     *
     * @param bufferSize
     * @return true if a new split file was started else false
     * @throws ZipException
     */
    public func checkBufferSizeAndStartNextSplitFile(bufferSize: Int64): Bool {
        if (bufferSize < 0) {
            throw ZipException("negative buffersize for checkBufferSizeAndStartNextSplitFile")
        }

        if (!isBufferSizeFitForCurrSplitFile(bufferSize)) {
            try {
                startNextSplitFile()
                bytesWrittenForThisPart = 0
                return true
            } catch (e: Exception) {
                throw ZipException(e.message)
            }
        }

        return false
    }

    /**
     * Checks if the given buffer size will be fit in the current split file.
     * If this output stream is a non-split file, then this method always returns true
     *
     * @param bufferSize
     * @return true if the buffer size is fit in the current split file or else false.
     */
    private func isBufferSizeFitForCurrSplitFile(bufferSize: Int64): Bool {
        if (splitLength >= InternalZipConstants.MIN_SPLIT_LENGTH) {
            return (bytesWrittenForThisPart + bufferSize <= splitLength)
        } else {
            //Non split zip -- return true
            return true
        }
    }

    public func seek(pos: Int64): Unit {
        raf.seek(pos)
    }

    public func skipBytes(n: Int64): Int64 {
        var temp = Array<Byte>(1, item: 0)
        for (i in 0..n) {
            let read = raf.read(temp)
            if (read <= 0) {
                return i
            }
        }
        return n
    }

    public func isClosed() {
        return this.isClose
    }

    public func close() {
        try {
            raf.close()
        } finally {
            this.isClose = true
        }
    }

    public func getFilePointer(): Int64 {
        return raf.getFilePointer()
    }

    public func isSplitZipFile(): Bool {
        return splitLength != -1
    }

    public func getSplitLength(): Int64 {
        return splitLength
    }

    public func getCurrentSplitFileCounter(): Int32 {
        return currSplitFileCounter
    }
}
