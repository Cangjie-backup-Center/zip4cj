/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

/**
 * @file
 *
 * This is the custom type of define the end of central directory record field.
 */

package zip4cj.zip

/*
 * Create a custom type called EndCDR.
 * Define the end of central directory record field.
 *
 * @since 0.28.4    @author lizhenjie
 */
struct EndCDR {
    public var sig: Int64 = 0
    public var diskNum: Int64 = 0
    public var numberOfThisDiskStartOfCentralDir: Int64 = 0
    public var totalNumberOfEntriesInCentralDirectoryOnThisDisk: Int64 = 0
    public var totalNumberOfEntriesInCentralDirectory: Int64 = 0
    public var sizeOfCentralDirectory: Int64 = 0
    public var offsetOfEndOfCentralDirectory: Int64 = 0
    public var offsetOfStartOfCentralDirectory: Int64 = 0
    public var commentLength: Int64 = 0
    public var comment: String
    public init(
        sig: Int64,
        diskNum: Int64,
        numberOfThisDiskStartOfCentralDir: Int64,
        totalNumberOfEntriesInCentralDirectoryOnThisDisk: Int64,
        totalNumberOfEntriesInCentralDirectory: Int64,
        sizeOfCentralDirectory: Int64,
        offsetOfEndOfCentralDirectory: Int64,
        offsetOfStartOfCentralDirectory: Int64,
        commentLength: Int64,
        comment: String
    ) {
        this.sig = sig
        this.diskNum = diskNum
        this.numberOfThisDiskStartOfCentralDir = numberOfThisDiskStartOfCentralDir
        this.totalNumberOfEntriesInCentralDirectoryOnThisDisk = totalNumberOfEntriesInCentralDirectoryOnThisDisk
        this.totalNumberOfEntriesInCentralDirectory = totalNumberOfEntriesInCentralDirectory
        this.sizeOfCentralDirectory = sizeOfCentralDirectory
        this.offsetOfEndOfCentralDirectory = offsetOfEndOfCentralDirectory
        this.offsetOfStartOfCentralDirectory = offsetOfStartOfCentralDirectory
        this.commentLength = commentLength
        this.comment = comment
    }
}