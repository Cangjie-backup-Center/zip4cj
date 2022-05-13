/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 */

/**
 * @file
 *
 * This is a class library that implements MS-DOS utils.
 */

package zip4cj
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
    public static  func getLastModFileTime(time: Time) {
        var lst = ArrayList<Int64>()
        lst.addAll(convertToBinary(time.hour(), length: 5))
        lst.addAll(convertToBinary(time.minute(), length: 6))
        lst.addAll(convertToBinary(time.second() / 2, length: 5))
        var supIndex = lst.size() - 1
        var sum = 0
        for (num in lst) {
            sum += num * (2 ** supIndex)
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
    public static  func getLastModFileDate(time: Time): Int64 {
        var lst = ArrayList<Int64>()
        lst.addAll(convertToBinary(time.year() - 1980, length: 7))
        lst.addAll(convertToBinary(time.month().value(), length: 4))
        lst.addAll(convertToBinary(time.day(), length: 5))
        var supIndex = lst.size() - 1
        var sum = 0
        for (num in lst) {
            sum += num * (2 ** supIndex)
            supIndex--
        }
        return sum
    }

    static func convertToBinary(value: Int64, length!: Int64): Array<Int64> {
        var tempVal = value
        var lst = Array<Int64>(length, {i => 0})
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
