from std import unittest.*
from std import unittest.testmacro.*
from std import io.*
from std import math.*

@Test
class ArrayTest {
    protected let END_HDR_SIZE: Int64 = 22 // END header size

    /*
     * End of central directory(END) signature
     */
    static let ENDSIG: Int64 = 0x06054b50 // "PK\005\006"
    let outPath = "/mnt/c/Users/lizhenjie/Desktop/test"
    @TestCase
    public func caseA(): Unit {
        var arr = Array<Int64>(99, {i => 0})
        for (index in arr.size() - 1..=0:-1) {
            arr[index] = index
            println(index)
        }
        println("${ arr.slice(0,3).toArray()}")
    }
    @TestCase
    public func caseC(): Unit {
        println(path)
        println(getFilePath("test/aa.txt"))
    }
    private func getFilePath(fileName: String): String {
        if (outPath.contains("/")) {
            var lastIndex = outPath.lastIndexOf("/")
            match (lastIndex) {
                case Some(index) =>
                    var lastName = outPath.slice(index, outPath.size()).toString()
                    if (fileName.startsWith(lastName)) {
                        return outPath.slice(0, index) + "/" + fileName
                    } else {
                        return outPath + "/" + fileName
                    }
                case None =>
                    throw RuntimeException("Get file path exception!")
            }
        } else if (outPath.contains("\\")) {
            var lastIndex = outPath.lastIndexOf("\\")
            match (lastIndex) {
                case Some(index) =>
                    var lastName = outPath.slice(index, outPath.size()).toString()
                    if (fileName.startsWith(lastName)) {
                        return outPath.slice(0, index) + "\\" + fileName
                    } else {
                        return outPath + "\\" + fileName
                    }
                case None =>
                    throw RuntimeException("Get file path exception!")
            }
        }
        return ""
    }
}
