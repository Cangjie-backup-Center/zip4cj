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
        @Assert(zipParameters.getEntrySize() , -1)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setEntrySize(-110)
        @Assert(zipParameters.getEntrySize() , -110)
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setEntrySize(Int64.Max)
        @Assert(zipParameters.getEntrySize() , 9223372036854775807)
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setEntrySize(Int64.Min)
        @Assert(zipParameters.getEntrySize() , -9223372036854775808)
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setEntrySize(258)
        @Assert(zipParameters.getEntrySize() , 258)
    }
}