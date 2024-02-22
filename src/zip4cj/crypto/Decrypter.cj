package zip4cj.crypto

public interface Decrypter {
    func decryptData(buff: Array<Byte>): Int64
}
