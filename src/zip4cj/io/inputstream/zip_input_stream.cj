package zip4cj.io.inputstream

public class ZipInputStream <: InputStream {
    private var inputStream: PushbackInputStream
    private var decompressedInputStream: ?DecompressedInputStream = None
    private var headerReader: HeaderReader = HeaderReader()
    private var password: ?Array<Char>
    private var passwordCallback: ?PasswordCallback
    private var localFileHeader: ?LocalFileHeader = None
    private var crc32: CRC32 = CRC32()
    private var endOfEntryBuffer: Array<Byte> = Array<Byte>()
    private var canSkipExtendedLocalFileHeader: Bool = false
    private var zip4jConfig: Zip4cjConfig
    private var streamClosed: Bool = false
    private var entryEOFReached: Bool = false

    public init(inputStream: InputStream) {
        this(inputStream, Array<Char>(), None)
    }

    public init(inputStream: InputStream, charset: Charset) {
        this(inputStream, Array<Char>(), charset)
    }

    public init(inputStream: InputStream, password: ?Array<Char>) {
        this(inputStream, password, None)
    }

    public init(inputStream: InputStream, passwordCallback: PasswordCallback) {
        this(inputStream, passwordCallback, None)
    }

    public init(inputStream: InputStream, password: ?Array<Char>, charset: ?Charset) {
        this(inputStream, password,
            Zip4cjConfig(charset, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
    }

    public init(inputStream: InputStream, passwordCallback: PasswordCallback, charset: ?Charset) {
        this(inputStream, passwordCallback,
            Zip4cjConfig(charset, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
    }

    public init(inputStream: InputStream, password: ?Array<Char>, zip4cjConfig: Zip4cjConfig) {
        this(inputStream, password, None, zip4cjConfig)
    }

    public init(inputStream: InputStream, passwordCallback: PasswordCallback, zip4jConfig: Zip4cjConfig) {
        this(inputStream, Array<Char>(), passwordCallback, zip4jConfig)
    }

    private init(
        inputStream: InputStream,
        password: ?Array<Char>,
        passwordCallback: ?PasswordCallback,
        zip4jConfig: Zip4cjConfig
    ) {
        if (zip4jConfig.getBufferSize() < InternalZipConstants.MIN_BUFF_SIZE) {
            throw IllegalArgumentException(
                "Buffer size cannot be less than  ${InternalZipConstants.MIN_BUFF_SIZE} bytes")
        }

        this.inputStream = PushbackInputStream(inputStream, Int64(zip4jConfig.getBufferSize()))
        this.password = password
        this.passwordCallback = passwordCallback
        this.zip4jConfig = zip4jConfig
    }

    public func getNextEntry(fileHeader: ?FileHeader, readUntilEndOfCurrentEntryIfOpen: Bool): ?LocalFileHeader {
        if (!localFileHeader.isNone() && readUntilEndOfCurrentEntryIfOpen) {
            readUntilEndOfEntry()
        }

        localFileHeader = headerReader.readLocalFileHeader(inputStream, zip4jConfig.getCharset())

        if (localFileHeader.isNone()) {
            return None
        }

        if (localFileHeader.getOrThrow().isEncrypted() && password.isNone() && passwordCallback.isSome()) {
            setPassword(passwordCallback.getOrThrow().getPassword())
        }

        verifyLocalFileHeader(localFileHeader.getOrThrow())

        if (fileHeader.isSome()) {
            localFileHeader.getOrThrow().setCrc(fileHeader.getOrThrow().getCrc())
            localFileHeader.getOrThrow().setCompressedSize(fileHeader.getOrThrow().getCompressedSize())
            localFileHeader.getOrThrow().setUncompressedSize(fileHeader.getOrThrow().getUncompressedSize())
            // file header's directory flag is more reliable than local file header's directory flag as file header has
            // additional external file attributes which has a directory flag defined. In local file header, the only way
            // to determine if an entry is directory is to check if the file name has a trailing forward slash "/"
            localFileHeader.getOrThrow().setDirectory(fileHeader.getOrThrow().isDirectory())
            canSkipExtendedLocalFileHeader = true
        } else {
            canSkipExtendedLocalFileHeader = false
        }

        this.decompressedInputStream = initializeEntryInputStream(localFileHeader.getOrThrow())
        this.entryEOFReached = false
        return localFileHeader
    }

    public func read(): Int64 {
        var b = Array<Byte>(1, item: 0)
        var readLen: Int64 = read(b)

        if (readLen == -1) {
            return -1
        }

        return Int64(b[0]) & 0xff
    }

    public func read(b: Array<Byte>): Int64 {
        return read(b, 0, b.size)
    }

    public func read(b: Array<Byte>, off: Int64, len: Int64): Int64 {
        if (streamClosed) {
            throw IOException("Stream closed")
        }

        if (len < 0) {
            throw IllegalArgumentException("Negative read length")
        }

        if (len == 0) {
            return 0
        }

        if (localFileHeader.isNone()) {
            // localfileheader can be null when end of compressed data is reached.  If null check is missing, read method will
            // throw a NPE when end of compressed data is reached and read is called again.
            return -1
        }

        try {
            var readLen = decompressedInputStream.getOrThrow().read(b, off, len)
            if (readLen > 0) {
                crc32.update(b[off..off + readLen]) //crc32.update(b, off, readLen)
            }

            return readLen
        } catch (e: IOException) {
            if (isEncryptionMethodZipStandard(localFileHeader.getOrThrow())) {
                throw ZipException(e.message)
            }

            throw e
        }
    }

    public func close(): Unit {
        if (streamClosed) {
            return
        }

        if (decompressedInputStream.isSome()) {
            decompressedInputStream.getOrThrow().close()
        }
        this.streamClosed = true
    }

    public func available(): Int64 {
        assertStreamOpen()
        if (entryEOFReached) {
            return 0
        }
        return 1
    }

    public func setPassword(password: ?Array<Char>): Unit {
        this.password = password
    }

    private func initializeEntryInputStream(localFileHeader: LocalFileHeader): DecompressedInputStream {
        var zipEntryInputStream: ZipEntryInputStream = ZipEntryInputStream(
            inputStream,
            getCompressedSize(localFileHeader)
        )
        var cipherInputStream: CipherInputStream = initializeCipherInputStream(
            zipEntryInputStream,
            localFileHeader
        )
        return initializeDecompressorForThisEntry(cipherInputStream, localFileHeader)
    }

    private func initializeCipherInputStream(
        zipEntryInputStream: ZipEntryInputStream,
        localFileHeader: LocalFileHeader
    ): CipherInputStream {
        if (!localFileHeader.isEncrypted()) {
            return NoCipherInputStream(zipEntryInputStream, localFileHeader, password,
                Int64(zip4jConfig.getBufferSize()))
        }

        if (localFileHeader.getEncryptionMethod() == EncryptionMethod.AES) {
            // TODO AES
            throw ZipException("AES Not Supported")
        } else if (localFileHeader.getEncryptionMethod() == EncryptionMethod.ZIP_STANDARD) {
            return ZipStandardCipherInputStream(zipEntryInputStream, localFileHeader, password,
                Int64(zip4jConfig.getBufferSize()), zip4jConfig.isUseUtf8CharsetForPasswords())
        } else {
            let message: String = "Entry ${localFileHeader.getFileName()} Strong Encryption not supported"
            throw ZipException(message, ZipExceptionType.UNSUPPORTED_ENCRYPTION)
        }
    }

    private func initializeDecompressorForThisEntry(
        cipherInputStream: CipherInputStream,
        localFileHeader: LocalFileHeader
    ): DecompressedInputStream {
        var compressionMethod = localFileHeader.getCompressionMethod().getOrThrow()

        if (compressionMethod == CompressionMethod.DEFLATE) {
            return InflaterInputStream(cipherInputStream, Int64(zip4jConfig.getBufferSize()))
        }

        return StoreInputStream(cipherInputStream)
    }

    private func readExtendedLocalFileHeaderIfPresent(): Unit {
        if (!localFileHeader.getOrThrow().isDataDescriptorExists() || canSkipExtendedLocalFileHeader) {
            return
        }
    }

    private func verifyLocalFileHeader(localFileHeader: LocalFileHeader): Unit {
        if (!isEntryDirectory(localFileHeader.getFileName().getOrThrow()) &&
            localFileHeader.getCompressionMethod().getOrThrow() == CompressionMethod.STORE &&
            localFileHeader.getUncompressedSize() < 0) {
            throw IOException(
                "Invalid local file header for: ${localFileHeader.getFileName().getOrThrow()}. Uncompressed size has to be set for entry of compression type store which is not a directory"
            )
        }
    }

    private func checkIfZip64ExtraDataRecordPresentInLFH(extraDataRecords: ArrayList<ExtraDataRecord>): Bool {
        if (extraDataRecords.isEmpty()) {
            return false
        }

        for (extraDataRecord in extraDataRecords) {
            if (extraDataRecord.getHeader() == HeaderSignature.ZIP64_EXTRA_FIELD_SIGNATURE.getValue()) {
                return true
            }
        }

        return false
    }

    private func verifyCrc(): Unit {
        if (localFileHeader.getOrThrow().getEncryptionMethod() == EncryptionMethod.AES &&
            localFileHeader.getOrThrow().getAesExtraDataRecord().getOrThrow().getAesVersion().getVersionNumber() ==
            AesVersion.TWO.getVersionNumber()) {
            // Verification will be done in this case by AesCipherInputStream
            return
        }

        if (localFileHeader.getOrThrow().getCrc() != Int64(crc32.getFinalCRC())) {
            var exceptionType = ZipExceptionType.CHECKSUM_MISMATCH

            if (isEncryptionMethodZipStandard(localFileHeader.getOrThrow())) {
                exceptionType = ZipExceptionType.WRONG_PASSWORD
            }

            throw ZipException(
                "Reached end of entry, but crc verification failed for " +
                    localFileHeader.getOrThrow().getFileName().getOrThrow(),
                exceptionType
            )
        }
    }

    private func resetFields(): Unit {
        localFileHeader = None
        crc32.reset()
    }

    private func isEntryDirectory(entryName: String): Bool {
        return entryName.endsWith("/") || entryName.endsWith("\\")
    }

    private func getCompressedSize(localFileHeader: LocalFileHeader): Int64 {
        if (Zip4cjUtil.getCompressionMethod(localFileHeader) == (CompressionMethod.STORE)) {
            return localFileHeader.getUncompressedSize()
        }

        if (localFileHeader.isDataDescriptorExists() && !canSkipExtendedLocalFileHeader) {
            return -1
        }

        return localFileHeader.getCompressedSize() - getEncryptionHeaderSize(localFileHeader)
    }

    private func getEncryptionHeaderSize(localFileHeader: LocalFileHeader) {
        if (!localFileHeader.isEncrypted()) {
            return 0
        }

        if (localFileHeader.getEncryptionMethod() == (EncryptionMethod.AES)) {
            return getAesEncryptionHeaderSize(localFileHeader.getAesExtraDataRecord())
        } else if (localFileHeader.getEncryptionMethod() == (EncryptionMethod.ZIP_STANDARD)) {
            return InternalZipConstants.STD_DEC_HDR_SIZE
        } else {
            return 0
        }
    }

    private func readUntilEndOfEntry(): Unit {
        if (endOfEntryBuffer.isEmpty()) {
            endOfEntryBuffer = Array<Byte>(512, item: 0)
        }

        //noinspection StatementWithEmptyBody
        while (read(endOfEntryBuffer) != -1) {
            this.entryEOFReached = true
        }
    }

    private func getAesEncryptionHeaderSize(aesExtraDataRecord: ?AESExtraDataRecord): Int64 {
        if (aesExtraDataRecord.isNone()) {
            throw ZipException("AesExtraDataRecord not found or invalid for Aes encrypted entry")
        }

        return Int64(InternalZipConstants.AES_AUTH_LENGTH + InternalZipConstants.AES_PASSWORD_VERIFIER_LENGTH +
                aesExtraDataRecord.getOrThrow().getAesKeyStrength().getSaltLength())
    }

    private func isEncryptionMethodZipStandard(localFileHeader: LocalFileHeader): Bool {
        return localFileHeader.isEncrypted() && EncryptionMethod.ZIP_STANDARD == localFileHeader.getEncryptionMethod()
    }

    private func assertStreamOpen(): Unit {
        if (streamClosed) {
            throw IOException("Stream closed")
        }
    }
}
