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
        var file = File("a.txt", OpenOption.Open(true, false))
        try {
            src.readLongLittleEndian(file)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Could not fill buffer")
        }
    }

    @TestCase
    func RawIO02(): Unit {
        var src = RawIO()
        var file = File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false))
        let sc = src.readLongLittleEndian(file)
        @Assert(sc, 576460795320421200)
    }

    @TestCase
    func RawIO03(): Unit {
        var src = RawIO()
        var file = File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false))
        let sc = src.readLongLittleEndian(file)
        @Assert(sc, 576460795320421200)
    }

    @TestCase
    func RawIO04(): Unit {
        var src = RawIO()
        try {
            src.readLongLittleEndian(ByteArrayStream())
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Could not fill buffer")
        }
    }

    @TestCase
    func RawIO05(): Unit {
        var src = RawIO()
        var file = File("a.txt", OpenOption.Open(true, false))
        let sc = src.readLongLittleEndian(file,0)
        @Assert(sc , 0)
    }

    @TestCase
    func RawIO06(): Unit {
        var src = RawIO()
        var file = File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false))
        try {
            src.readLongLittleEndian(file,15)
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString() , "IllegalArgumentException: Length greater than buffer size")
        }
    }

    @TestCase
    func RawIO07(): Unit {
        var src = RawIO()
        var file = File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false))
        try {
            src.readLongLittleEndian(file,Int64.Min)
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString() , "IllegalArgumentException: Negative length")
        }
    }

    @TestCase
    func RawIO08(): Unit {
        var src = RawIO()
        try {
            src.readLongLittleEndian(ByteArrayStream(),Int64.Max)
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString() , "IllegalArgumentException: Length greater than buffer size")
        }
    }
}