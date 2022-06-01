/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

/**
 * @file
 *
 * This is a class that provides compression methods.
 * Provided Two variables STORE and DEFLATE
 */

package zip4cj.zip

/*
 * The class is CompressionMethod
 * @since 0.28.4
 */
public class CompressionMethod {

    /* No compression is performed */
    public static let STORE = 0

    /*
     * The Deflate compression is used.
     * @see java.util.zip.Deflater
     */
    public static let DEFLATE = 8
}
