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
public class ZipParametersTest {
    @TestCase
    func ZipParameters01(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        @Assert(zipParameters.getLastModifiedFileTime() , 0)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setLastModifiedFileTime(-11)
        @Assert(zipParameters.getLastModifiedFileTime() , 0)
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setLastModifiedFileTime(Int64.Max)
        @Assert(zipParameters.getLastModifiedFileTime() , 9223372036854775807)
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setLastModifiedFileTime(Int64.Min)
        @Assert(zipParameters.getLastModifiedFileTime() , 0)
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setLastModifiedFileTime(996)
        @Assert(zipParameters.getLastModifiedFileTime() , 996)
    }
}