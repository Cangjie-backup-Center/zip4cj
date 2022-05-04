package zip4cj
/*
 * Create a custom type called ZipParams,
 *
 *
 * @author      lizhenjie
 */
public record ZipParams {
    public var level: UInt32 = LEVEL_DEFAULT_COMPRESSION
    public init() {}
    public init(level: UInt32) {
        this.level = level
    }
}
