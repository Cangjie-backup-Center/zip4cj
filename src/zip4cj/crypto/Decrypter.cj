package zip4cj.crypto

public interface Decrypter {
    func decryptData(buff: Array<Byte>, start: Int64, len: Int64): Int64
}
