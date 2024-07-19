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
public class ZipParametersTest {
    @TestCase
    func ZipParameters01(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setCompressionLevel(CompressionLevel.MEDIUM_FAST)
        @Assert(zipParameters.getCompressionLevel().getLevel() , 4)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setCompressionLevel(CompressionLevel.HIGHER)
        @Assert(zipParameters.getCompressionLevel().getLevel() , 6)
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setCompressionLevel(CompressionLevel.MAXIMUM)
        @Assert(zipParameters.getCompressionLevel().getLevel() , 7)
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setCompressionLevel(CompressionLevel.PRE_ULTRA)
        @Assert(zipParameters.getCompressionLevel().getLevel() , 8)
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setCompressionLevel(CompressionLevel.ULTRA)
        @Assert(zipParameters.getCompressionLevel().getLevel() , 9)
    }
}