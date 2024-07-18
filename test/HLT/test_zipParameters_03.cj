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
public class ZipParametersTest {
    @TestCase
    func ZipParameters01(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        @Assert(zipParameters.getCompressionLevel().getLevel() , 5)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setCompressionLevel(CompressionLevel.NO_COMPRESSION)
        @Assert(zipParameters.getCompressionLevel().getLevel() , 0)
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setCompressionLevel(CompressionLevel.FASTEST)
        @Assert(zipParameters.getCompressionLevel().getLevel() , 1)
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setCompressionLevel(CompressionLevel.FASTER)
        @Assert(zipParameters.getCompressionLevel().getLevel() , 2)
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setCompressionLevel(CompressionLevel.FAST)
        @Assert(zipParameters.getCompressionLevel().getLevel() , 3)
    }
}