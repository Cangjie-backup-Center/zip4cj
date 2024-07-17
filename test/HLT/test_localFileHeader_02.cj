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
public class LocalFileHeaderTest {
    @TestCase
    func LocalFileHeader01(): Unit {
        var localFileHeader=LocalFileHeader()
        @Assert(localFileHeader.getOffsetStartOfData(), 0)
    }

    @TestCase
    func LocalFileHeader02(): Unit {
        var localFileHeader=LocalFileHeader()
        localFileHeader.setOffsetStartOfData(10)
        @Assert(localFileHeader.getOffsetStartOfData(), 10)
    }

    @TestCase
    func LocalFileHeader03(): Unit {
        var localFileHeader=LocalFileHeader()
        localFileHeader.setOffsetStartOfData(-15)
        @Assert(localFileHeader.getOffsetStartOfData(), -15)
    }

    @TestCase
    func LocalFileHeader04(): Unit {
        var localFileHeader=LocalFileHeader()
        localFileHeader.setOffsetStartOfData(Int64.Max)
        @Assert(localFileHeader.getOffsetStartOfData(), 9223372036854775807)
    }

    @TestCase
    func LocalFileHeader05(): Unit {
        var localFileHeader=LocalFileHeader()
        localFileHeader.setOffsetStartOfData(Int64.Min)
        @Assert(localFileHeader.getOffsetStartOfData(), -9223372036854775808)
    }

    @TestCase
    func LocalFileHeader06(): Unit {
        var localFileHeader=LocalFileHeader()
        @Assert(localFileHeader.isWriteCompressedSizeInZip64ExtraRecord(), false)
    }

    @TestCase
    func LocalFileHeader07(): Unit {
        var localFileHeader=LocalFileHeader()
        localFileHeader.setWriteCompressedSizeInZip64ExtraRecord(true)
        @Assert(localFileHeader.isWriteCompressedSizeInZip64ExtraRecord(), true)
    }

    @TestCase
    func LocalFileHeader08(): Unit {
        var localFileHeader=LocalFileHeader()
        localFileHeader.setWriteCompressedSizeInZip64ExtraRecord(false)
        @Assert(localFileHeader.isWriteCompressedSizeInZip64ExtraRecord(), false)
    }
}