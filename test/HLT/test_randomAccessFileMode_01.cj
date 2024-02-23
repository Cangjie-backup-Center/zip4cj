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
public class RandomAccessFileModeTest {
    @TestCase
    func RandomAccessFileMode01(): Unit {
        var randomAccessFileMode=RandomAccessFileMode.READ
        @Assert(randomAccessFileMode.getValue(), "r")
    }

    @TestCase
    func RandomAccessFileMode02(): Unit {
        var randomAccessFileMode=RandomAccessFileMode.WRITE
        @Assert(randomAccessFileMode.getValue(), "rw")
    }
}