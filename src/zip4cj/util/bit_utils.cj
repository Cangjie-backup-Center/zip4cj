package zip4cj.util

public class BitUtils {
    public static func isBitSet(b: Byte, pos: Int64): Bool {
        return (b & (1 << pos)) != 0
    }

    public static func setBit(b: Byte, pos: Int64): Byte {
        return (b | (1 << pos))
    }

    public static func unsetBit(b: Byte, pos: Int64): Byte {
        return (b & !(1 << pos))
    }
}
