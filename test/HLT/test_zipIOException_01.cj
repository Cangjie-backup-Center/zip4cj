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
public class AesKeyStrengthTest {
    @TestCase
    func AesKeyStrength01(): Unit {
        var zipIOException=ZipIOException("")
        @Assert(zipIOException.toString(), "ZipIOException")
    }

    @TestCase
    func AesKeyStrength02(): Unit {
        var zipIOException=ZipIOException("nihao中国")
        @Assert(zipIOException.toString(), "ZipIOException: nihao中国")
    }

    @TestCase
    func AesKeyStrength03(): Unit {
        var zipIOException=ZipIOException("27404242")
        @Assert(zipIOException.toString(), "ZipIOException: 27404242")
    }

    @TestCase
    func AesKeyStrength04(): Unit {
        var zipIOException=ZipIOException("dsadp[drwdvbn，jh")
        @Assert(zipIOException.toString(), "ZipIOException: dsadp[drwdvbn，jh")
    }

    @TestCase
    func AesKeyStrength05(): Unit {
        var zipIOException=ZipIOException("@$%^&*()dsadp[drwdvbn，jh")
        @Assert(zipIOException.toString(), "ZipIOException: @$%^&*()dsadp[drwdvbn，jh")
    }

    @TestCase
    func AesKeyStrength06(): Unit {
        var zipIOException=UnsupportedOperationException()
        @Assert(zipIOException.toString(), "UnsupportedOperationException")
    }
}