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
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_128
        @Assert(aesKeyStrength.getMacLength(), 16)
    }

    @TestCase
    func AesKeyStrength02(): Unit {
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_192
        @Assert(aesKeyStrength.getMacLength(), 24)
    }

    @TestCase
    func AesKeyStrength03(): Unit {
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_256
        @Assert(aesKeyStrength.getMacLength(), 32)
    }

    @TestCase
    func AesKeyStrength04(): Unit {
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_128
        @Assert(aesKeyStrength.getKeyLength(), 16)
    }

    @TestCase
    func AesKeyStrength05(): Unit {
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_192
        @Assert(aesKeyStrength.getKeyLength(), 24)
    }

    @TestCase
    func AesKeyStrength06(): Unit {
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_256
        @Assert(aesKeyStrength.getKeyLength(), 32)
    }

    @TestCase
    func AesKeyStrength07(): Unit {
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_192
        var aesKeyStrength1=AesKeyStrength.KEY_STRENGTH_192
        @Assert(aesKeyStrength==aesKeyStrength1, true)
    }

    @TestCase
    func AesKeyStrength08(): Unit {
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_128
        var aesKeyStrength1=AesKeyStrength.KEY_STRENGTH_256
        @Assert(aesKeyStrength==aesKeyStrength1, false)
    }
}