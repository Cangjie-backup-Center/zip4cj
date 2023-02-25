from std import unittest.*
from std import unittest.testmacro.*
from zip4cj import zip4cj.zip.ZipFile
from std import collection.*

@Test
public class zip4cj_test {
    @TestCase
    public func caseZipNameList(): unit {
        println("-------------caseZipNameList--------------------------")
        var zf: ZipFile = ZipFile("/mnt/c/Users/lizhenjie/Desktop/water_analysis.zip")
        var nameList = zf.nameList()
        for (fileName in nameList) {
            println(fileName)
        }
    }
    @TestCase
    public func caseExtractZip(): unit {
        println("-------------caseExtractZip--------------------------")
        var zf: ZipFile = ZipFile("/mnt/c/Users/lizhenjie/Desktop/water_analysis.zip")
        zf.setOutPath("/mnt/c/Users/lizhenjie/Desktop/water_analysis")
        zf.extractAll()
    }

    @TestCase
    public func caseWriteZip(): unit {
        println("-------------caseWriteZip--------------------------")
        var zf: ZipFile = ZipFile()
        zf.setOutPath("/mnt/c/Users/lizhenjie/Desktop/test.zip")
        zf.addFile("/mnt/c/Users/lizhenjie/Desktop/cangjie_debug安装.pdf")
        zf.addFile("/mnt/c/Users/lizhenjie/Desktop/619231218.doc")
        zf.writeZip()
    }
    @TestCase
    public func caseWriteZip2(): unit {
        println("-------------caseWriteZip2--------------------------")
        var zf: ZipFile = ZipFile()
        zf.setOutPath("/mnt/c/Users/lizhenjie/Desktop/test2.zip")
        var set = HashSet<String>()
        set.put("/mnt/c/Users/lizhenjie/Desktop/cangjie_debug安装.pdf")
        set.put("/mnt/c/Users/lizhenjie/Desktop/619231218.doc")
        zf.addFiles(set)
        zf.writeZip()
    }
    @TestCase
    public func caseWriteZipWithParam(): unit {
        println("-------------caseWriteZipWithParam--------------------------")
        var zf: ZipFile = ZipFile()
        zf.setOutPath("/mnt/c/Users/lizhenjie/Desktop/test3.zip")
        var set = HashSet<String>()
        set.put("/mnt/c/Users/lizhenjie/Desktop/cangjie_debug安装.pdf")
        set.put("/mnt/c/Users/lizhenjie/Desktop/619231218.doc")
        zf.addFiles(set)
        zf.writeZip()
    }
}
