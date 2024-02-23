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
        var returnTag = 0
        try {
            AesKeyStrength.getAesKeyStrengthFromRawCode(0).getOrThrow()
        } catch (e: NoneValueException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }

    @TestCase
    func AesKeyStrength05(): Unit {
        var returnTag = 0
        try {
            AesKeyStrength.getAesKeyStrengthFromRawCode(Int32.Max).getOrThrow()
        } catch (e: NoneValueException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }

    @TestCase
    func AesKeyStrength09(): Unit {
        var returnTag = 0
        try {
            AesKeyStrength.getAesKeyStrengthFromRawCode(Int32.Min).getOrThrow()
        } catch (e: NoneValueException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }
}