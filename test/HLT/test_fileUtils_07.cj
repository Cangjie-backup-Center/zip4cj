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
from std import os.posix.*
from charset import charset.*
from charset import charset.encoding.*
from zip4cj import zip4cj.*
@Test
public class FileUtilsTest {
    @TestCase
    func FileUtils01(): Unit {
        var file = RandomAccessFile(File("a.txt", OpenOption.Open(true, false)))
        var pro = ProgressMonitor()
        pro.setCancelAllTasks(true)
        FileUtils.copyFile(file,ByteArrayStream(),0,2,pro,2)
        let sc = FileUtils.isNumberedSplitFile(Path("a.txt"))
        @Assert(sc, false)
    }

    @TestCase
    func FileUtils02(): Unit {
        var file = RandomAccessFile(File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false)))
        var pro = ProgressMonitor()
        pro.setCancelAllTasks(true)
        var returnTag = 0
        try {
            FileUtils.copyFile(file,File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)),0,2,pro,2)
        } catch (e: FSException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }

    @TestCase
    func FileUtils03(): Unit {
        var file = RandomAccessFile(File("a.txt", OpenOption.Open(true, false)))
        var pro = ProgressMonitor()
        pro.setCancelAllTasks(true)
        FileUtils.copyFile(file,ByteArrayStream(),0,2,pro,2)
        let sc = FileUtils.isNumberedSplitFile(Path("123.txt"))
        @Assert(sc, false)
    }

    @TestCase
    func FileUtils04(): Unit {
        var file = RandomAccessFile(File("a.txt", OpenOption.Open(true, false)))
        var pro = ProgressMonitor()
        pro.setCancelAllTasks(true)
        var returnTag = 0
        try {
            FileUtils.copyFile(file,ByteArrayStream(),Int64.Max,2,pro,2)
        } catch (e: ZipException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }

    @TestCase
    func FileUtils05(): Unit {
        var file = RandomAccessFile(File("a.txt", OpenOption.Open(true, false)))
        var pro = ProgressMonitor()
        pro.setCancelAllTasks(true)
        var returnTag = 0
        try {
            FileUtils.copyFile(file,ByteArrayStream(),Int64.Max,Int64.Min,pro,2)
        } catch (e: ZipException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }
    
    @TestCase
    func FileUtils06(): Unit {
        var file = RandomAccessFile(File("a.txt", OpenOption.Open(true, false)))
        var pro = ProgressMonitor()
        pro.setCancelAllTasks(true)
        FileUtils.copyFile(file,ByteArrayStream(),0,Int64.Max,pro,2)
        let sc = FileUtils.isNumberedSplitFile(Path("123.txt"))
        @Assert(sc, false)
    }

    @TestCase
    func FileUtils07(): Unit {
        var file = RandomAccessFile(File("a.txt", OpenOption.Open(true, false)))
        var pro = ProgressMonitor()
        pro.setCancelAllTasks(true)
        FileUtils.copyFile(file,ByteArrayStream(),0,Int64.Max,pro,0)
        let sc = FileUtils.isNumberedSplitFile(Path("123.txt"))
        @Assert(sc, false)
    }

    @TestCase
    func FileUtils08(): Unit {
        var file = RandomAccessFile(File("a.txt", OpenOption.Open(true, false)))
        var pro = ProgressMonitor()
        pro.setCancelAllTasks(true)
        var returnTag = 0
        try {
            FileUtils.copyFile(file,ByteArrayStream(),0,Int64.Max,pro,Int64.Max)
        } catch (e: OutOfMemoryError) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }
}