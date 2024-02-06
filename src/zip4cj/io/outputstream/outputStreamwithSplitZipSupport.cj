package zip4cj.io.outputstream

public interface OutputStreamWithSplitZipSupport {
    func getFilePointer(): Int64

    func getCurrentSplitFileCounter(): Int32
}
