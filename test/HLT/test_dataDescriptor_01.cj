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
        @Assert(dataDescriptor.getCrc(), 0)
    }

    @TestCase
    func DataDescriptor02(): Unit {
        var dataDescriptor=DataDescriptor()
        dataDescriptor.setCrc(100)
        @Assert(dataDescriptor.getCrc(), 100)
    }

    @TestCase
    func DataDescriptor03(): Unit {
        var dataDescriptor=DataDescriptor()
        dataDescriptor.setCrc(-10)
        @Assert(dataDescriptor.getCrc(), -10)
    }

    @TestCase
    func DataDescriptor04(): Unit {
        var dataDescriptor=DataDescriptor()
        dataDescriptor.setCrc(Int64.Max)
        @Assert(dataDescriptor.getCrc(), 9223372036854775807)
    }

    @TestCase
    func DataDescriptor05(): Unit {
        var dataDescriptor=DataDescriptor()
        dataDescriptor.setCrc(Int64.Min) 
        @Assert(dataDescriptor.getCrc(), -9223372036854775808)
    }
}