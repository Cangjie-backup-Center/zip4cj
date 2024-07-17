/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights resvered.
 */
package zip4cj.crypto.PBKDF2

public class PBKDF2Engine {
    private var parameters: PBKDF2Parameters

    public PBKDF2Engine(parameters: PBKDF2Parameters) {
        this.parameters = parameters
    }

    public func deriveKey(inputPassword: Array<Rune>, dkLen: Int32, useUtf8ForPassword: Bool): Array<Byte> {
        useUtf8ForPassword
        if (dkLen == 0) {
            return pbkdf2HmacSha1(String(inputPassword).toArray(), parameters.getSalt(), parameters.getIterationCount(),
                20)
        }
        return pbkdf2HmacSha1(String(inputPassword).toArray(), parameters.getSalt(), parameters.getIterationCount(),
            dkLen)
    }
}
