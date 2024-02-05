package zip4cj.headers

public class FileHeaderFactory {
    public func generateFileHeader(
        zipParameters: ZipParameters,
        isSplitZip: Bool,
        currentDiskNumberStart: Int64,
        charset: ?Charset,
        rawIO: RawIO
    ): FileHeader {
        let fileHeader = FileHeader()
        fileHeader.setSignature(HeaderSignature.CENTRAL_DIRECTORY)
        fileHeader.setVersionMadeBy(ZipVersionUtils.determineVersionMadeBy(zipParameters, rawIO))
        fileHeader.setVersionNeededToExtract(ZipVersionUtils.determineVersionNeededToExtract(zipParameters).getCode())

        if (zipParameters.isEncryptFiles() && zipParameters.getEncryptionMethod() == EncryptionMethod.AES) {
            fileHeader.setCompressionMethod(CompressionMethod.AES_INTERNAL_ONLY)
            fileHeader.setAesExtraDataRecord(generateAESExtraDataRecord(zipParameters))
            fileHeader.setExtraFieldLength(
                fileHeader.getExtraFieldLength() + InternalZipConstants.AES_EXTRA_DATA_RECORD_SIZE)
        } else {
            fileHeader.setCompressionMethod(zipParameters.getCompressionMethod())
        }

        if (zipParameters.isEncryptFiles()) {
            if (zipParameters.getEncryptionMethod() == EncryptionMethod.NONE) {
                throw ZipException("Encryption method has to be set when encryptFiles flag is set in zip parameters")
            }

            fileHeader.setEncrypted(true)
            fileHeader.setEncryptionMethod(zipParameters.getEncryptionMethod())
        }

        var fileName = validateAndGetFileName(zipParameters.getFileNameInZip().getOrThrow())
        fileHeader.setFileName(fileName)
        fileHeader.setFileNameLength(determineFileNameLength(fileName, charset))
        fileHeader.setDiskNumberStart(if (isSplitZip) {
            currentDiskNumberStart
        } else {
            0
        })
        fileHeader.setLastModifiedTime(Zip4cjUtil.epochToExtendedDosTime(zipParameters.getLastModifiedFileTime()))

        var isDirectory = FileUtils.isZipEntryDirectory(fileName)
        fileHeader.setDirectory(isDirectory)
        fileHeader.setExternalFileAttributes(FileUtils.getDefaultFileAttributes(isDirectory))

        if (zipParameters.isWriteExtendedLocalFileHeader() && zipParameters.getEntrySize() == -1) {
            fileHeader.setUncompressedSize(0)
        } else {
            fileHeader.setUncompressedSize(zipParameters.getEntrySize())
        }

        if (zipParameters.isEncryptFiles() && zipParameters.getEncryptionMethod() == EncryptionMethod.ZIP_STANDARD) {
            fileHeader.setCrc(zipParameters.getEntryCRC())
        }

        fileHeader.setGeneralPurposeFlag(determineGeneralPurposeBitFlag(fileHeader.isEncrypted(), zipParameters, charset
        ))
        fileHeader.setDataDescriptorExists(zipParameters.isWriteExtendedLocalFileHeader())
        fileHeader.setFileComment(zipParameters.getFileComment())
        return fileHeader
    }

    public func generateLocalFileHeader(fileHeader: FileHeader): LocalFileHeader {
        let localFileHeader = LocalFileHeader()
        localFileHeader.setSignature(HeaderSignature.LOCAL_FILE_HEADER)
        localFileHeader.setVersionNeededToExtract(fileHeader.getVersionNeededToExtract())
        localFileHeader.setCompressionMethod(fileHeader.getCompressionMethod())
        localFileHeader.setLastModifiedTime(fileHeader.getLastModifiedTime())
        localFileHeader.setUncompressedSize(fileHeader.getUncompressedSize())
        localFileHeader.setFileNameLength(fileHeader.getFileNameLength())
        localFileHeader.setFileName(fileHeader.getFileName())
        localFileHeader.setEncrypted(fileHeader.isEncrypted())
        localFileHeader.setEncryptionMethod(fileHeader.getEncryptionMethod())
        localFileHeader.setAesExtraDataRecord(fileHeader.getAesExtraDataRecord())
        localFileHeader.setCrc(fileHeader.getCrc())
        localFileHeader.setCompressedSize(fileHeader.getCompressedSize())
        localFileHeader.setGeneralPurposeFlag(fileHeader.getGeneralPurposeFlag()?.clone())
        localFileHeader.setDataDescriptorExists(fileHeader.isDataDescriptorExists())
        localFileHeader.setExtraFieldLength(fileHeader.getExtraFieldLength())
        return localFileHeader
    }

    private func determineGeneralPurposeBitFlag(isEncrypted: Bool, zipParameters: ZipParameters, charset: ?Charset): Array<Byte> {
        var generalPurposeBitFlag = Array<Byte>(2, item: 0)
        generalPurposeBitFlag[0] = generateFirstGeneralPurposeByte(isEncrypted, zipParameters)
        if (charset == None || InternalZipConstants.CHARSET_UTF_8 == (charset.getOrThrow())) {
            // set 3rd bit which corresponds to utf-8 file name charset
            generalPurposeBitFlag[1] = BitUtils.setBit(generalPurposeBitFlag[1], 3)
        }
        return generalPurposeBitFlag
    }

    private func generateFirstGeneralPurposeByte(isEncrypted: Bool, zipParameters: ZipParameters): Byte {
        var firstByte: Byte = 0

        if (isEncrypted) {
            firstByte = BitUtils.setBit(firstByte, 0)
        }

        if (CompressionMethod.DEFLATE == (zipParameters.getCompressionMethod())) {
            if (CompressionLevel.NORMAL == (zipParameters.getCompressionLevel())) {
                firstByte = BitUtils.unsetBit(firstByte, 1)
                firstByte = BitUtils.unsetBit(firstByte, 2)
            } else if (CompressionLevel.MAXIMUM == (zipParameters.getCompressionLevel())) {
                firstByte = BitUtils.setBit(firstByte, 1)
                firstByte = BitUtils.unsetBit(firstByte, 2)
            } else if (CompressionLevel.FAST == (zipParameters.getCompressionLevel())) {
                firstByte = BitUtils.unsetBit(firstByte, 1)
                firstByte = BitUtils.setBit(firstByte, 2)
            } else if (CompressionLevel.FASTEST == (zipParameters.getCompressionLevel()) || CompressionLevel.ULTRA == (zipParameters.
                getCompressionLevel())) {
                firstByte = BitUtils.setBit(firstByte, 1)
                firstByte = BitUtils.setBit(firstByte, 2)
            }
        }

        if (zipParameters.isWriteExtendedLocalFileHeader()) {
            firstByte = BitUtils.setBit(firstByte, 3)
        }

        return firstByte
    }

    private func validateAndGetFileName(fileNameInZip: String): String {
        if (!Zip4cjUtil.isStringNotNullAndNotEmpty(fileNameInZip)) {
            throw ZipException("fileNameInZip is null or empty")
        }
        return fileNameInZip
    }

    private func generateAESExtraDataRecord(parameters: ZipParameters): AESExtraDataRecord {
        var aesExtraDataRecord = AESExtraDataRecord()

        aesExtraDataRecord.setAesVersion(parameters.getAesVersion())

        if (parameters.getAesKeyStrength() == AesKeyStrength.KEY_STRENGTH_128) {
            aesExtraDataRecord.setAesKeyStrength(AesKeyStrength.KEY_STRENGTH_128)
        } else if (parameters.getAesKeyStrength() == AesKeyStrength.KEY_STRENGTH_192) {
            aesExtraDataRecord.setAesKeyStrength(AesKeyStrength.KEY_STRENGTH_192)
        } else if (parameters.getAesKeyStrength() == AesKeyStrength.KEY_STRENGTH_256) {
            aesExtraDataRecord.setAesKeyStrength(AesKeyStrength.KEY_STRENGTH_256)
        } else {
            throw ZipException("invalid AES key strength")
        }

        aesExtraDataRecord.setCompressionMethod(parameters.getCompressionMethod())
        return aesExtraDataRecord
    }

    private func determineFileNameLength(fileName: String, charset: ?Charset): Int64 {
        return HeaderUtil.getBytesFromString(fileName, charset).size
    }
}
