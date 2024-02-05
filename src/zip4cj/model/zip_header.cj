package zip4cj.model

public abstract class ZipHeader {
    private var signature: ?HeaderSignature = None

    public func getSignature(): ?HeaderSignature {
        return signature
    }

    public func setSignature(signature: HeaderSignature): Unit {
        this.signature = signature
    }
}
