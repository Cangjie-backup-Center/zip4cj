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
public class EncryptionMethodTest {
    @TestCase
    func EncryptionMethod01(): Unit {
        var encryptionMethod=EncryptionMethod.NONE
        var encryptionMethod1=EncryptionMethod.ZIP_STANDARD
        @Assert(encryptionMethod==encryptionMethod1, false)
    }

    @TestCase
    func EncryptionMethod02(): Unit {
        var encryptionMethod=EncryptionMethod.ZIP_STANDARD_VARIANT_STRONG
        var encryptionMethod1=EncryptionMethod.AES
        @Assert(encryptionMethod==encryptionMethod1, false)
    }

    @TestCase
    func EncryptionMethod03(): Unit {
        var encryptionMethod=EncryptionMethod.ZIP_STANDARD_VARIANT_STRONG
        var encryptionMethod1=EncryptionMethod.ZIP_STANDARD_VARIANT_STRONG
        @Assert(encryptionMethod==encryptionMethod1, true)
    }
}