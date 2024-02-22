package zip4cj.model.enums

public enum RandomAccessFileMode {
    | READ
    | WRITE

    public func getValue(): String {
        return match(this) {
            case READ => "r"
            case WRITE => "rw"
        }
    }
}
