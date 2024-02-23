//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
from std import collection.*
from std import fs.*
from std import io.*
from std import unittest.*
from std import math.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.encoding.*
from zip4cj import zip4cj.*
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