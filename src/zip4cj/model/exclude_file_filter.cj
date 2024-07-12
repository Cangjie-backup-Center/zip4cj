/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights resvered.
 */
package zip4cj.model

public interface ExcludeFileFilter {
    func isExcluded(file: Path): Bool
}
