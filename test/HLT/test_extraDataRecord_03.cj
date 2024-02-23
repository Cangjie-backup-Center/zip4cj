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
        @Assert(extraDataRecord.getData(), None)
    }

    @TestCase
    func ExtraDataRecord02(): Unit {
        var extraDataRecord=ExtraDataRecord()
        extraDataRecord.setData(Array<Byte>())
        @Assert(extraDataRecord.getData().getOrThrow().size, 0)
    }

    @TestCase
    func ExtraDataRecord03(): Unit {
        var extraDataRecord=ExtraDataRecord()
        extraDataRecord.setData(Array<Byte>(196,item: 1))
        @Assert(extraDataRecord.getData().getOrThrow().size, 196)
    }

    @TestCase
    func ExtraDataRecord04(): Unit {
        var extraDataRecord=ExtraDataRecord()
        extraDataRecord.setData(Array<Byte>(19266,item: 1))
        @Assert(extraDataRecord.getData().getOrThrow().size, 19266)
    }

}