/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

/**
 * @file
 *
 * This is a custom type created with the name zipparams.
 */

package zip4cj

/*
 * Create a custom type called ZipParams
 *
 * @since 0.28.4    @author lizhenjie
 */
public record ZipParams {
    public var level: UInt32 = LEVEL_DEFAULT_COMPRESSION
    public init() {}
    public init(level: UInt32) {
        this.level = level
    }
}
