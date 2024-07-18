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
        @Assert(zipParameters.getFileComment() , None)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setFileComment("")
        @Assert(zipParameters.getFileComment().getOrThrow() , "")
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setFileComment("你好数字")
        @Assert(zipParameters.getFileComment().getOrThrow() , "你好数字")
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setFileComment("ipocazccbxzbcmk")
        @Assert(zipParameters.getFileComment().getOrThrow() , "ipocazccbxzbcmk")
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setFileComment("7889621202543.31")
        @Assert(zipParameters.getFileComment().getOrThrow() , "7889621202543.31")
    }

    @TestCase
    func ZipParameters06(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setFileComment("_++-/!@$#%%&^&*()_+")
        @Assert(zipParameters.getFileComment().getOrThrow() , "_++-/!@$#%%&^&*()_+")
    }

    @TestCase
    func ZipParameters07(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setFileComment("!$%$$$)_+你好，中国，9621202543.316！@")
        @Assert(zipParameters.getFileComment().getOrThrow() , "!$%$$$)_+你好，中国，9621202543.316！@")
    }
}