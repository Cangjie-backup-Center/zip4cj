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
public class DataDescriptorTest {
    @TestCase
    func DataDescriptor01(): Unit {
        var dataDescriptor=DataDescriptor()
        @Assert(dataDescriptor.getCompressedSize(), 0)
    }

    @TestCase
    func DataDescriptor02(): Unit {
        var dataDescriptor=DataDescriptor()
        dataDescriptor.setCompressedSize(996)
        @Assert(dataDescriptor.getCompressedSize(), 996)
    }

    @TestCase
    func DataDescriptor03(): Unit {
        var dataDescriptor=DataDescriptor()
        dataDescriptor.setCompressedSize(-106)
        @Assert(dataDescriptor.getCompressedSize(), -106)
    }

    @TestCase
    func DataDescriptor04(): Unit {
        var dataDescriptor=DataDescriptor()
        dataDescriptor.setCompressedSize(Int64.Max)
        @Assert(dataDescriptor.getCompressedSize(), 9223372036854775807)
    }

    @TestCase
    func DataDescriptor05(): Unit {
        var dataDescriptor=DataDescriptor()
        dataDescriptor.setCompressedSize(Int64.Min) 
        @Assert(dataDescriptor.getCompressedSize(), -9223372036854775808)
    }
}