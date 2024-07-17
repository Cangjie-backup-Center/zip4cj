//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*
import  charset.*
import  charset.encoding.*
import  zip4cj.*

@Test
public class HeaderUtilTest {
    @TestCase
    func HeaderUtil01(): Unit {
        var zipmodel = ZipModel()
        @Assert(HeaderUtil.getFileHeader(zipmodel,"cangjie").isNone(),true)
    }

    @TestCase
    func HeaderUtil02(): Unit {
        var zipmodel = ZipModel().clone()
        @Assert(HeaderUtil.getFileHeader(zipmodel,"cangjie").isNone(),true)
    }

    @TestCase
    func HeaderUtil03(): Unit {
        var zipmodel = ZipModel()
        @Assert(HeaderUtil.getFileHeader(zipmodel,"123").isNone(),true)
    }

    @TestCase
    func HeaderUtil04(): Unit {
        var zipmodel = ZipModel()
        @Assert(HeaderUtil.getFileHeader(zipmodel,"123*&^").isNone(),true)
    }

    @TestCase
    func HeaderUtil05(): Unit {
        var byte = Array<Byte>(1024, item: 0)
        var byte1 = Array<Byte>([99, 97, 110, 103, 106, 105, 101])
        HeaderUtil.decodeStringWithCharset(byte, true, Charsets.UTF8)
        @Assert(HeaderUtil.getBytesFromString("cangjie",Charsets.UTF8),byte1)
    }

    @TestCase
    func HeaderUtil06(): Unit {
        var a = 0
        var byte = Array<Byte>([])
        try {
            HeaderUtil.decodeStringWithCharset(byte, true, Charsets.UTF8)
        } catch (e: Exception) {
            a++
        }
        @Assert(a,0)
    }

    @TestCase
    func HeaderUtil07(): Unit {
        var byte1 = Array<Byte>([49, 50, 51])
        @Assert(HeaderUtil.getBytesFromString("123",Charsets.UTF8),byte1)
    }

    @TestCase
    func HeaderUtil08(): Unit {
        var byte1 = Array<Byte>([228, 187, 147, 233, 162, 137])
        @Assert(HeaderUtil.getBytesFromString("仓颉",Charsets.UTF8),byte1)
    }

    @TestCase
    func HeaderUtil09(): Unit {
        var byte1 = Array<Byte>(
            [228, 187, 147, 233, 162, 137, 99, 97, 110, 103, 106, 105, 101, 49, 50, 51, 239, 191, 165, 37, 226, 128,
        166, 226, 128, 166, 38, 35])
        @Assert(HeaderUtil.getBytesFromString("仓颉cangjie123￥%……&#",Charsets.UTF8),byte1)
    }

    @TestCase
    func HeaderUtil10(): Unit {
        var zipmodel = ZipModel().clone()
        @Assert(HeaderUtil.getOffsetStartOfCentralDirectory(zipmodel),0)
    }

    @TestCase
    func HeaderUtil11(): Unit {
        var zipmodel = ZipModel()
        @Assert(HeaderUtil.getOffsetStartOfCentralDirectory(zipmodel),0)
    }

    @TestCase
    func HeaderUtil12(): Unit {
        var fileHeader = FileHeader()
        var fileheaderlist = ArrayList<FileHeader>([fileHeader, fileHeader, fileHeader, fileHeader, fileHeader,
        fileHeader])
        try {
            HeaderUtil.getFileHeadersUnderDirectory(fileheaderlist, "cangjie")
        } catch (e: NoneValueException) {
            @Assert(e.toString(),"NoneValueException: FileHeader.getFileName() is null.")
        }
    }

    @TestCase
    func HeaderUtil15(): Unit {
        var fileheaderlist = ArrayList<FileHeader>([])
        var fileheadersunderdirectory = HeaderUtil.getFileHeadersUnderDirectory(fileheaderlist, "cangjie")
        @Assert(HeaderUtil.getTotalUncompressedSizeOfAllFileHeaders(fileheadersunderdirectory),0)
    }

    @TestCase
    func HeaderUtil16(): Unit {
        var fileheaderlist = ArrayList<FileHeader>([])
        var fileheadersunderdirectory = HeaderUtil.getFileHeadersUnderDirectory(fileheaderlist, "123333")
        @Assert(HeaderUtil.getTotalUncompressedSizeOfAllFileHeaders(fileheadersunderdirectory),0)
    }

    @TestCase
    func HeaderUtil17(): Unit {
        var fileheaderlist = ArrayList<FileHeader>([])
        var fileheadersunderdirectory = HeaderUtil.getFileHeadersUnderDirectory(fileheaderlist, "")
        @Assert(HeaderUtil.getTotalUncompressedSizeOfAllFileHeaders(fileheadersunderdirectory),0)
    }
}
