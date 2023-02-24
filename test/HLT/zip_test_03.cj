//3rd_party_lib:zip4cj/build/zip4cj
//3rd_party_lib:zip4cj/build/charset
//data_file:test_01.jpg
//data_file:test_02.md
//data_file:test_03.pptx

from std import unittest.*
from std import unittest.testmacro.*

from zip4cj import zip4cj.zip.*
from zip4cj import zip4cj.utils.*
from std import os.posix.*
from std import collection.*
from std import fs.*

@Test
public class ZIPTest03 {
    var path: String = getcwd()
    var flag = false
    
    // 添加空文件集合
    @TestCase
    public func zip_test_11():Unit{
        flag = false
        var zipFile = ZipFile()
        zipFile.setOutPath(path + "/zip_test_file_11.zip")
        var fileSet:HashSet<String> = HashSet<String>()
        try {
            zipFile.addFiles(fileSet)
        } catch(e: Exception) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
    }

    // 设置输出地址为空
    @TestCase
    public func zip_test_12():Unit{
        flag = false
        var zipFile = ZipFile()
        zipFile.setOutPath("")
        var fileSet:HashSet<String> = HashSet<String>(["${path}/test_01.jpg"])
        zipFile.addFiles(fileSet)
        try {
            zipFile.writeZip()
        } catch(e: Exception) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
    }

    // 设置输出地址为中文地址
    @TestCase
    public func zip_test_13():Unit{
        flag = false
        var zipFile = ZipFile()
        zipFile.setOutPath("${path}/中文地址.zip")
        var fileSet:HashSet<String> = HashSet<String>(["${path}/test_01.jpg"])
        zipFile.addFiles(fileSet)
        zipFile.writeZip()

        var zipFileUnpack = ZipFile("${path}/中文地址.zip")
        zipFileUnpack.setOutPath("${path}/")
        var nameList = zipFileUnpack.nameList()
        @Expect(nameList[0], "test_01.jpg")
    }

    // 输出地址非 .zip 格式 时压缩
    @TestCase
    public func zip_test_14():Unit{
        flag = false
        var zipFile = ZipFile()
        zipFile.setOutPath(path + "/zip_test_file_14.rar")
        var fileSet:HashSet<String> = HashSet<String>(["${path}/test_01.jpg"])
        zipFile.addFiles(fileSet)
        try {
            zipFile.writeZip()
        } catch(e: Exception) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
    }

    // 设置解压输出地址为空
    @TestCase
    public func zip_test_15():Unit{
        var zipFile = ZipFile(path + "/zip_test_file_15.zip")
        var fileSet:HashSet<String> = HashSet<String>(["${path}/test_01.jpg", "${path}/test_02.md", "${path}/test_03.pptx"])
        zipFile.addFiles(fileSet)
        zipFile.setOutPath(path + "/zip_test_file_15.zip")
        zipFile.writeZip()

        var zipFileUnpack = ZipFile(path + "/zip_test_file_15.zip")
        zipFileUnpack.setOutPath("")
        
        flag = false
        try {
            var unpackFiles = zipFileUnpack.extractAll()
        } catch(e: Exception) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
    }
}