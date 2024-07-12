/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights resvered.
 */
package zip4cj.model

public class Zip4cjConfig {
    private let charset: ?Charset

    private let bufferSize: Int64

    private let useUtf8CharsetForPasswords: Bool

    public init(charset: ?Charset, bufferSize: Int64, useUtf8CharsetForPasswords: Bool) {
        this.charset = charset
        this.bufferSize = bufferSize
        this.useUtf8CharsetForPasswords = useUtf8CharsetForPasswords
    }

    public func getCharset(): ?Charset {
        return charset
    }

    public func getBufferSize(): Int64 {
        return bufferSize
    }

    public func isUseUtf8CharsetForPasswords(): Bool {
        return useUtf8CharsetForPasswords
    }
}
