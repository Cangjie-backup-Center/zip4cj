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
public class ZIPTest05 {
    var path: String = getcwd()
    var flag = false

    // writeFile 方法 filePath 正常地址 ""地址 特殊符号 中文地址
    @TestCase
    public func zip_test_24():Unit{
        var outData: Array<UInt8> = Array<UInt8>()
        FileUtils.writeFile(outData, path + "/test_01.jpg")
        flag = false
        try {
            FileUtils.writeFile(outData, path + "")
        } catch(e: FSException) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
        
        flag = false
        try {
            FileUtils.writeFile(outData, path + "/!@#$%^&^%&*()_+/*-~[];',.")
        } catch(e: FSException) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
        FileUtils.writeFile(outData, path + "/test_中文文件_04.md")
    }

    // writeFile 方法 filePath 超长字符串
    @TestCase
    public func zip_test_25():Unit{
        var outData: Array<UInt8> = Array<UInt8>()
        var tagString_a = StringBuilder('a', 2048).toString()
        flag = false
        try {
            FileUtils.writeFile(outData, path + "/${tagString_a}")
        } catch(e: FSException) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
    }

    // writeFile 方法 outData 存放读取的文件内容
    @TestCase
    public func zip_test_26():Unit{
        var fileName: String = "${path}/test_02.md"
        var data: Array<UInt8> = File.readFrom(fileName)  
        var outPath: String = "${path}/test_26.md"
        FileUtils.writeFile(data, outPath)
        var outData: Array<UInt8> = File.readFrom(outPath)  
        @Expect(data.size, outData.size)
    }

    // writeFile 方法 outData 空
    @TestCase
    public func zip_test_27():Unit{
        var fileName: String = "${path}/test_02.md"
        var data: Array<UInt8> = Array<UInt8>()
        var outPath: String = "${path}/test_27.md"
        FileUtils.writeFile(data, outPath)
        var outData: Array<UInt8> = File.readFrom(outPath)  
        @Expect(data.size, outData.size)
    }

    // ZipException 正常字符串 "" 特殊字符串 中文字符串  超长字符串
    @TestCase
    public func zip_test_28():Unit{
        var exception1: ZipException = ZipException("message")
        var exception2: ZipException = ZipException("")
        var exception3: ZipException = ZipException("/!@#$%^&^%&*()_+/*-~[];',.")
        var exception4: ZipException = ZipException("中文信息")
        var tagString_a = StringBuilder('a', 2048).toString()
        var exception5: ZipException = ZipException(tagString_a)
    }
}