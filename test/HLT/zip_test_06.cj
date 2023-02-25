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
from std import time.*

@Test
public class ZIPTest06 {
    var path: String = getcwd()
    var flag = false

    // 没有文件夹的压缩和解压
    // 向已有数据的压缩文件中添加文件
    @TestCase
    public func zip_test_29():Unit{
        var srcSize_test_01: Array<Byte> = File.readFrom("${path}/test_01.jpg")
        var srcSize_test_02: Array<Byte> = File.readFrom("${path}/test_02.md")
        var srcSize_test_03: Array<Byte> = File.readFrom("${path}/test_03.pptx")

        var zipFile = ZipFile()
        zipFile.setOutPath("${path}/zip_test_file_29.zip")
        zipFile.addFile("${path}/test_01.jpg")
        zipFile.writeZip()
        
        var zipFileUnpack_01 = ZipFile("${path}/zip_test_file_29.zip")
        zipFileUnpack_01.setOutPath("${path}/")
        var unpackFiles_01 = zipFileUnpack_01.extractAll()

        var unzipSize_test_01: Array<Byte> = unpackFiles_01[0].inflateData
        @Expect(srcSize_test_01.size, unzipSize_test_01.size)

        zipFile.addFile("${path}/test_02.md")
        zipFile.writeZip()
        var zipFileUnpack_02 = ZipFile("${path}/zip_test_file_29.zip")
        zipFileUnpack_02.setOutPath("${path}/")
        var unpackFiles_02 = zipFileUnpack_02.extractAll()
        @Expect(zipFileUnpack_02.nameList().size, 2)
        var unzipSize_test_02: Array<Byte> = unpackFiles_02[1].inflateData
        @Expect(srcSize_test_02.size, unzipSize_test_02.size)

        zipFile.addFile("${path}/test_03.pptx")
        zipFile.writeZip()
        var zipFileUnpack_03 = ZipFile("${path}/zip_test_file_29.zip")
        zipFileUnpack_03.setOutPath("${path}/")
        var unpackFiles_03 = zipFileUnpack_03.extractAll()
        @Expect(zipFileUnpack_03.nameList().size, 3)
        var unzipSize_test_03: Array<Byte> = unpackFiles_03[2].inflateData
        @Expect(srcSize_test_03.size, unzipSize_test_03.size)
    }

    // 解压路径中有同名文件
    @TestCase
    public func zip_test_30():Unit{
        
        var zipFile = ZipFile()
        zipFile.setOutPath("${path}/zip_test_file_30.zip")
        zipFile.addFile("${path}/test_01.jpg")
        zipFile.addFile("${path}/test_02.md")
        zipFile.writeZip()
        
        var srcSize_test_01: Array<Byte> = File.readFrom("${path}/test_01.jpg")
        var srcSize_test_02: Array<Byte> = File.readFrom("${path}/test_02.md")

        var zipFileUnpack = ZipFile("${path}/zip_test_file_30.zip")
        zipFileUnpack.setOutPath("${path}/")
        var unpackFiles = zipFileUnpack.extractAll()

        var unzipSize_test_01: Array<Byte> = File.readFrom("${path}/test_01.jpg")
        var unzipSize_test_02: Array<Byte> = File.readFrom("${path}/test_02.md")
        
        @Expect(srcSize_test_01.size, unzipSize_test_01.size)
        @Expect(srcSize_test_02.size, unzipSize_test_02.size)
    }

    // 压缩大文件 - 大文件无法上传只能本地测试  
    // 
    // 需要设置更大的内存才能压缩
    // ??压缩1G 左右的文件, 设置了cj 堆内存1G 仍然会报错OutOfMemoryError: invalid data block
    // 设置为5G 才能压缩成功
    /*
    @TestCase
    public func zip_test_31():Unit{
        var zipFile = ZipFile()
        zipFile.setOutPath("${path}/zip_test_file_31.zip")
        zipFile.addFile("${path}/output.mp4")
        zipFile.writeZip()

        var zipFileUnpack = ZipFile("${path}/zip_test_file_30.zip")
        zipFileUnpack.setOutPath("${path}/zip_test_file_30/")
        var unpackFiles = zipFileUnpack.extractAll()

        @Expect(unpackFiles[0].fileName, "output.mp4")

        var nameListUnpack:Array<String> = zipFileUnpack.nameList()
        @Expect(nameListUnpack[0], "output.mp4")
    }
    */

    // 补充测试 ZipFile 初始化
    // 带参初始化会在解压时校验参数是否合法
    @TestCase
    public func zip_test_32():Unit{
        var zipFile = ZipFile("@!$^%&(*)_]l[k.")
        zipFile.setOutPath("${path}/zip_test_file_32.zip")
        zipFile.addFile("${path}/test_01.jpg")
        zipFile.addFile("${path}/test_02.md")
        zipFile.writeZip()
        
        zipFile.setOutPath("${path}/zip_test_file_32/")
        flag = false
        try {
            var unpackFiles = zipFile.extractAll()
        } catch(e: Exception) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
    }

    // 补充测试 getFilePath outPath参数输入完整路径
    // 这个算是符合要求吗?
    @TestCase
    public func zip_test_33():Unit{
        var filePath1 = FileUtils.getFilePath("${path}/test_01.jpg", "test_01.jpg")
        @Expect(filePath1, "${path}/test_01.jpg/test_01.jpg")
    }

    // 补充测试 getFilePath outPath参数输入完整路径
    @TestCase
    public func zip_test_34():Unit{
        var filePath1 = FileUtils.getFilePath("${path}/test_01.jpg", "test_01.jpg")
        @Expect(filePath1, "${path}/test_01.jpg/test_01.jpg")
    } 

    // 补充测试 同名文件压缩 没有报错/提示 没有覆盖 没有追加到压缩文件中
    @TestCase
    public func zip_test_35():Unit{
        var zipFile1 = ZipFile()
        zipFile1.addFile("${path}/test_01.jpg")
        zipFile1.setOutPath("${path}/zip_test_file_35.zip")
        zipFile1.writeZip()

        var zipFileUnpack1 = ZipFile("${path}/zip_test_file_35.zip")
        zipFileUnpack1.setOutPath("${path}/zip_test_file_35/")
        var nameList1 = zipFileUnpack1.nameList()
        @Expect(nameList1[0], "test_01.jpg")

        var zipFile2 = ZipFile("${path}/zip_test_file_35.zip")
        zipFile2.addFile("${path}/test_02.md")
        zipFile2.setOutPath("${path}/zip_test_file_35.zip")
        zipFile2.writeZip()

        var zipFileUnpack2 = ZipFile("${path}/zip_test_file_35.zip")
        zipFileUnpack2.setOutPath("${path}/zip_test_file_35/")
        var nameList2 = zipFileUnpack2.nameList()
        @Expect(nameList2[0], "test_02.md")
    }
}