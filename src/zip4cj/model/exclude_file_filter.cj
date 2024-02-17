package zip4cj.model

public interface ExcludeFileFilter {
    func isExcluded(file: Path): Bool
}
