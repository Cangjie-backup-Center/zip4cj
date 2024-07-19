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
        var zipParameters=ZipParameters()
        @Assert(zipParameters.getCompressionMethod().getCode() , 8)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        @Assert(zipParameters.getCompressionMethod().getCode() , 0)
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setCompressionMethod(CompressionMethod.AES_INTERNAL_ONLY)
        @Assert(zipParameters.getCompressionMethod().getCode() , 99)
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters()
        @Assert(zipParameters.isEncryptFiles() , false)
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setEncryptFiles(true)
        @Assert(zipParameters.isEncryptFiles() , true)
    }
}