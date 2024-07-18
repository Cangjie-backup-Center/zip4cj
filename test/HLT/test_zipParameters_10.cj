//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.math.*
import std.unittest.testmacro.*
import  charset.*
import  charset.encoding.*
import  zip4cj.*
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