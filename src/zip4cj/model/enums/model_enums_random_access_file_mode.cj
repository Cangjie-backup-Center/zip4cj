package zip4cj.model.enums

public class RandomAccessFileMode {
    public static let READ: RandomAccessFileMode = RandomAccessFileMode("r")

    public static let WRITE: RandomAccessFileMode = RandomAccessFileMode("rw")

    private var value: String

    init(value: String) {
        this.value = value
    }

    public func getValue(): String {
        return value
    }
}
