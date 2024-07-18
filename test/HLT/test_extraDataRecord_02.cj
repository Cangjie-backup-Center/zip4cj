//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.math.*
import std.unittest.testmacro.*
import  charset.*
import  charset.encoding.*
import  zip4cj.*
@Test
public class ExtraDataRecordTest {
    @TestCase
    func ExtraDataRecord01(): Unit {
        var extraDataRecord=ExtraDataRecord()
        @Assert(extraDataRecord.getSizeOfData(), 0)
    }

    @TestCase
    func ExtraDataRecord02(): Unit {
        var extraDataRecord=ExtraDataRecord()
        extraDataRecord.setSizeOfData(-196)
        @Assert(extraDataRecord.getSizeOfData(), -196)
    }

    @TestCase
    func ExtraDataRecord03(): Unit {
        var extraDataRecord=ExtraDataRecord()
        extraDataRecord.setSizeOfData(15)
        @Assert(extraDataRecord.getSizeOfData(), 15)
    }

    @TestCase
    func ExtraDataRecord04(): Unit {
        var extraDataRecord=ExtraDataRecord()
        extraDataRecord.setSizeOfData(Int64.Max)
        @Assert(extraDataRecord.getSizeOfData(), 9223372036854775807)
    }

    @TestCase
    func ExtraDataRecord05(): Unit {
        var extraDataRecord=ExtraDataRecord()
        extraDataRecord.setSizeOfData(Int64.Min)
        @Assert(extraDataRecord.getSizeOfData(), -9223372036854775808)
    }
}