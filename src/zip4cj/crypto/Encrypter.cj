package zip4cj.crypto

public interface Encrypter {
    func encryptData(buff: Array<Byte>): Int64

    func encryptData(buff: Array<Byte>, start: Int64, len: Int64): Int64
}
