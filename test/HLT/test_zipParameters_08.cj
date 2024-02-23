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
public class ZipParametersTest {
    @TestCase
    func ZipParameters01(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        @Assert(zipParameters.getDefaultFolderPath() , None)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setDefaultFolderPath("")
        @Assert(zipParameters.getDefaultFolderPath().getOrThrow() , "")
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setDefaultFolderPath("你好呀")
        @Assert(zipParameters.getDefaultFolderPath().getOrThrow() , "你好呀")
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setDefaultFolderPath("dsadsadpjk")
        @Assert(zipParameters.getDefaultFolderPath().getOrThrow() , "dsadsadpjk")
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setDefaultFolderPath("99451236456472005664656")
        @Assert(zipParameters.getDefaultFolderPath().getOrThrow() , "99451236456472005664656")
    }

    @TestCase
    func ZipParameters06(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setDefaultFolderPath("!@$#%%&^&*()_+")
        @Assert(zipParameters.getDefaultFolderPath().getOrThrow() , "!@$#%%&^&*()_+")
    }

    @TestCase
    func ZipParameters07(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setDefaultFolderPath("!@$#%%&^&*()_+你好，中国，799+6！@")
        @Assert(zipParameters.getDefaultFolderPath().getOrThrow() , "!@$#%%&^&*()_+你好，中国，799+6！@")
    }
}