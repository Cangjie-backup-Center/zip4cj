/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

/**
 * @file
 *
 * The class is ZipSignatures inherited from ZipConstants.
 */

package zip4cj

/*
 * The class is ZipSignatures inherited from ZipConstants
 * @since 0.28.4
 */
abstract class ZipSignatures <: ZipConstants {
    /* Local file (LOC) header signature PK\003\004 */
    static let LOCSIG: Int64 = 0x04034b50

    /* The data descriptor record  signature PK\007\008 */
    static let EXTSIG: Int64 = 0x08074b50

    /* Central directory file (CEN) header signature PK\001\002*/
    static let CENSIG: Int64 = 0x02014b50

    /* End of central directory(END) signature PK\005\006 */
    static let ENDSIG: Int64 = 0x06054b50

    /* ZIP64 end of central directory(ZIP64_END) signature PK\006\006 */
    static let ZIP64_ENDSIG: Int64 = 0x06064b50

    /* ZIP64 local file (ZIP64_LOC) header signature PK\006\007 */
    static let ZIP64_LOCSIG: Int64 = 0x07064b50
}
