/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights resvered.
 */
package zip4cj.io.inputstream

class StoreInputStream <: DecompressedInputStream {
    public init(cipherInputStream: CipherInputStream) {
        super(cipherInputStream)
    }
}
