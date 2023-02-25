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
public class ZIPTest01 {
    var path: String = getcwd()
    
    // 空初始化 文件地址正确 压缩三个文件 
    @TestCase
    public func zip_test_01():Unit{  
        var zipFile = ZipFile()
        zipFile.addFile("${path}/test_01.jpg")
        zipFile.addFile("${path}/test_02.md")
        zipFile.addFile("${path}/test_03.pptx")
        zipFile.setOutPath("${path}/zip_test_file_01.zip")
        zipFile.writeZip()

        // nameList 的获取前提时初始化时要带参 并且还要设置 setOutPath
        var zipFileUnpack = ZipFile(path + "/zip_test_file_01.zip")
        zipFileUnpack.setOutPath("${path}/zip_test_file_01/")
        var unpackFiles = zipFileUnpack.extractAll()
        @Expect(unpackFiles[0].fileName, "test_01.jpg")
        @Expect(unpackFiles[1].fileName, "test_02.md")
        @Expect(unpackFiles[2].fileName, "test_03.pptx")

        var nameListUnpack:Array<String> = zipFileUnpack.nameList()
        @Expect(nameListUnpack[0], "test_01.jpg")
        @Expect(nameListUnpack[1], "test_02.md")
        @Expect(nameListUnpack[2], "test_03.pptx")
    }

    // 带参初始化 文件地址正确 压缩三个文件 
    @TestCase
    public func zip_test_02():Unit{
        var zipFile = ZipFile(path + "/zip_test_file_02.zip")
        // ??带参创建时还是需要设置输出地址?
        zipFile.setOutPath("${path}/zip_test_file_02.zip")
        zipFile.addFile("${path}/test_01.jpg")
        zipFile.addFile("${path}/test_02.md")
        zipFile.addFile("${path}/test_03.pptx")
        zipFile.writeZip()

        var zipFileUnpack = ZipFile(path + "/zip_test_file_02.zip")
        zipFileUnpack.setOutPath("${path}/zip_test_file_02/")
        var unpackFiles = zipFileUnpack.extractAll()
        @Expect(unpackFiles[0].fileName, "test_01.jpg")
        @Expect(unpackFiles[1].fileName, "test_02.md")
        @Expect(unpackFiles[2].fileName, "test_03.pptx")

        var nameListUnpack:Array<String> = zipFileUnpack.nameList()
        @Expect(nameListUnpack[0], "test_01.jpg")
        @Expect(nameListUnpack[1], "test_02.md")
        @Expect(nameListUnpack[2], "test_03.pptx")
    }


    // 空值初始化 压缩文件集合 
    @TestCase
    public func zip_test_03():Unit{
        var zipFile = ZipFile()
        zipFile.setOutPath(path + "/zip_test_file_03.zip")
        var fileSet:HashSet<String> = HashSet<String>(["${path}/test_01.jpg", "${path}/test_02.md", "${path}/test_03.pptx"])
        zipFile.addFiles(fileSet)
        zipFile.writeZip()

        var zipFileUnpack = ZipFile(path + "/zip_test_file_03.zip")
        zipFileUnpack.setOutPath("${path}/zip_test_file_03/")
        var unpackFiles = zipFileUnpack.extractAll()
        @Expect(unpackFiles[0].fileName, "test_01.jpg")
        @Expect(unpackFiles[1].fileName, "test_02.md")
        @Expect(unpackFiles[2].fileName, "test_03.pptx")

        var nameListUnpack:Array<String> = zipFileUnpack.nameList()
        @Expect(nameListUnpack[0], "test_01.jpg")
        @Expect(nameListUnpack[1], "test_02.md")
        @Expect(nameListUnpack[2], "test_03.pptx")
    }

    // 带参初始化 压缩文件集合
    @TestCase
    public func zip_test_04():Unit{
        var zipFile = ZipFile(path + "/zip_test_file_04.zip")
        var fileSet:HashSet<String> = HashSet<String>(["${path}/test_01.jpg", "${path}/test_02.md", "${path}/test_03.pptx"])
        zipFile.addFiles(fileSet)
        zipFile.setOutPath(path + "/zip_test_file_04.zip")
        zipFile.writeZip()

        var zipFileUnpack = ZipFile(path + "/zip_test_file_04.zip")
        zipFileUnpack.setOutPath("${path}/zip_test_file_04/")
        var unpackFiles = zipFileUnpack.extractAll()
        @Expect(unpackFiles[0].fileName, "test_01.jpg")
        @Expect(unpackFiles[1].fileName, "test_02.md")
        @Expect(unpackFiles[2].fileName, "test_03.pptx")

        var nameListUnpack:Array<String> = zipFileUnpack.nameList()
        @Expect(nameListUnpack[0], "test_01.jpg")
        @Expect(nameListUnpack[1], "test_02.md")
        @Expect(nameListUnpack[2], "test_03.pptx")
    }
}