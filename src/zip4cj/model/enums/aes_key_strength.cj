package zip4cj.model.enums

public class AesKeyStrength <: Equal<AesKeyStrength> {
    public static let KEY_STRENGTH_128: AesKeyStrength = AesKeyStrength(1, 8, 16, 16)
    public static let KEY_STRENGTH_192: AesKeyStrength = AesKeyStrength(2, 12, 24, 24)
    public static let KEY_STRENGTH_256: AesKeyStrength = AesKeyStrength(3, 16, 32, 32)
    private var rawCode: Int32
    private var saltLength: Int32
    private var macLength: Int32
    private var keyLength: Int32
    init(rawCode: Int32, saltLength: Int32, macLength: Int32, keyLength: Int32) {
        this.rawCode = rawCode
        this.saltLength = saltLength
        this.macLength = macLength
        this.keyLength = keyLength
    }

    public func getRawCode(): Int32 {
        return rawCode
    }

    public func getSaltLength(): Int32 {
        return saltLength
    }

    public func getMacLength(): Int32 {
        return macLength
    }

    public func getKeyLength(): Int32 {
        return keyLength
    }

    public static func getAesKeyStrengthFromRawCode(code: Int32): ?AesKeyStrength {
        match (code) {
            case 1 => return KEY_STRENGTH_128
            case 2 => return KEY_STRENGTH_192
            case 3 => return KEY_STRENGTH_256
            case _ => return None
        }
    }

    public operator func ==(that: AesKeyStrength): Bool {
        if (that.keyLength == this.keyLength && that.macLength == this.macLength && that.saltLength == this.saltLength &&
            that.rawCode == this.rawCode) {
            return true
        } else {
            return false
        }
    }
}
