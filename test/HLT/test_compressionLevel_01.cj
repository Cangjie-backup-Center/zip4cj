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
public class CompressionLevelTest {
    @TestCase
    func CompressionLevel01(): Unit {
        var compressionLevel=CompressionLevel.NO_COMPRESSION
        @Assert(compressionLevel.getLevel(), 0)
    }

    @TestCase
    func CompressionLevel02(): Unit {
        var compressionLevel=CompressionLevel.FASTEST
        @Assert(compressionLevel.getLevel(), 1)
    }

    @TestCase
    func CompressionLevel03(): Unit {
        var compressionLevel=CompressionLevel.FASTER
        @Assert(compressionLevel.getLevel(), 2)
    }

    @TestCase
    func CompressionLevel04(): Unit {
        var compressionLevel=CompressionLevel.FAST
        @Assert(compressionLevel.getLevel(), 3)
    }

    @TestCase
    func CompressionLevel05(): Unit {
        var compressionLevel=CompressionLevel.MEDIUM_FAST
        @Assert(compressionLevel.getLevel(), 4)
    }

    @TestCase
    func CompressionLevel06(): Unit {
        var compressionLevel=CompressionLevel.NORMAL
        @Assert(compressionLevel.getLevel(), 5)
    }

    @TestCase
    func CompressionLevel07(): Unit {
        var compressionLevel=CompressionLevel.HIGHER
        @Assert(compressionLevel.getLevel(), 6)
    }

    @TestCase
    func CompressionLevel08(): Unit {
        var compressionLevel=CompressionLevel.MAXIMUM
        @Assert(compressionLevel.getLevel(), 7)
    }

     @TestCase
    func CompressionLevel09(): Unit {
        var compressionLevel=CompressionLevel.PRE_ULTRA
        @Assert(compressionLevel.getLevel(), 8)
    }

    @TestCase
    func CompressionLevel10(): Unit {
        var compressionLevel=CompressionLevel.ULTRA
        @Assert(compressionLevel.getLevel(), 9)
    }
}