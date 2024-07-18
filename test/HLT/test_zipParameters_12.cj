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
        @Assert(zipParameters.isWriteExtendedLocalFileHeader() , true)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setWriteExtendedLocalFileHeader(false)
        @Assert(zipParameters.isWriteExtendedLocalFileHeader() , false)
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters()
        @Assert(zipParameters.isOverrideExistingFilesInZip() , true)
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setOverrideExistingFilesInZip(true)
        @Assert(zipParameters.isOverrideExistingFilesInZip() , true)
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setOverrideExistingFilesInZip(false)
        @Assert(zipParameters.isOverrideExistingFilesInZip() , false)
    }
}