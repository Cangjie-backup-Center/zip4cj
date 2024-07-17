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
public class AESExtraDataRecordTest {
    @TestCase
    func AESExtraDataRecord01(): Unit {
        var aesextra = AESExtraDataRecord()
        @Assert(aesextra.getDataSize(),7)
        aesextra.setDataSize(-9223372036854775808)
        @Assert(aesextra.getDataSize(),-9223372036854775808)
        aesextra.setDataSize(9223372036854775807)
        @Assert(aesextra.getDataSize(),9223372036854775807)
    }

    @TestCase
    func AESExtraDataRecord02(): Unit {
        var aesextra = AESExtraDataRecord()
        @Assert(aesextra.getAesVersion().getVersionNumber(),2)
        aesextra.setAesVersion(AesVersion.getFromVersionNumber(2))
        @Assert(aesextra.getAesVersion().getVersionNumber(),2)
    }

    @TestCase
    func AESExtraDataRecord03(): Unit {
        var aesextra = AESExtraDataRecord()
        aesextra.setAesVersion(AesVersion.getFromVersionNumber(1))
        @Assert(aesextra.getAesVersion().getVersionNumber(),1)
    }

    @TestCase
    func AESExtraDataRecord04(): Unit {
        var aesextra = AESExtraDataRecord()
        @Assert(aesextra.getVendorID(),"AE")
        aesextra.setVendorID("cangjie")
        @Assert(aesextra.getVendorID(),"cangjie")
    }

    @TestCase
    func AESExtraDataRecord05(): Unit {
        var aesextra = AESExtraDataRecord()
        @Assert(aesextra.getVendorID(),"AE")
        aesextra.setVendorID("仓颉")
        @Assert(aesextra.getVendorID(),"仓颉")
    }

    @TestCase
    func AESExtraDataRecord06(): Unit {
        var aesextra = AESExtraDataRecord()
        @Assert(aesextra.getVendorID(),"AE")
        aesextra.setVendorID("仓颉cangjie%……&")
        @Assert(aesextra.getVendorID(),"仓颉cangjie%……&")
    }

    @TestCase
    func AESExtraDataRecord07(): Unit {
        var aesextra = AESExtraDataRecord()
        @Assert(aesextra.getAesKeyStrength().getRawCode(),3)
        aesextra.setAesKeyStrength(AESExtraDataRecord().getAesKeyStrength())
        @Assert(aesextra.getAesKeyStrength().getRawCode(),3)
    }

    @TestCase
    func AESExtraDataRecord08(): Unit {
        var aesextra = AESExtraDataRecord()
        @Assert(aesextra.getCompressionMethod().getCode(),8)
        aesextra.setCompressionMethod(CompressionMethod.DEFLATE)
        @Assert(aesextra.getCompressionMethod().getCode(),8)
    }
}
