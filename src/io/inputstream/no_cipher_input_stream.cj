/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package zip4cj.io.inputstream

class NoDecrypter <: Decrypter {
    public override func decryptData(buff: Array<Byte>): Int64 {
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
        password: ?Array<Rune>,
        bufferSize: Int64
    ) {
        super(zipEntryInputStream, localFileHeader, password, bufferSize, true)
    }
}
