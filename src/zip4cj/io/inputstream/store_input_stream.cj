package zip4cj.io.inputstream

class StoreInputStream <: DecompressedInputStream {
    public init(cipherInputStream: CipherInputStream) {
        super(cipherInputStream)
    }
}
