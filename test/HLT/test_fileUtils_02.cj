//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
// sources_file:a.txt
// sources_file:archive_with_invalid_zip64_headers.zip
// sources_file:jar-dir-lfh-and-fh-entry-size-2.jar
from std import collection.*
from std import fs.*
from std import io.*
from std import unittest.*
from std import math.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.encoding.*
from zip4cj import zip4cj.*
@Test
public class FileUtilsTest {
    @TestCase
    func FileUtils01(): Unit {
        FileUtils.setFileLastModifiedTime(Path("a.txt"),10)
        @Assert(FileUtils.getFileAttributes(Path("a.txt")).toString(), "[0, 0, 182, 129]")
    }

    @TestCase
    func FileUtils02(): Unit {
        FileUtils.setFileLastModifiedTimeWithoutNio(Path("a.txt"),10)
        @Assert(FileUtils.getFileAttributes(Path("@#￥@￥#451")).toString(), "[0, 0, 0, 0]")
    }

    @TestCase
    func FileUtils03(): Unit {
        let sc = FileUtils.getFilesInDirectoryRecursive(Path("a.txt"),ZipParameters())
        @Assert(sc.toString(), "[]")
    }

    @TestCase
    func FileUtils04(): Unit {
        let sc = FileUtils.getFilesInDirectoryRecursive(Path(""),ZipParameters())
        @Assert(sc.toString(), "[]")
    }

    @TestCase
    func FileUtils05(): Unit {
        let sc = FileUtils.getFilesInDirectoryRecursive(Path("你好呀"),ZipParameters())
        @Assert(sc.toString(), "[]")
    }
    
    @TestCase
    func FileUtils06(): Unit {
        let sc = FileUtils.getFilesInDirectoryRecursive(Path("@#@#$@#45465"),ZipParameters())
        @Assert(sc.toString(), "[]")
    }

    @TestCase
    func FileUtils07(): Unit {
        let sc = FileUtils.getFilesInDirectoryRecursive(Path("54645654"),ZipParameters())
        @Assert(sc.toString(), "[]")
    }
}