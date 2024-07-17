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
public class AesVersionTest {
    @TestCase
    func AesVersion01(): Unit {
        var aesVersion=AesVersion.ONE
        @Assert(aesVersion.getVersionNumber(), 1)
    }

    @TestCase
    func AesVersion02(): Unit {
        var aesVersion=AesVersion.TWO
        @Assert(aesVersion.getVersionNumber(), 2)
    }

    @TestCase
    func AesVersion03(): Unit {
        var aesVersion=AesVersion.getFromVersionNumber(1)
        @Assert(aesVersion.getVersionNumber(), 1)
    }

    @TestCase
    func AesVersion04(): Unit {
        var aesVersion=AesVersion.getFromVersionNumber(2)
        @Assert(aesVersion.getVersionNumber(), 2)
    }

    @TestCase
    func AesVersion05(): Unit {
        try {
            AesVersion.getFromVersionNumber(Int32.Max)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Unsupported Aes version")
        }
    }

    @TestCase
    func AesVersion06(): Unit {
        try {
            AesVersion.getFromVersionNumber(Int32.Min)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Unsupported Aes version")
        }
    }

    @TestCase
    func AesVersion07(): Unit {
        try {
            AesVersion.getFromVersionNumber(0)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Unsupported Aes version")
        }
    }

    @TestCase
    func AesVersion08(): Unit {
        var aesVersion=AesVersion.getFromVersionNumber(2)
        var aesVersion1=AesVersion.TWO
        @Assert(aesVersion==aesVersion1, true)
    }

    @TestCase
    func AesVersion09(): Unit {
        var aesVersion=AesVersion.getFromVersionNumber(1)
        var aesVersion1=AesVersion.TWO
        @Assert(aesVersion==aesVersion1, false)
    }
}