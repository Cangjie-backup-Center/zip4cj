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
        @Assert(zipParameters.getFileNameInZip() , None)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setFileNameInZip("")
        @Assert(zipParameters.getFileNameInZip().getOrThrow() , "")
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setFileNameInZip("中文，你好呀")
        @Assert(zipParameters.getFileNameInZip().getOrThrow() , "中文，你好呀")
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setFileNameInZip("qcvxdsadsadpjk")
        @Assert(zipParameters.getFileNameInZip().getOrThrow() , "qcvxdsadsadpjk")
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setFileNameInZip("3300999451236456472005664656")
        @Assert(zipParameters.getFileNameInZip().getOrThrow() , "3300999451236456472005664656")
    }

    @TestCase
    func ZipParameters06(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setFileNameInZip("&&*!@$#%%&^&*()_+")
        @Assert(zipParameters.getFileNameInZip().getOrThrow() , "&&*!@$#%%&^&*()_+")
    }

    @TestCase
    func ZipParameters07(): Unit {
        var zipParameters=ZipParameters(ZipParameters())
        zipParameters.setFileNameInZip("&&*!@$#%%&^&*()_+中国，799+6！@")
        @Assert(zipParameters.getFileNameInZip().getOrThrow() , "&&*!@$#%%&^&*()_+中国，799+6！@")
    }
}