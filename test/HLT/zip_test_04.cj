//3rd_party_lib:zip4cj/build/zip4cj
//3rd_party_lib:zip4cj/build/charset
//data_file:test_01.jpg
//data_file:test_02.md
//data_file:test_03.pptx
//data_file:中文路径/test_02.md
//data_file:test_中文文件_04.md

from std import unittest.*
from std import unittest.testmacro.*

from zip4cj import zip4cj.zip.*
from zip4cj import zip4cj.utils.*
from std import os.posix.*
from std import collection.*
from std import fs.*

@Test
public class ZIPTest04 {
    var path: String = getcwd()
    var flag = false
    
    // getFilePath 方法 outPath 正常地址 ""地址 特殊符号 中文地址
    // 以 / 区分是否是地址
    @TestCase
    public func zip_test_16():Unit{
        var filePath1 = FileUtils.getFilePath(path, "test_01.jpg")
        @Expect(filePath1, "${path}/test_01.jpg")

        FileUtils.getFilePath("/", "test_01.jpg")
        flag = false
        try {
            FileUtils.getFilePath("", "test_01.jpg")
        } catch(e: NoneValueException) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag, false)
        
        FileUtils.getFilePath("/aaaabbbb5555", "test_01.jpg")
        flag = false
        try {
            FileUtils.getFilePath("aaaabbbb5555", "test_01.jpg")
        } catch(e: NoneValueException) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag, false)

        FileUtils.getFilePath("!@#$%^&^%&/*()_+*-~[];',.", "test_01.jpg")
        flag = false
        try {
            FileUtils.getFilePath("!@#$%^&^%&*()_+*-~[];',.", "test_01.jpg")
        } catch(e: NoneValueException) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag, false)

        var filePath2 = FileUtils.getFilePath(path + "/中文路径", "test_02.md")
        @Expect(filePath2, "${path}/中文路径/test_02.md")
    }

    // getFilePath 方法 outPath 超长字符串
    @TestCase
    public func zip_test_17():Unit{
        var tagString_a = StringBuilder('a', 2048).toString()
        try {
            FileUtils.getFilePath("${tagString_a}", "test_01.jpg")
        } catch(e: NoneValueException) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag, false)
    }

    // getFilePath 方法 fileName 正常字符串  "" 中文 特殊符号
    // 目前是对于 fileName 找不到的情况就直接返回"" 
    @TestCase
    public func zip_test_18():Unit{
        var filePath1 = FileUtils.getFilePath(path, "test_01.jpg")
        @Expect(filePath1, "${path}/test_01.jpg")

        FileUtils.getFilePath(path, "")
        FileUtils.getFilePath(path, "!@#$%^&^%&*()_+/*-~[];',.")
        
        var filePath2 = FileUtils.getFilePath(path, "test_中文文件_04.md")
        @Expect(filePath2, "${path}/test_中文文件_04.md")
    }

    // getFilePath 方法 fileName 超长字符串
    @TestCase
    public func zip_test_19():Unit{
        var tagString_a = StringBuilder('a', 2048).toString()
        FileUtils.getFilePath(path, "${tagString_a}")
    }

    // getFileName 方法 path 正常地址 ""地址 特殊符号 中文地址
    @TestCase
    public func zip_test_20():Unit{
        var fileName1 = FileUtils.getFileName(path + "/test_01.jpg")
        @Expect(fileName1, "test_01.jpg")

        flag = false
        try {
            FileUtils.getFileName("")
        } catch(e: FSException) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
        
        flag = false
        try {
            FileUtils.getFileName(path + "/!@#$%^&^%&*()_+/*-~[];',.")
        } catch(e: FSException) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
        
        var fileName2 = FileUtils.getFileName(path + "/test_中文文件_04.md")
        @Expect(fileName2, "test_中文文件_04.md")
    }

    // getFileName 方法 path 超长字符串
    @TestCase
    public func zip_test_21():Unit{
        var tagString_a = StringBuilder('a', 2048).toString()
        flag = false
        try {
            FileUtils.getFileName(path + "/${tagString_a}")
        } catch(e: FSException) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
    }

    // readFile 方法 path 正常地址 ""地址 特殊符号 中文地址
    @TestCase
    public func zip_test_22():Unit{
        FileUtils.readFile(path + "/test_01.jpg")
        flag = false
        try {
            FileUtils.readFile("")
        } catch(e: IllegalArgumentException) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
        
        flag = false
        try {
            FileUtils.readFile("/!@#$%^&^%&*()_+/*-~[];',.")
        } catch(e: FSException) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
        FileUtils.readFile(path + "/test_中文文件_04.md")
    }

    // readFile 方法 path 超长字符串
    @TestCase
    public func zip_test_23():Unit{
        var tagString_a = StringBuilder('a', 2048).toString()
        flag = false
        try {
            FileUtils.readFile(path + "/${tagString_a}")
        } catch(e: FSException) {
            flag = true
            println(e.toString()) 
        }
        @Expect(flag)
    }

}