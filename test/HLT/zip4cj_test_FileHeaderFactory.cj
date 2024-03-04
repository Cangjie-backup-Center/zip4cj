//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
from std import collection.*
from std import fs.*
from std import io.*
from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.encoding.*
from zip4cj import zip4cj.*

@Test
public class FileHeaderFactoryTest {
    @TestCase
    func FileHeaderFactory01(): Unit {
        var zipparameters = ZipParameters()
        var rawio = RawIO()
        var fileheaderfactory = FileHeaderFactory()
        try {
            fileheaderfactory.generateFileHeader(zipparameters, true, 0, Charsets.UTF8, rawio)
        } catch (e: Exception) {
            @Assert(e.toString(),"ZipException: fileNameInZip is null or empty")
        }
    }

    @TestCase
    func FileHeaderFactory02(): Unit {
        var zipparameters = ZipParameters()
        var rawio = RawIO()
        var fileheaderfactory = FileHeaderFactory()
        try {
            fileheaderfactory.generateFileHeader(zipparameters, false, 9223372036854775807, Charsets.UTF8, rawio)
        } catch (e: Exception) {
            @Assert(e.toString(),"ZipException: fileNameInZip is null or empty")
        }
    }

    @TestCase
    func FileHeaderFactory03(): Unit {
        var zipparameters = ZipParameters()
        var rawio = RawIO()
        var fileheaderfactory = FileHeaderFactory()
        try {
            fileheaderfactory.generateFileHeader(zipparameters, false, -9223372036854775808, Charsets.UTF8, rawio)
        } catch (e: Exception) {
            @Assert(e.toString(),"ZipException: fileNameInZip is null or empty")
        }
    }

    @TestCase
    func FileHeaderFactory04(): Unit {
        var fileheader = FileHeader()
        var fileheaderfactory = FileHeaderFactory()
        try {
            fileheaderfactory.generateLocalFileHeader(fileheader)
        } catch (e: Exception) {
            @Assert(e.toString(),"NoneValueException: FileHeader.getGeneralPurposeFlag() is null")
        }
    }

    @TestCase
    func ProgressMonitorState01(): Unit {
        var progress = ProgressMonitorState.READY
        var progress1 = ProgressMonitorState.BUSY
        @Assert(progress==(progress1),false)
        @Assert(progress==(progress),true)
    }
}
