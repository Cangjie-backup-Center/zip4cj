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
public class Zip64ExtendedInfoTest {
    @TestCase
    func Zip64ExtendedInfo01(): Unit {
        var zip64ExtendedInfo=Zip64ExtendedInfo()
        @Assert(zip64ExtendedInfo.getDiskNumberStart(), -1)
    }

    @TestCase
    func Zip64ExtendedInfo02(): Unit {
        var zip64ExtendedInfo=Zip64ExtendedInfo()
        zip64ExtendedInfo.setDiskNumberStart(0)
        @Assert(zip64ExtendedInfo.getDiskNumberStart(), 0)
    }

    @TestCase
    func Zip64ExtendedInfo03(): Unit {
        var zip64ExtendedInfo=Zip64ExtendedInfo()
        zip64ExtendedInfo.setDiskNumberStart(Int32.Min)
        @Assert(zip64ExtendedInfo.getDiskNumberStart(), -2147483648)
    }

    @TestCase
    func Zip64ExtendedInfo04(): Unit {
        var zip64ExtendedInfo=Zip64ExtendedInfo()
        zip64ExtendedInfo.setDiskNumberStart(Int32.Max)
        @Assert(zip64ExtendedInfo.getDiskNumberStart(), 2147483647)
    }

    @TestCase
    func Zip64ExtendedInfo05(): Unit {
        var zip64ExtendedInfo=Zip64ExtendedInfo()
        zip64ExtendedInfo.setDiskNumberStart(-596)
        @Assert(zip64ExtendedInfo.getDiskNumberStart(), -596)
    }

    @TestCase
    func Zip64ExtendedInfo06(): Unit {
        var zip64ExtendedInfo=Zip64ExtendedInfo()
        var zip64ExtendedInfo1=Zip64ExtendedInfo()
        zip64ExtendedInfo.setDiskNumberStart(-596)
        @Assert(zip64ExtendedInfo==zip64ExtendedInfo1, false)
        @Assert(zip64ExtendedInfo!=zip64ExtendedInfo1, true)
    }

}