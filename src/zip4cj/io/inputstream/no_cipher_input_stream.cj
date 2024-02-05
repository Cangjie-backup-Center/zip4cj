package zip4cj.io.inputstream

class NoDecrypter <: Decrypter {
    public func decryptData(buff: Array<Byte>, start: Int64, len: Int64): Int64 {
        return len
    }

    public func decryptData(buff: Array<Byte>): Int64 {
        return buff.size
    }
}

class NoCipherInputStream <: CipherInputStream {
    var initializeDecrypte = NoDecrypter()
    protected prop decrypter: Decrypter {
        get() {
            initializeDecrypte
        }
    }
    public init(
        zipEntryInputStream: ZipEntryInputStream,
        localFileHeader: LocalFileHeader,
        password: ?Array<Char>,
        bufferSize: Int64
    ) {
        super(zipEntryInputStream, localFileHeader, password, bufferSize, true)
    }
}
