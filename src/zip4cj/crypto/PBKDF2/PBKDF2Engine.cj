package zip4cj.crypto.PBKDF2

public class PBKDF2Engine {
    private var parameters: PBKDF2Parameters

    public PBKDF2Engine(parameters: PBKDF2Parameters) {
        this.parameters = parameters
    }

    public func deriveKey(inputPassword: Array<Char>, dkLen: Int32, useUtf8ForPassword: Bool): Array<Byte> {
        // var p = Zip4cjUtil.convertCharArrayToByteArray(inputPassword, useUtf8ForPassword)
        if (dkLen == 0) {
            return pbkdf2HmacSha1(String(inputPassword).toArray(), parameters.getSalt(), parameters.getIterationCount(),
                20)
        }
        return pbkdf2HmacSha1(String(inputPassword).toArray(), parameters.getSalt(), parameters.getIterationCount(),
            dkLen)
    }
}
