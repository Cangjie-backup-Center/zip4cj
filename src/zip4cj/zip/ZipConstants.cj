/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

/**
 * @file
 *
 * This abstract defines the constants that are used by the classes.
 */

package zip4cj.zip

/*
 * This abstract defines the constants that are used by the classes
 * which manipulate ZIP files.
 * @since 0.28.4    @author lizhenjie
 */
abstract class ZipConstants {
    
    /* header sizes in bytes */
    protected let LOC_HDR_SIZE: Int64 = 30 // LOC header size
    protected let EXT_HDR_SIZE: Int64 = 16 // EXT header size
    protected let CEN_HDR_SIZE: Int64 = 46 // CEN header size
    protected let END_HDR_SIZE: Int64 = 22 // END header size

    /* Local file (LOC_HDR) header field offsets */
    protected let LOC_HDR_SIG_OFFSET: Int64 = 0 // Local file header signature
    protected let LOC_HDR_VER_OFFSET: Int64 = 4 // version needed to extract
    protected let LOC_HDR_FLG_OFFSET: Int64 = 6 // general purpose bit flag
    protected let LOC_HDR_HOW_OFFSET: Int64 = 8 // compression method
    protected let LOC_HDR_TIM_OFFSET: Int64 = 10 // modification time
    protected let LOC_HDR_DAT_OFFSET: Int64 = 12 // modification date
    protected let LOC_HDR_CRC_OFFSET: Int64 = 14 // uncompressed file crc-32 value
    protected let LOC_HDR_SIZ_OFFSET: Int64 = 18 // compressed size
    protected let LOC_HDR_LEN_OFFSET: Int64 = 22 // uncompressed size
    protected let LOC_HDR_NAM_OFFSET: Int64 = 26 // filename length
    protected let LOC_HDR_EXT_OFFSET: Int64 = 28 // extra field length
    protected let LOC_HDR_FNM_OFFSET: Int64 = 30 // filename


    /* Extra local (EXT) header field offsets(data descriptor) */
    protected let EXT_CRC_OFFSET: Int64 = 4 // uncompressed file crc-32 value
    protected let EXT_SIZ_OFFSET: Int64 = 8 // compressed size
    protected let EXT_LEN_OFFSET: Int64 = 12 // uncompressed size

    /* Central directory (CEN)  field offsets */
    protected let CEN_SIG_OFFSET: Int64 = 0 //Central directory (CEN) signature
    protected let CEN_VEM_OFFSET: Int64 = 4 // version made by
    protected let CEN_VER_OFFSET: Int64 = 6 // version needed to extract
    protected let CEN_FLG_OFFSET: Int64 = 8 // encrypt, decrypt flags
    protected let CEN_HOW_OFFSET: Int64 = 10 // compression method
    protected let CEN_TIM_OFFSET: Int64 = 12 // modification time
    protected let CEN_DAT_OFFSET: Int64 = 14 // modification date
    protected let CEN_CRC_OFFSET: Int64 = 16 // uncompressed file crc-32 value
    protected let CEN_SIZ_OFFSET: Int64 = 20 // compressed size
    protected let CEN_LEN_OFFSET: Int64 = 24 // uncompressed size
    protected let CEN_NAM_OFFSET: Int64 = 28 // filename length
    protected let CEN_EXT_OFFSET: Int64 = 30 // extra field length
    protected let CEN_COM_OFFSET: Int64 = 32 // comment length
    protected let CEN_DSK_OFFSET: Int64 = 34 // disk number start
    protected let CEN_ATT_OFFSET: Int64 = 36 // internal file attributes
    protected let CEN_ATX_OFFSET: Int64 = 38 // external file attributes
    protected let CEN_OFF_OFFSET: Int64 = 42 // LOC header offset
    protected let CEN_FNM_OFFSET: Int64 = 46 // fileName

    /* End of central directory (END) record field offsets */
    protected let END_SIG_OFFSET: Int64 = 0 //Central directory (END) signature
    protected let END_NMD_OFFSET: Int64 = 4 // numberOfThisDisk
    protected let END_DSK_OFFSET: Int64 = 6 // numberOfThisDiskStartOfCentralDir
    protected let END_TOD_OFFSET: Int64 = 8 // total number of entries on this disk
    protected let END_TOT_OFFSET: Int64 = 10 // total number of entries
    protected let END_SIZ_OFFSET: Int64 = 12 // central directory size in bytes
    protected let END_OFF_OFFSET: Int64 = 16 // offset of first CEN header
    protected let END_COM_OFFSET: Int64 = 20 // zip file comment length

    /* zip64 Header sizes in bytes */
    let ZIP64_END_HDR: Int64 = 56 // ZIP64 end header size
    let ZIP64_LOC_HDR: Int64 = 20 // ZIP64 end loc header size
    let ZIP64_EXT_HDR: Int64 = 24 // EXT header size
    let ZIP64_EXT_ID = 0x0001 // Extra field Zip64 header ID

    let ZIP64_MAGIC_COUNT = 0xFFFF
    let ZIP64_MAGIC_VAL = 0xFFFFFFFF

    /* Zip64 End of central directory (END) header field offsets */
    let ZIP64_END_SIG: Int64 = 0 // End central directory (ZIP64_END) signature
    let ZIP64_END_LEN: Int64 = 4 // size of zip64 end of central dir
    let ZIP64_END_VEM: Int64 = 12 // version made by
    let ZIP64_END_VER: Int64 = 14 // version needed to extract
    let ZIP64_END_NMD: Int64 = 16 // number of this disk
    let ZIP64_END_DSK: Int64 = 20 // disk number of start
    let ZIP64_END_TOD: Int64 = 24 // total number of entries on this disk
    let ZIP64_END_TOT: Int64 = 32 // total number of entries
    let ZIP64_END_SIZ: Int64 = 40 // central directory size in bytes
    let ZIP64_END_OFF: Int64 = 48 // offset of first CEN header
    let ZIP64_END_EXT: Int64 = 56 // zip64 extensible data sector

    /* Zip64 End of central directory locator field offsets */
    let ZIP64_LOC_DSK_OFFSET: Int64 = 4 // disk number start
    let ZIP64_LOC_OFF_OFFSET: Int64 = 8 // offset of zip64 end
    let ZIP64_LOC_TOT_OFFSET: Int64 = 16 // total number of disks

    /* Zip64 Extra local (EXT) header field offsets */
    let ZIP64_EXT_CRC_OFFSET: Int64 = 4 // uncompressed file crc-32 value
    let ZIP64_EXT_SIZ_OFFSET: Int64 = 8 // compressed size, 8-byte
    let ZIP64_EXT_LEN_OFFSET: Int64 = 16 // uncompressed size, 8-byte

    /* Language encoding flag EFS */
    let EFS = 0x800 // If this bit is set the filename and

    /* comment fields for this file must be, encoded using UTF-8. */

    /*
     * Constants below are defined here (instead of in ZipConstants)
     * to avoid being exposed as public fields of ZipFile, ZipEntry,
     * ZipInputStream and ZipOutputstream.
     */

    /* Extra field header ID */
    let EXTID_ZIP64 = 0x0001
    let EXTID_NTFS = 0x000a
    let EXTID_UNIX = 0x000d
    /* Info-ZIP Extended Timestamp */
    let EXTID_EXTT = 0x5455

    /* EXTT timestamp flags */
    /* LastModifiedTime */
    let EXTT_FLAG_LMT = 0x1
    /* LastAccessTime */
    let EXTT_FLAG_LAT = 0x2
    /* CreationTime */
    let EXTT_FLAT_CT = 0x4
    let GENERAL_PURPOSE_BIT_FLAG_SIZE=16
}
