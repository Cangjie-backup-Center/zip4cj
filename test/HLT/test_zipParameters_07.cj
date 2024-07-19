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
public class ZipParametersTest {
    @TestCase
    func ZipParameters01(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        @Assert(zipParameters.isIncludeRootFolder() , true)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setIncludeRootFolder(false)
        @Assert(zipParameters.isIncludeRootFolder() , false)
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        @Assert(zipParameters.getEntryCRC() , 0)
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setEntryCRC(Int64.Max)
        @Assert(zipParameters.getEntryCRC() , 9223372036854775807)
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setEntryCRC(Int64.Min)
        @Assert(zipParameters.getEntryCRC() , -9223372036854775808)
    }

    @TestCase
    func ZipParameters06(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setEntryCRC(15)
        @Assert(zipParameters.getEntryCRC() , 15)
    }
}