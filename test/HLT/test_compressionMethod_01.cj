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
public class CompressionMethodTest {
    @TestCase
    func CompressionMethod01(): Unit {
        var src = CompressionMethod.STORE
        @Assert(src.getCode(), 0)
    }

    @TestCase
    func CompressionMethod02(): Unit {
        var src = CompressionMethod.DEFLATE
        @Assert(src.getCode(), 8)
    }

    @TestCase
    func CompressionMethod03(): Unit {
        var src = CompressionMethod.AES_INTERNAL_ONLY
        @Assert(src.getCode(), 99)
    }

    @TestCase
    func CompressionMethod04(): Unit {
        var src = CompressionMethod.getCompressionMethodFromCode(0)
        @Assert(src.getCode(), 0)
    }

    @TestCase
    func CompressionMethod05(): Unit {
        var src = CompressionMethod.getCompressionMethodFromCode(8)
        @Assert(src.getCode(), 8)
    }

    @TestCase
    func CompressionMethod06(): Unit {
        var src = CompressionMethod.getCompressionMethodFromCode(99)
        @Assert(src.getCode(), 99)
    }

    @TestCase
    func CompressionMethod07(): Unit {
        try {
            CompressionMethod.getCompressionMethodFromCode(Int32.Max)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Unknown compression method")
        }
    }

    @TestCase
    func CompressionMethod08(): Unit {
        try {
            CompressionMethod.getCompressionMethodFromCode(Int32.Min)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Unknown compression method")
        }
    }

    @TestCase
    func CompressionMethod09(): Unit {
        var src = CompressionMethod.STORE
        var src1 = CompressionMethod.DEFLATE
        @Assert(src==src1, false)
    }

    @TestCase
    func CompressionMethod10(): Unit {
        var src = CompressionMethod.DEFLATE
        var src1 = CompressionMethod.AES_INTERNAL_ONLY
        @Assert(src==src1, false)
    }

    @TestCase
    func CompressionMethod11(): Unit {
        var src = CompressionMethod.AES_INTERNAL_ONLY
        var src1 = CompressionMethod.getCompressionMethodFromCode(99)
        @Assert(src==src1, true)
    }
}