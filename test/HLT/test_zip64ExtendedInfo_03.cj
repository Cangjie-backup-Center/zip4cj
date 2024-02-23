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
public class Zip64ExtendedInfoTest {
    @TestCase
    func Zip64ExtendedInfo01(): Unit {
        var zip64ExtendedInfo=Zip64ExtendedInfo()
        @Assert(zip64ExtendedInfo.getUncompressedSize(), -1)
    }

    @TestCase
    func Zip64ExtendedInfo02(): Unit {
        var zip64ExtendedInfo=Zip64ExtendedInfo()
        zip64ExtendedInfo.setUncompressedSize(0)
        @Assert(zip64ExtendedInfo.getUncompressedSize(), 0)
    }

    @TestCase
    func Zip64ExtendedInfo03(): Unit {
        var zip64ExtendedInfo=Zip64ExtendedInfo()
        zip64ExtendedInfo.setUncompressedSize(Int64.Min)
        @Assert(zip64ExtendedInfo.getUncompressedSize(), -9223372036854775808)
    }

    @TestCase
    func Zip64ExtendedInfo04(): Unit {
        var zip64ExtendedInfo=Zip64ExtendedInfo()
        zip64ExtendedInfo.setUncompressedSize(Int64.Max)
        @Assert(zip64ExtendedInfo.getUncompressedSize(), 9223372036854775807)
    }

    @TestCase
    func Zip64ExtendedInfo05(): Unit {
        var zip64ExtendedInfo=Zip64ExtendedInfo()
        zip64ExtendedInfo.setUncompressedSize(-150)
        @Assert(zip64ExtendedInfo.getUncompressedSize(), -150)
    }
}