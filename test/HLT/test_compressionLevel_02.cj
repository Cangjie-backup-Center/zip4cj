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
public class CompressionLevelTest {
    @TestCase
    func CompressionLevel01(): Unit {
        var compressionLevel=CompressionLevel.NO_COMPRESSION
        var compressionLevel1=CompressionLevel.FASTEST
        @Assert(compressionLevel==compressionLevel1, false)
    }

    @TestCase
    func CompressionLevel02(): Unit {
        var compressionLevel=CompressionLevel.FASTER
        var compressionLevel1=CompressionLevel.FASTER
        @Assert(compressionLevel==compressionLevel1, true)
    }

    @TestCase
    func CompressionLevel03(): Unit {
        var compressionLevel=CompressionLevel.PRE_ULTRA
        var compressionLevel1=CompressionLevel.NORMAL
        @Assert(compressionLevel==compressionLevel1, false)
    }
}