//3rd_party_lib:zip4cj/build/zip4cj
//3rd_party_lib:zip4cj/build/charset
//data_file:test_01.jpg
//data_file:test_02.md
//data_file:test_03.pptx
//data_file:test_中文文件_04.md

from std import unittest.*
from std import unittest.testmacro.*

from zip4cj import zip4cj.zip.*
from zip4cj import zip4cj.utils.*
from std import os.posix.*
from std import collection.*
from std import fs.*

@Test
public class ZIPTest02 {
    var path: String = getcwd()
    var flag = false
    // 空初始化 添加无效文件
    @TestCase
    public func zip_test_05():Unit{
        flag = false
        var zipFile = ZipFile()
        zipFile.setOutPath("${path}/zip_test_file_05.zip")
        try {
            zipFile.addFile("${path}/test_01.jpg")
            zipFile.addFile("${path}/test_02")
            zipFile.addFile("${path}/test_03.pptx")
        } catch(e: Exception) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
    }

    // 带参初始化 添加无效文件
    @TestCase
    public func zip_test_06():Unit{
        flag = false
        var zipFile = ZipFile("${path}/zip_test_file_06.zip")
        zipFile.setOutPath("${path}/zip_test_file_06.zip")
        try {
            zipFile.addFile("${path}/test_01.jpg")
            zipFile.addFile("${path}/test_02")
            zipFile.addFile("${path}/test_03.pptx")
        } catch(e: Exception) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
    }

    // 带参初始化 空地址 中文地址
    @TestCase
    public func zip_test_07():Unit{
        var zipFile = ZipFile("${path}/中文地址")
        zipFile.addFile("${path}/test_01.jpg")
        zipFile.addFile("${path}/test_02.md")
        zipFile.addFile("${path}/test_03.pptx")
        zipFile.setOutPath("${path}/zip_test_文件_07.zip")
        zipFile.writeZip()

        var zipFileUnpack = ZipFile(path + "/zip_test_文件_07.zip")
        zipFileUnpack.setOutPath("${path}/zip_test_文件_07/")
        var unpackFiles = zipFileUnpack.extractAll()
        @Expect(unpackFiles[0].fileName, "test_01.jpg")
        @Expect(unpackFiles[1].fileName, "test_02.md")
        @Expect(unpackFiles[2].fileName, "test_03.pptx")

        var nameListUnpack:Array<String> = zipFileUnpack.nameList()
        @Expect(nameListUnpack[0], "test_01.jpg")
        @Expect(nameListUnpack[1], "test_02.md")
        @Expect(nameListUnpack[2], "test_03.pptx")
    }

    // 带参初始化 空地址
    @TestCase
    public func zip_test_08():Unit{
        var zipFile = ZipFile("")
        zipFile.addFile("${path}/test_01.jpg")
        zipFile.addFile("${path}/test_02.md")
        zipFile.addFile("${path}/test_03.pptx")
        zipFile.setOutPath("${path}/zip_test_file_08.zip")
        zipFile.writeZip()

        var zipFileUnpack = ZipFile(path + "/zip_test_file_08.zip")
        zipFileUnpack.setOutPath("${path}/zip_test_file_08/")
        var unpackFiles = zipFileUnpack.extractAll()
        @Expect(unpackFiles[0].fileName, "test_01.jpg")
        @Expect(unpackFiles[1].fileName, "test_02.md")
        @Expect(unpackFiles[2].fileName, "test_03.pptx")

        var nameListUnpack:Array<String> = zipFileUnpack.nameList()
        @Expect(nameListUnpack[0], "test_01.jpg")
        @Expect(nameListUnpack[1], "test_02.md")
        @Expect(nameListUnpack[2], "test_03.pptx")
    }

    // 添加空值文件
    @TestCase
    public func zip_test_09():Unit{
        flag = false
        var zipFile = ZipFile()
        try {
            zipFile.addFile("")
        } catch(e: Exception) {
            println(e.toString()) 
            flag = true
        }
        @Expect(flag)
    }

    // 添加中文文件
    @TestCase
    public func zip_test_10():Unit{
        var zipFile = ZipFile()
        zipFile.addFile("${path}/test_01.jpg")
        zipFile.addFile("${path}/test_02.md")
        zipFile.addFile("${path}/test_03.pptx")
        zipFile.addFile("${path}/test_中文文件_04.md")
        zipFile.setOutPath("${path}/zip_test_file_10.zip")
        zipFile.writeZip()

        var zipFileUnpack = ZipFile(path + "/zip_test_file_10.zip")
        zipFileUnpack.setOutPath("${path}/zip_test_file_10/")
        var unpackFiles = zipFileUnpack.extractAll()
        @Expect(unpackFiles[0].fileName, "test_01.jpg")
        @Expect(unpackFiles[1].fileName, "test_02.md")
        @Expect(unpackFiles[2].fileName, "test_03.pptx")
        @Expect(unpackFiles[3].fileName, "test_中文文件_04.md")

        var nameListUnpack:Array<String> = zipFileUnpack.nameList()
        @Expect(nameListUnpack[0], "test_01.jpg")
        @Expect(nameListUnpack[1], "test_02.md")
        @Expect(nameListUnpack[2], "test_03.pptx")
        @Expect(nameListUnpack[3], "test_中文文件_04.md")
    }
}