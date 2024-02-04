package zip4cj.model.enums

public class AesVersion <: Equal<AesVersion> {
    public static let ONE: AesVersion = AesVersion(1)
    public static let TWO: AesVersion = AesVersion(2)
    private var versionNumber: Int32
    init(versionNumber: Int32) {
        this.versionNumber = versionNumber
    }

    public func getVersionNumber(): Int32 {
        return versionNumber
    }

    public static func getFromVersionNumber(versionNumber: Int32): AesVersion {
        match (versionNumber) {
            case 1 => return ONE
            case 2 => return TWO
            case _ => throw ZipException("Unsupported Aes version")
        }
    }

    public operator func ==(that: AesVersion): Bool {
        if (refEq(this, that)) {
            return true
        }
        if (this.versionNumber == that.versionNumber) {
            return true
        }
        return false
    }
}
