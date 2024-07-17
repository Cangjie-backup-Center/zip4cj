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
        var zipParameters=ZipParameters()
        @Assert(zipParameters.getEncryptionMethod()==EncryptionMethod.NONE , true)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setEncryptionMethod(EncryptionMethod.ZIP_STANDARD)
        @Assert(zipParameters.getEncryptionMethod()==EncryptionMethod.ZIP_STANDARD , true)
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setEncryptionMethod(EncryptionMethod.ZIP_STANDARD_VARIANT_STRONG)
        @Assert(zipParameters.getEncryptionMethod()==EncryptionMethod.ZIP_STANDARD , false)
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setEncryptionMethod(EncryptionMethod.AES)
        @Assert(zipParameters.getEncryptionMethod()==EncryptionMethod.NONE , false)
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setEncryptionMethod(EncryptionMethod.ZIP_STANDARD)
        @Assert(zipParameters.getEncryptionMethod()==EncryptionMethod.ZIP_STANDARD , true)
    }
}