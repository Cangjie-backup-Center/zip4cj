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
        FileUtils.setFileAttributes(Path("a.txt"),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("a.txt")).toString(), "[0, 0, 182, 129]")
    }

    @TestCase
    func FileUtils02(): Unit {
        FileUtils.setFileAttributes(Path(""),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("")).toString(), "[0, 0, 0, 0]")
    }

    @TestCase
    func FileUtils03(): Unit {
        FileUtils.setFileAttributes(Path(""),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("")).toString(), "[0, 0, 0, 0]")
    }

    @TestCase
    func FileUtils04(): Unit {
        FileUtils.setFileAttributes(Path("中国"),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("中国")).toString(), "[0, 0, 0, 0]")
    }

    @TestCase
    func FileUtils05(): Unit {
        FileUtils.setFileAttributes(Path("1231232"),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("1231232")).toString(), "[0, 0, 0, 0]")
    }

    @TestCase
    func FileUtils06(): Unit {
        FileUtils.setFileAttributes(Path("@#￥@￥#451"),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("@#￥@￥#451")).toString(), "[0, 0, 0, 0]")
    }

    @TestCase
    func FileUtils07(): Unit {
        FileUtils.setFileAttributes(Path("archive_with_invalid_zip64_headers.zip"),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("archive_with_invalid_zip64_headers.zip")).toString(), "[0, 0, 182, 129]")
    }

    @TestCase
    func FileUtils08(): Unit {
        FileUtils.setFileAttributes(Path("jar-dir-lfh-and-fh-entry-size-2.jar"),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("jar-dir-lfh-and-fh-entry-size-2.jar")).toString(), "[0, 0, 182, 129]")
    }

    @TestCase
    func FileUtils09(): Unit {
        try {
            FileUtils.setFileAttributes(Path("中国"),Array<Byte>(Int64.Max, item: 1))
        } catch (e: OutOfMemoryError) {
            @Assert(e.toString() , "OutOfMemoryError")
        }
    }
}