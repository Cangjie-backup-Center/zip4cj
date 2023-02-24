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
from std import time.*

@Test
public class ZIPTest01 {
    var path: String = getcwd()
    var flag = false

    @TestCase
    public func zip_test_01():Unit{  

        println("=====第一步=====")
        var zipFile1 = ZipFile()
        zipFile1.addFile("${path}/test_01.jpg")
        zipFile1.setOutPath("${path}/zip_test_file_35.zip")
        zipFile1.writeZip()

        println("=====第二步=====")
        var zipFileUnpack1 = ZipFile("${path}/zip_test_file_35.zip")
        zipFileUnpack1.setOutPath("${path}/zip_test_file_35/")
        var nameList1 = zipFileUnpack1.nameList()
        @Expect(nameList1[0], "test_01.jpg")

        println("=====第三步=====")
        var zipFile2 = ZipFile("${path}/zip_test_file_35.zip")
        zipFile2.addFile("${path}/test_02.md")
        zipFile2.setOutPath("${path}/zip_test_file_35.zip")
        zipFile2.writeZip()

        println("=====第四步=====")
        var zipFileUnpack2 = ZipFile("${path}/zip_test_file_35.zip")
        zipFileUnpack2.setOutPath("${path}/zip_test_file_35/")
        var nameList2 = zipFileUnpack2.nameList()
        @Expect(nameList2[0], "test_02.md")
    
    }

    
}