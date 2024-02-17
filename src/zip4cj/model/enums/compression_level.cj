package zip4cj.model.enums

public class CompressionLevel <: Equal<CompressionLevel> {
    public static let NO_COMPRESSION: CompressionLevel = CompressionLevel(0)
    public static let FASTEST: CompressionLevel = CompressionLevel(1)
    public static let FASTER: CompressionLevel = CompressionLevel(2)
    public static let FAST: CompressionLevel = CompressionLevel(3)
    public static let MEDIUM_FAST: CompressionLevel = CompressionLevel(4)
    public static let NORMAL: CompressionLevel = CompressionLevel(5)
    public static let HIGHER: CompressionLevel = CompressionLevel(6)
    public static let MAXIMUM: CompressionLevel = CompressionLevel(7)
    public static let PRE_ULTRA: CompressionLevel = CompressionLevel(8)
    public static let ULTRA: CompressionLevel = CompressionLevel(9)
    private let level: Int32
    init(level: Int32) {
        this.level = level
    }

    public func getLevel(): Int32 {
        return level
    }

    public operator func ==(that: CompressionLevel): Bool {
        if (that.level == this.level) {
            return true
        } else {
            return false
        }
    }
}
