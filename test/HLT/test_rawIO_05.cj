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
public class RawIOTest {
    @TestCase
    func RawIO01(): Unit {
        var src = RawIO()
        var returnTag = 0
        try {
            src.readIntLittleEndian(Array<Byte>(),0)
        } catch (e: IndexOutOfBoundsException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }

    @TestCase
    func RawIO02(): Unit {
        var src = RawIO()
        var file = File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false)).readToEnd()
        var returnTag = 0
        try {
            src.readIntLittleEndian(file,Int64.Max)
        } catch (e: IndexOutOfBoundsException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }

    @TestCase
    func RawIO03(): Unit {
        var src = RawIO()
        var file = File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)).readToEnd()
        var returnTag = 0
        try {
            src.readIntLittleEndian(file,Int64.Min)
        } catch (e: IndexOutOfBoundsException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }

    @TestCase
    func RawIO04(): Unit {
        var src = RawIO()
        var file = RandomAccessFile(File("a.txt", OpenOption.Open(true, false)))
        let sc = src.readShortLittleEndian(file)
        @Assert(sc, 49)
    }

    @TestCase
    func RawIO05(): Unit {
        var src = RawIO()
        var file = RandomAccessFile(File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false)))
        let sc = src.readShortLittleEndian(file)
        @Assert(sc, 19280)
    }

    @TestCase
    func RawIO06(): Unit {
        var src = RawIO()
        var file = RandomAccessFile(File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)))
        let sc = src.readShortLittleEndian(file)
        @Assert(sc, 19280)
    }
}