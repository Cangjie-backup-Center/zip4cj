//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
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
public class LocalFileHeaderTest {
    @TestCase
    func LocalFileHeader01(): Unit {
        var localFileHeader=LocalFileHeader()
        @Assert(localFileHeader.getExtraField(), None)
    }

    @TestCase
    func LocalFileHeader02(): Unit {
        var localFileHeader=LocalFileHeader()
        localFileHeader.setExtraField(Array<Byte>())
        @Assert(localFileHeader.getExtraField().getOrThrow().size, 0)
    }

    @TestCase
    func LocalFileHeader03(): Unit {
        var localFileHeader=LocalFileHeader()
        localFileHeader.setExtraField(Array<Byte>(10,item:1))
        @Assert(localFileHeader.getExtraField().getOrThrow().size, 10)
    }

    @TestCase
    func LocalFileHeader04(): Unit {
        var localFileHeader=LocalFileHeader()
        try {
            localFileHeader.setExtraField(Array<Byte>(Int64.Max,item:1))
        } catch (e: OutOfMemoryError) {
            @Assert(e.toString() , "OutOfMemoryError")
        }
    }

    @TestCase
    func LocalFileHeader05(): Unit {
        var localFileHeader=LocalFileHeader()
        localFileHeader.setExtraField(Array<Byte>(10086,item:1))
        @Assert(localFileHeader.getExtraField().getOrThrow().size, 10086)
    }
}