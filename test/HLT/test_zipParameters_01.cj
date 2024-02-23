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
        var zipParameters=ZipParameters()
        @Assert(zipParameters.getCompressionMethod().getCode() , 8)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        @Assert(zipParameters.getCompressionMethod().getCode() , 0)
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setCompressionMethod(CompressionMethod.AES_INTERNAL_ONLY)
        @Assert(zipParameters.getCompressionMethod().getCode() , 99)
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters()
        @Assert(zipParameters.isEncryptFiles() , false)
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setEncryptFiles(true)
        @Assert(zipParameters.isEncryptFiles() , true)
    }
}