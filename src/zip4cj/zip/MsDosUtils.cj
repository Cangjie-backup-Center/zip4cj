/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

/**
 * @file
 *
 * This is a class library that implements MS-DOS utils.
 */

package zip4cj.zip

from std import time.*

/*
 * MS-DOS  utils
 * @since 0.28.4    @author lizhenjie
 */
open class MsDosUtils {
    /*
     * Get last modFile time
     *
     * @param time Current time
     *
     * @since 0.28.4
     */
    public static func getLastModFileTime(time: DateTime) {
        var lst = ArrayList<Int64>()
        lst.appendAll(convertToBinary(time.hour, length: 5))
        lst.appendAll(convertToBinary(time.minute, length: 6))
        lst.appendAll(convertToBinary(time.second / 2, length: 5))
        var supIndex = lst.size - 1
        var sum = 0
        for (num in lst) {
            sum += num * (2 ** UInt64(supIndex))
            supIndex--
        }
        return sum
    }

    /*
     * Get last modFile date
     *
     * @param time current time
     *
     * @return Returns the date of the final acquisition,type is Int64
     * @since
     */
    public static func getLastModFileDate(time: DateTime): Int64 {
        var lst = ArrayList<Int64>()
        lst.appendAll(convertToBinary(time.year - 1980, length: 7))
        lst.appendAll(convertToBinary(time.month.value(), length: 4))
        lst.appendAll(convertToBinary(time.dayOfMonth, length: 5))
        var supIndex = lst.size - 1
        var sum = 0
        for (num in lst) {
            sum += num * (2 ** UInt64(supIndex))
            supIndex--
        }
        return sum
    }

    static func convertToBinary(value: Int64, length!: Int64): Array<Int64> {
        var tempVal = value
        var lst = Array<Int64>(length, item: 0)
        var index = 0
        while (true) {
            lst[index] = (tempVal % 2)
            if (tempVal < 2) {
                break
            }
            tempVal = tempVal / 2
            index++
        }
        lst.reverse()
        return lst
    }
}
