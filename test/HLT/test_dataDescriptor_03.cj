//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.math.*
import std.unittest.testmacro.*
import charset4cj.charset.*
import charset4cj.charset.encoding.*
import  zip4cj.*
@Test
public class DataDescriptorTest {
    @TestCase
    func DataDescriptor01(): Unit {
        var dataDescriptor=DataDescriptor()
        @Assert(dataDescriptor.getUncompressedSize(), 0)
    }

    @TestCase
    func DataDescriptor02(): Unit {
        var dataDescriptor=DataDescriptor()
        dataDescriptor.setUncompressedSize(158)
        @Assert(dataDescriptor.getUncompressedSize(), 158)
    }

    @TestCase
    func DataDescriptor03(): Unit {
        var dataDescriptor=DataDescriptor()
        dataDescriptor.setUncompressedSize(-763)
        @Assert(dataDescriptor.getUncompressedSize(), -763)
    }

    @TestCase
    func DataDescriptor04(): Unit {
        var dataDescriptor=DataDescriptor()
        dataDescriptor.setUncompressedSize(Int64.Max)
        @Assert(dataDescriptor.getUncompressedSize(), 9223372036854775807)
    }

    @TestCase
    func DataDescriptor05(): Unit {
        var dataDescriptor=DataDescriptor()
        dataDescriptor.setUncompressedSize(Int64.Min) 
        @Assert(dataDescriptor.getUncompressedSize(), -9223372036854775808)
    }
}