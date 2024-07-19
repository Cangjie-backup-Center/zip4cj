//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*
import charset4cj.charset.*
import charset4cj.charset.encoding.*
import  zip4cj.*

@Test
public class FileHeaderFactoryTest {
    @TestCase
    func FileHeader01(): Unit {
        var fileheader = FileHeader()
        var madeby = fileheader.getVersionMadeBy()
        @Assert(madeby,0)
        fileheader.setVersionMadeBy(2147483647)
        @Assert(fileheader.getVersionMadeBy(),2147483647)
        fileheader.setVersionMadeBy(-2147483648)
        @Assert(fileheader.getVersionMadeBy(),-2147483648)
        fileheader.setVersionMadeBy(0)
        @Assert(fileheader.getVersionMadeBy(),0)
    }

    @TestCase
    func FileHeader02(): Unit {
        var fileheader = FileHeader()
        var madeby = fileheader.getFileCommentLength()
        @Assert(madeby,0)
        fileheader.setFileCommentLength(2147483647)
        @Assert(fileheader.getFileCommentLength(),2147483647)
        fileheader.setFileCommentLength(-2147483648)
        @Assert(fileheader.getFileCommentLength(),-2147483648)
        fileheader.setFileCommentLength(0)
        @Assert(fileheader.getFileCommentLength(),0)
    }

    @TestCase
    func FileHeader03(): Unit {
        var fileheader = FileHeader()
        var madeby = fileheader.getDiskNumberStart()
        @Assert(madeby,0)
        fileheader.setDiskNumberStart(9223372036854775807)
        @Assert(fileheader.getDiskNumberStart(),9223372036854775807)
        fileheader.setDiskNumberStart(-9223372036854775808)
        @Assert(fileheader.getDiskNumberStart(),-9223372036854775808)
        fileheader.setDiskNumberStart(0)
        @Assert(fileheader.getDiskNumberStart(),0)
    }

    @TestCase
    func FileHeader04(): Unit {
        var byte = Array<Byte>([99, 97, 110, 103, 106, 105, 101])
        var byte1 = Array<Byte>([])
        var fileheader = FileHeader()
        var madeby = fileheader.getInternalFileAttributes()
        @Assert(madeby.isNone(),true)
        fileheader.setInternalFileAttributes(byte)
        @Assert(fileheader.getInternalFileAttributes(),byte)
        fileheader.setInternalFileAttributes(byte1)
        @Assert(fileheader.getInternalFileAttributes(),byte1)
    }

    @TestCase
    func FileHeader05(): Unit {
        var fileheader = FileHeader()
        var madeby = fileheader.getOffsetLocalHeader()
        @Assert(madeby,0)
        fileheader.setOffsetLocalHeader(9223372036854775807)
        @Assert(fileheader.getOffsetLocalHeader(),9223372036854775807)
        fileheader.setOffsetLocalHeader(-9223372036854775808)
        @Assert(fileheader.getOffsetLocalHeader(),-9223372036854775808)
        fileheader.setOffsetLocalHeader(0)
        @Assert(fileheader.getOffsetLocalHeader(),0)
    }

    @TestCase
    func FileHeader06(): Unit {
        var fileheader = FileHeader()
        var madeby = fileheader.getFileComment()
        @Assert(madeby.isNone(),true)
        fileheader.setFileComment("")
        @Assert(fileheader.getFileComment(),"")
        fileheader.setFileComment("cangejie")
        @Assert(fileheader.getFileComment(),"cangejie")
        fileheader.setFileComment("仓颉123")
        @Assert(fileheader.getFileComment(),"仓颉123")
    }

    @TestCase
    func FileHeader07(): Unit {
        var fileheader = FileHeader()
        var madeby = fileheader.toString()
        @Assert(madeby,"None")
    }

    @TestCase
    func FileHeader08(): Unit {
        var fileheader = FileHeader()
        var fileheader1 = FileHeader()
        @Assert(fileheader==(fileheader),true)
        @Assert(fileheader!=(fileheader1),true)
    }

    @TestCase
    func FileHeader09(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.equals(fileheader),true)
        @Assert(fileheader.hashCode(),961)
    }
}
