package zip4cj.io.outputstream

func initializeZipModel(zipModel: ZipModel, countingOutputStream: CountingOutputStream): ZipModel {
    if (countingOutputStream.isSplitZipFile()) {
        zipModel.setSplitArchive(true)
        zipModel.setSplitLength(countingOutputStream.getSplitLength())
    }

    return zipModel
}

public class ZipOutputStream <: OutputStream & Resource {
    private var countingOutputStream: CountingOutputStream
    private var password: ?Array<Char>
    private var zipModel: ZipModel
    private var compressedOutputStream: CompressedOutputStream = unsafe { zeroValue<CompressedOutputStream>() }
    private var fileHeader: ?FileHeader = None
    private var localFileHeader: ?LocalFileHeader = None
    private var fileHeaderFactory: FileHeaderFactory = FileHeaderFactory()
    private var headerWriter: HeaderWriter = HeaderWriter()
    private var crc32: CRC32 = CRC32()
    private var rawIO: RawIO = RawIO()
    private var uncompressedSizeForThisEntry: Int64 = 0
    private var zip4cjConfig: Zip4cjConfig
    private var streamClosed: Bool
    private var entryClosed: Bool = true

    public init(outputStream: OutputStream) {
        this(outputStream, Array<Char>(), Option<Charset>.None)
    }

    public init(outputStream: OutputStream, charset: Option<Charset>) {
        this(outputStream, Array<Char>(), charset)
    }

    public init(outputStream: OutputStream, password: ?Array<Char>) {
        this(outputStream, password, Option<Charset>.None)
    }

    public init(outputStream: OutputStream, password: ?Array<Char>, charset: Option<Charset>) {
        this(outputStream, password,
            Zip4cjConfig(charset, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING), ZipModel())
    }

    public init(outputStream: OutputStream, password: ?Array<Char>, zip4cjConfig: Zip4cjConfig, zipModel: ZipModel) {
        if (zip4cjConfig.getBufferSize() < InternalZipConstants.MIN_BUFF_SIZE) {
            throw IllegalArgumentException(
                "Buffer size cannot be less than ${InternalZipConstants.MIN_BUFF_SIZE} bytes")
        }
        this.countingOutputStream = CountingOutputStream(outputStream)
        this.password = password
        this.zip4cjConfig = zip4cjConfig
        this.zipModel = initializeZipModel(zipModel, countingOutputStream)
        this.streamClosed = false
        if (countingOutputStream.isSplitZipFile()) {
            rawIO.writeIntLittleEndian(countingOutputStream, Int32(HeaderSignature.SPLIT_ZIP.getValue()))
        }
    }

    public func putNextEntry(zipParameters: ZipParameters): Unit {
        verifyZipParameters(zipParameters)
        var clonedZipParameters: ZipParameters = cloneAndPrepareZipParameters(zipParameters)
        initializeAndWriteFileHeader(clonedZipParameters)

        compressedOutputStream = initializeCompressedOutputStream(clonedZipParameters)
        this.entryClosed = false
    }

    public func write(b: Array<UInt8>): Unit {
        ensureStreamOpen()
        crc32.update(b)
        compressedOutputStream.write(b)
        uncompressedSizeForThisEntry += b.size
    }

    @OverflowThrowing
    public func write(bval: Int32): Unit {
        this.write([UInt8(bval)])
    }

    public func write(b: Array<UInt8>, off: Int64, len: Int64): Unit {
        ensureStreamOpen()
        crc32.update(b[off..off + len])
        this.compressedOutputStream.write(b[off..off + len])
        uncompressedSizeForThisEntry += len
    }

    public func closeEntry(): FileHeader {
        compressedOutputStream.closeEntry()

        var compressedSize: Int64 = compressedOutputStream.getCompressedSize()
        fileHeader.getOrThrow().setCompressedSize(compressedSize)
        localFileHeader.getOrThrow().setCompressedSize(compressedSize)

        fileHeader.getOrThrow().setUncompressedSize(uncompressedSizeForThisEntry)
        localFileHeader.getOrThrow().setUncompressedSize(uncompressedSizeForThisEntry)
        if (writeCrc(fileHeader.getOrThrow())) {
            fileHeader.getOrThrow().setCrc(crc32.getValue())
            localFileHeader.getOrThrow().setCrc(crc32.getValue())
        }
        zipModel.getLocalFileHeaders().append(localFileHeader.getOrThrow())
        zipModel.getCentralDirectory().getOrThrow().getFileHeaders().append(fileHeader.getOrThrow())

        if (localFileHeader.getOrThrow().isDataDescriptorExists()) {
            headerWriter.writeExtendedLocalHeader(localFileHeader, countingOutputStream)
        }
        reset()
        this.entryClosed = true
        return fileHeader.getOrThrow()
    }

    public func close(): Unit {
        if (!this.entryClosed) {
            closeEntry()
        }
        zipModel.getEndOfCentralDirectoryRecord().setOffsetOfStartOfCentralDirectory(
            countingOutputStream.getNumberOfBytesWritten())
        headerWriter.finalizeZipFile(zipModel, countingOutputStream, this.zip4cjConfig.getCharset())
        countingOutputStream.close()
        this.streamClosed = true
    }


    public func ensureStreamOpen(): Unit {
        if (streamClosed) {
            throw Exception("Stream is closed")
        }
    }

    public func initializeAndWriteFileHeader(zipParameters: ZipParameters): Unit {
        fileHeader = fileHeaderFactory.generateFileHeader(zipParameters, countingOutputStream.isSplitZipFile(),
            Int64(countingOutputStream.getCurrentSplitFileCounter()), zip4cjConfig.getCharset(), rawIO)
        fileHeader.getOrThrow().setOffsetLocalHeader(countingOutputStream.getOffsetForNextEntry())

        localFileHeader = fileHeaderFactory.generateLocalFileHeader(fileHeader.getOrThrow())
        headerWriter.writeLocalFileHeader(zipModel, localFileHeader.getOrThrow(), countingOutputStream,
            zip4cjConfig.getCharset())
    }

    public func reset(): Unit {
        uncompressedSizeForThisEntry = 0
        crc32.reset()
        compressedOutputStream.close()
    }

    public func initializeCompressedOutputStream(zipParameters: ZipParameters): CompressedOutputStream {
        var zipEntryOutputStream: ZipEntryOutputStream = ZipEntryOutputStream(this.countingOutputStream)
        var cipherOutputStream: CipherOutputStream = initializeCipherOutputStream(zipEntryOutputStream, zipParameters)
        return initializeCompressedOutputStream(cipherOutputStream, zipParameters)
    }

    public func initializeCipherOutputStream(zipEntryOutputStream: ZipEntryOutputStream, zipParameters: ZipParameters): CipherOutputStream {
        if (!zipParameters.isEncryptFiles()) {
            return NoCipherOutputStream(zipEntryOutputStream, zipParameters, Array<Char>())
        }
        if (password.isNone() || password.getOrThrow().size == 0) {
            throw ZipException("password not set")
        }
        if (zipParameters.getEncryptionMethod() == EncryptionMethod.AES) {
            // return AesCipherOutputStream(zipEntryOutputStream, zipParameters, password, Zip4cjConfig.isUseUtf8CharsetForPasswords())
            throw Exception(" not supported")
        } else if (zipParameters.getEncryptionMethod() == EncryptionMethod.ZIP_STANDARD) {
            return ZipStandardCipherOutputStream(zipEntryOutputStream, zipParameters, password.getOrThrow(),
                zip4cjConfig.isUseUtf8CharsetForPasswords())
        } else if (zipParameters.getEncryptionMethod() == EncryptionMethod.ZIP_STANDARD_VARIANT_STRONG) {
            // throw ZipException("${EncryptionMethod.ZIP_STANDARD_VARIANT_STRONG} encryption method is not supported")
            throw ZipException("encryption method is not supported")
        } else {
            throw ZipException("Invalid encryption method")
        }
    }

    public func initializeCompressedOutputStream(cipherOutputStream: CipherOutputStream, zipParameters: ZipParameters): CompressedOutputStream {
        if (zipParameters.getCompressionMethod() == CompressionMethod.DEFLATE) {
            return DeflaterOutputStream(cipherOutputStream, zipParameters.getCompressionLevel(),
                zip4cjConfig.getBufferSize())
        }
        return StoreOutputStream(cipherOutputStream)
    }

    public func verifyZipParameters(zipParameters: ZipParameters): Unit {
        if (Zip4cjUtil.isStringNullOrEmpty(zipParameters.getFileNameInZip())) {
            throw IllegalArgumentException("fileNameInZip is null or empty")
        }

        if (zipParameters.getCompressionMethod() == CompressionMethod.STORE && zipParameters.getEntrySize() < 0 &&
            !FileUtils.isZipEntryDirectory(zipParameters.getFileNameInZip().getOrThrow()) &&
            zipParameters.isWriteExtendedLocalFileHeader()) {
            throw IllegalArgumentException("uncompressed size should be set for zip entries of compression type store")
        }
    }

    public func writeCrc(fileHeader: FileHeader): Bool {
        var isAesEncrypted: Bool = fileHeader.isEncrypted() && fileHeader.getEncryptionMethod() == (EncryptionMethod.AES)
        if (!isAesEncrypted) {
            return true
        }
        return fileHeader.getAesExtraDataRecord().getOrThrow().getAesVersion() == (AesVersion.ONE)
    }

    public func cloneAndPrepareZipParameters(zipParameters: ZipParameters): ZipParameters {
        var clonedZipParameters: ZipParameters = ZipParameters(zipParameters)

        if (FileUtils.isZipEntryDirectory(zipParameters.getFileNameInZip().getOrThrow())) {
            clonedZipParameters.setWriteExtendedLocalFileHeader(false)
            clonedZipParameters.setCompressionMethod(CompressionMethod.STORE)
            clonedZipParameters.setEncryptFiles(false)
            clonedZipParameters.setEntrySize(0)
        }

        if (zipParameters.getLastModifiedFileTime() <= 0) {
            clonedZipParameters.setLastModifiedFileTime(DateTime.now().toUnixTimeStamp().toMilliseconds())
        }

        return clonedZipParameters
    }

    public func isClosed(): Bool {
        streamClosed
    }

}
