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
        try {
            src.writeLongLittleEndian(Array<Byte>(),0,0)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO02(): Unit {
        var src = RawIO()
        try {
            src.writeLongLittleEndian(Array<Byte>(),Int64.Max,0)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO03(): Unit {
        var src = RawIO()
        try {
            src.writeLongLittleEndian(Array<Byte>(),0,Int64.Max)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO04(): Unit {
        var src = RawIO()
        src.writeLongLittleEndian(Array<Byte>(1000,item: 0),15,0)
        try {
            src.writeLongLittleEndian(Array<Byte>(1000,item: 0),-15,0)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO05(): Unit {
        var src = RawIO()
        src.writeLongLittleEndian(Array<Byte>(1000,item: 0),15,Int64.Min)
        try {
            src.writeLongLittleEndian(Array<Byte>(1000,item: 0),Int64.Min,Int64.Min)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

}