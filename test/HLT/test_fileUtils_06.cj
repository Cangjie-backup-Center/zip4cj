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
        let sc = FileUtils.isZipEntryDirectory("a.txt")
        @Assert(sc, false)
    }

    @TestCase
    func FileUtils02(): Unit {
        let sc = FileUtils.isZipEntryDirectory("archive_with_invalid_zip64_headers.zip")
        @Assert(sc, false)
    }

    @TestCase
    func FileUtils03(): Unit {
        let sc = FileUtils.isZipEntryDirectory("jar-dir-lfh-and-fh-entry-size-2.jar")
        @Assert(sc, false)
    }

    @TestCase
    func FileUtils04(): Unit {
        let sc = FileUtils.isZipEntryDirectory("")
        @Assert(sc, false)
    }

    @TestCase
    func FileUtils05(): Unit {
        let sc = FileUtils.isZipEntryDirectory("dsadsadsafsa")
        @Assert(sc, false)
    }
    
    @TestCase
    func FileUtils06(): Unit {
        let sc = FileUtils.isZipEntryDirectory("aa你好中国")
        @Assert(sc, false)
    }

    @TestCase
    func FileUtils07(): Unit {
        let sc = FileUtils.isZipEntryDirectory("！@#￥#￥%￥#￥%#9999")
        @Assert(sc, false)
    }

    @TestCase
    func FileUtils08(): Unit {
        var cwd_path: String = getcwd()
        let sc = FileUtils.isZipEntryDirectory(cwd_path)
        @Assert(sc, false)
    }
}