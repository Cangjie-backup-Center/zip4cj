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
        @Assert(aesKeyStrength.getRawCode(), 1)
    }

    @TestCase
    func AesKeyStrength02(): Unit {
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_192
        @Assert(aesKeyStrength.getRawCode(), 2)
    }

    @TestCase
    func AesKeyStrength03(): Unit {
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_256
        @Assert(aesKeyStrength.getRawCode(), 3)
    }

    @TestCase
    func AesKeyStrength04(): Unit {
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_128
        @Assert(aesKeyStrength.getSaltLength(), 8)
    }

    @TestCase
    func AesKeyStrength05(): Unit {
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_192
        @Assert(aesKeyStrength.getSaltLength(), 12)
    }

    @TestCase
    func AesKeyStrength06(): Unit {
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_256
        @Assert(aesKeyStrength.getSaltLength(), 16)
    }
}