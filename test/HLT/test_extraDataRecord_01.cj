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
public class ExtraDataRecordTest {
    @TestCase
    func ExtraDataRecord01(): Unit {
        var extraDataRecord=ExtraDataRecord()
        @Assert(extraDataRecord.getHeader(), 0)
    }

    @TestCase
    func ExtraDataRecord02(): Unit {
        var extraDataRecord=ExtraDataRecord()
        extraDataRecord.setHeader(-166)
        @Assert(extraDataRecord.getHeader(), -166)
    }

    @TestCase
    func ExtraDataRecord03(): Unit {
        var extraDataRecord=ExtraDataRecord()
        extraDataRecord.setHeader(998)
        @Assert(extraDataRecord.getHeader(), 998)
    }

    @TestCase
    func ExtraDataRecord04(): Unit {
        var extraDataRecord=ExtraDataRecord()
        extraDataRecord.setHeader(Int64.Max)
        @Assert(extraDataRecord.getHeader(), 9223372036854775807)
    }

    @TestCase
    func ExtraDataRecord05(): Unit {
        var extraDataRecord=ExtraDataRecord()
        extraDataRecord.setHeader(Int64.Min)
        @Assert(extraDataRecord.getHeader(), -9223372036854775808)
    }
}