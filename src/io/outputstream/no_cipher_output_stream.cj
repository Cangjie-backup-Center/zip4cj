/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package zip4cj.io.outputstream

class NoEncrypter <: Encrypter {
    public func encryptData(buff: Array<Byte>): Int64 {
        return encryptData(buff, 0, buff.size)
    }
    func encryptData(buff: Array<Byte>, start: Int64, len: Int64): Int64 {
        (buff, start)
        return len
    }
}

class NoCipherOutputStream <: CipherOutputStream {
    var initializeEncrypte = NoEncrypter()
    protected prop encrypter: Encrypter {
        get() {
            initializeEncrypte
        }
    }

    public init(zipEntryOutputStream: ZipEntryOutputStream, zipParameters: ZipParameters, password: ?Array<Rune>) {
        super(zipEntryOutputStream, zipParameters, password, true)
    }
}
