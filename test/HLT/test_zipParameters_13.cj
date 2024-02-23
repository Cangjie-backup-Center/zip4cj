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
        @Assert(zipParameters.getRootFolderNameInZip() , None)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setRootFolderNameInZip("")
        @Assert(zipParameters.getRootFolderNameInZip().getOrThrow() , "")
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setRootFolderNameInZip("你好呀数字")
        @Assert(zipParameters.getRootFolderNameInZip().getOrThrow() , "你好呀数字")
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setRootFolderNameInZip("qqqdsadsadpjk")
        @Assert(zipParameters.getRootFolderNameInZip().getOrThrow() , "qqqdsadsadpjk")
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setRootFolderNameInZip("9621202543.31")
        @Assert(zipParameters.getRootFolderNameInZip().getOrThrow() , "9621202543.31")
    }

    @TestCase
    func ZipParameters06(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setRootFolderNameInZip("_++-/!@$#%%&^&*()_+")
        @Assert(zipParameters.getRootFolderNameInZip().getOrThrow() , "_++-/!@$#%%&^&*()_+")
    }

    @TestCase
    func ZipParameters07(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setRootFolderNameInZip("!@$#%%&^&*()_+你好，中国，9621202543.316！@")
        @Assert(zipParameters.getRootFolderNameInZip().getOrThrow() , "!@$#%%&^&*()_+你好，中国，9621202543.316！@")
    }
}