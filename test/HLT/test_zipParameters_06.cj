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
        @Assert(zipParameters.getAesKeyStrength().getKeyLength() , 32)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setAesKeyStrength(AesKeyStrength.KEY_STRENGTH_128)
        @Assert(zipParameters.getAesKeyStrength().getKeyLength() , 16)
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setAesKeyStrength(AesKeyStrength.KEY_STRENGTH_192)
        @Assert(zipParameters.getAesKeyStrength().getKeyLength() , 24)
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        @Assert(zipParameters.getAesVersion().getVersionNumber() , 2)
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setAesVersion(AesVersion.ONE)
        @Assert(zipParameters.getAesVersion().getVersionNumber() , 1)
    }
}