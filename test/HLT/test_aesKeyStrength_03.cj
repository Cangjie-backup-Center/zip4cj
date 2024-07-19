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
        var aesKeyStrength=AesKeyStrength.getAesKeyStrengthFromRawCode(1)
        @Assert(aesKeyStrength.getOrThrow().getRawCode(), 1)
    }

    @TestCase
    func AesKeyStrength02(): Unit {
        var aesKeyStrength=AesKeyStrength.getAesKeyStrengthFromRawCode(2)
        @Assert(aesKeyStrength.getOrThrow().getRawCode(), 2)
    }

    @TestCase
    func AesKeyStrength03(): Unit {
        var aesKeyStrength=AesKeyStrength.getAesKeyStrengthFromRawCode(3)
        @Assert(aesKeyStrength.getOrThrow().getRawCode(), 3)
    }
    
    @TestCase
    func AesKeyStrength04(): Unit {
        try {
            AesKeyStrength.getAesKeyStrengthFromRawCode(0).getOrThrow()
        } catch (e: NoneValueException) {
            @Assert(e.toString() , "NoneValueException")
        }
    }

    @TestCase
    func AesKeyStrength05(): Unit {
        try {
            AesKeyStrength.getAesKeyStrengthFromRawCode(Int32.Max).getOrThrow()
        } catch (e: NoneValueException) {
            @Assert(e.toString() , "NoneValueException")
        }
    }

    @TestCase
    func AesKeyStrength09(): Unit {
        try {
            AesKeyStrength.getAesKeyStrengthFromRawCode(Int32.Min).getOrThrow()
        } catch (e: NoneValueException) {
            @Assert(e.toString() , "NoneValueException")
        }
    }
}