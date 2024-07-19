//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.math.*
import std.unittest.testmacro.*
import charset4cj.charset.*
import charset4cj.charset.encoding.*
import  zip4cj.*
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