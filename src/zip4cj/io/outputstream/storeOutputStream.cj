package zip4cj.io.outputstream

class StoreOutputStream <: CompressedOutputStream {
    public init(cipherOutputStream: CipherOutputStream) {
        super(cipherOutputStream)
    }
}
