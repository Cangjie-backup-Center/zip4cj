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
public class ArchiveExtraDataRecordTest {
    @TestCase
    func ArchiveExtraDataRecord01(): Unit {
        var archiveExtraDataRecord=ArchiveExtraDataRecord()
        @Assert(archiveExtraDataRecord.getExtraFieldLength(), 0)
    }

    @TestCase
    func ArchiveExtraDataRecord02(): Unit {
        var archiveExtraDataRecord=ArchiveExtraDataRecord()
        archiveExtraDataRecord.setExtraFieldLength(1)
        @Assert(archiveExtraDataRecord.getExtraFieldLength(), 1)
    }

    @TestCase
    func ArchiveExtraDataRecord03(): Unit {
        var archiveExtraDataRecord=ArchiveExtraDataRecord()
        archiveExtraDataRecord.setExtraFieldLength(-15)
        @Assert(archiveExtraDataRecord.getExtraFieldLength(), -15)
    }

    @TestCase
    func ArchiveExtraDataRecord04(): Unit {
        var archiveExtraDataRecord=ArchiveExtraDataRecord()
        archiveExtraDataRecord.setExtraFieldLength(Int32.Max)
        @Assert(archiveExtraDataRecord.getExtraFieldLength(), 2147483647)
    }

    @TestCase
    func ArchiveExtraDataRecord05(): Unit {
        var archiveExtraDataRecord=ArchiveExtraDataRecord()
        archiveExtraDataRecord.setExtraFieldLength(Int32.Min)
        @Assert(archiveExtraDataRecord.getExtraFieldLength(), -2147483648)
    }
}