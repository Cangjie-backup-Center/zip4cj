package zip4cj.io.outputstream

class ZipStandardCipherOutputStream <: CipherOutputStream {
    private var pendingBuffer: Array<UInt8> = Array<UInt8>(16, item: 0)

    private var pendingBufferLength: Int32 = 0

    private var myencrypter: ?StandardEncrypter = None

    protected prop encrypter: Encrypter {
        get() {
            if (let Some(v) <- myencrypter) {
                v
            } else {
                let value = initializeEncrypter(this.outputStream, this.zipParameters, this.password,
                    this.useUtf8ForPassword)
                this.myencrypter = value
                value
            }
        }
    }

    public init(
        outputStream: ZipEntryOutputStream,
        zipParameters: ZipParameters,
        password: ?Array<Char>,
        useUtf8ForPassword: Bool
    ) {
        super(outputStream, zipParameters, password, useUtf8ForPassword)
    }

    protected func initializeEncrypter(
        outputStream: ZipEntryOutputStream,
        zipParameters: ZipParameters,
        password: ?Array<Char>,
        useUtf8ForPassword: Bool
    ): StandardEncrypter {
        var key: Int64 = if (zipParameters.isWriteExtendedLocalFileHeader()) {
            let dosTime = Zip4cjUtil.epochToExtendedDosTime(zipParameters.getLastModifiedFileTime());
            (dosTime & 0x0000ffff) << 16;
        } else {
            zipParameters.getEntryCRC();
        }
        // getEncryptionKey(zipParameters)
        var encrypter: StandardEncrypter = StandardEncrypter(password, key, useUtf8ForPassword)
        writeHeaders(encrypter.getHeaderBytes())
        return encrypter
    }

    @OverflowThrowing
    public func write(b: Int32): Unit {
        var src: Array<UInt8> = Array<UInt8>(1, item: 0)
        src.set(0, UInt8(b))
        write(src)
    }

    public func write(b: Array<UInt8>): Unit {
        super.write(b, 0, b.size)
    }

    public func write(b: Array<UInt8>, off: Int64, len: Int64): Unit {
        this.write(b, off, len);
    }

    public func getEncryptionKey(): Int64 {
        if (zipParameters.isWriteExtendedLocalFileHeader()) {
            var dosTime: Int64 = Zip4cjUtil.epochToExtendedDosTime(zipParameters.getLastModifiedFileTime())
            return (dosTime & 0x0000ffff) << 16
        }
        return zipParameters.getEntryCRC()
    }
}
