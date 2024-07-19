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
        @Assert(archiveExtraDataRecord.getExtraFieldData(), None)
    }

    @TestCase
    func ArchiveExtraDataRecord02(): Unit {
        var archiveExtraDataRecord=ArchiveExtraDataRecord()
        archiveExtraDataRecord.setExtraFieldData("")
        @Assert(archiveExtraDataRecord.getExtraFieldData().getOrThrow(), "")
    }

    @TestCase
    func ArchiveExtraDataRecord03(): Unit {
        var archiveExtraDataRecord=ArchiveExtraDataRecord()
        archiveExtraDataRecord.setExtraFieldData("9665645.36")
        @Assert(archiveExtraDataRecord.getExtraFieldData().getOrThrow(), "9665645.36")
    }

    @TestCase
    func ArchiveExtraDataRecord04(): Unit {
        var archiveExtraDataRecord=ArchiveExtraDataRecord()
        archiveExtraDataRecord.setExtraFieldData("dsadpoioiewqnv")
        @Assert(archiveExtraDataRecord.getExtraFieldData().getOrThrow(), "dsadpoioiewqnv")
    }

    @TestCase
    func ArchiveExtraDataRecord05(): Unit {
        var archiveExtraDataRecord=ArchiveExtraDataRecord()
        archiveExtraDataRecord.setExtraFieldData("你好")
        @Assert(archiveExtraDataRecord.getExtraFieldData().getOrThrow(),"你好")
    }

    @TestCase
    func ArchiveExtraDataRecord06(): Unit {
        var archiveExtraDataRecord=ArchiveExtraDataRecord()
        archiveExtraDataRecord.setExtraFieldData("@#￥%@%￥#%￥##")
        @Assert(archiveExtraDataRecord.getExtraFieldData().getOrThrow(),"@#￥%@%￥#%￥##")
    }
}