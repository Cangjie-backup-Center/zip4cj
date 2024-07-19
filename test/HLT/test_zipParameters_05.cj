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
        @Assert(zipParameters.isReadHiddenFiles() , true)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setReadHiddenFiles(false)
        @Assert(zipParameters.isReadHiddenFiles() , false)
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        @Assert(zipParameters.isReadHiddenFolders() , true)
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setReadHiddenFolders(false)
        @Assert(zipParameters.isReadHiddenFolders() , false)
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setReadHiddenFolders(true)
        @Assert(zipParameters.isReadHiddenFolders() , true)
    }
}