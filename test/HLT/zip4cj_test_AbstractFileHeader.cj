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
public class AbstractFileHeaderTest {
    @TestCase
    func AbstractFileHeader01(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.getVersionNeededToExtract(),0)
        fileheader.setVersionNeededToExtract(0)
        @Assert(fileheader.getVersionNeededToExtract(),0)
        fileheader.setVersionNeededToExtract(2147483647)
        @Assert(fileheader.getVersionNeededToExtract(),2147483647)
        fileheader.setVersionNeededToExtract(-2147483648)
        @Assert(fileheader.getVersionNeededToExtract(),-2147483648)
    }

    @TestCase
    func AbstractFileHeader02(): Unit {
        var byte = Array<Byte>([99, 97, 110, 103, 106, 105, 101])
        var byte1 = Array<Byte>([])
        var fileheader = FileHeader()
        @Assert(fileheader.getGeneralPurposeFlag(),None)
        fileheader.setGeneralPurposeFlag(byte)
        @Assert(fileheader.getGeneralPurposeFlag(),Array<Byte>([99, 97, 110, 103, 106, 105, 101]))
        fileheader.setGeneralPurposeFlag(byte1)
        @Assert(fileheader.getGeneralPurposeFlag(),Array<Byte>([]))
    }

    @TestCase
    func AbstractFileHeader03(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.getCompressionMethod().isNone(),true)
        fileheader.setCompressionMethod(CompressionMethod.DEFLATE)
        @Assert(fileheader.getCompressionMethod().getOrThrow().getCode(),8)
    }

    @TestCase
    func AbstractFileHeader04(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.getLastModifiedTime(),0)
        fileheader.setLastModifiedTime(0)
        @Assert(fileheader.getLastModifiedTime(),0)
        fileheader.setLastModifiedTime(2147483647)
        @Assert(fileheader.getLastModifiedTime(),2147483647)
        fileheader.setLastModifiedTime(-2147483648)
        @Assert(fileheader.getLastModifiedTime(),-2147483648)
        @Assert(fileheader.getLastModifiedTimeEpoch(),-2147483648)
    }

    @TestCase
    func AbstractFileHeader05(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.getCrc(),0)
        fileheader.setCrc(0)
        @Assert(fileheader.getCrc(),0)
        fileheader.setCrc(9223372036854775807)
        @Assert(fileheader.getCrc(),9223372036854775807)
        fileheader.setCrc(-9223372036854775808)
        @Assert(fileheader.getCrc(),-9223372036854775808)
    }

    @TestCase
    func AbstractFileHeader06(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.getCompressedSize(),0)
        fileheader.setCompressedSize(0)
        @Assert(fileheader.getCompressedSize(),0)
        fileheader.setCompressedSize(9223372036854775807)
        @Assert(fileheader.getCompressedSize(),9223372036854775807)
        fileheader.setCompressedSize(-9223372036854775808)
        @Assert(fileheader.getCompressedSize(),-9223372036854775808)
    }

    @TestCase
    func AbstractFileHeader07(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.getUncompressedSize(),0)
        fileheader.setUncompressedSize(0)
        @Assert(fileheader.getUncompressedSize(),0)
        fileheader.setUncompressedSize(9223372036854775807)
        @Assert(fileheader.getUncompressedSize(),9223372036854775807)
        fileheader.setUncompressedSize(-9223372036854775808)
        @Assert(fileheader.getUncompressedSize(),-9223372036854775808)
    }

    @TestCase
    func AbstractFileHeader08(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.getFileNameLength(),0)
        fileheader.setFileNameLength(0)
        @Assert(fileheader.getFileNameLength(),0)
        fileheader.setFileNameLength(9223372036854775807)
        @Assert(fileheader.getFileNameLength(),9223372036854775807)
        fileheader.setFileNameLength(-9223372036854775808)
        @Assert(fileheader.getFileNameLength(),-9223372036854775808)
    }

    @TestCase
    func AbstractFileHeader09(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.getExtraFieldLength(),0)
        fileheader.setExtraFieldLength(0)
        @Assert(fileheader.getExtraFieldLength(),0)
        fileheader.setExtraFieldLength(2147483647)
        @Assert(fileheader.getExtraFieldLength(),2147483647)
        fileheader.setExtraFieldLength(-2147483648)
        @Assert(fileheader.getExtraFieldLength(),-2147483648)
    }

    @TestCase
    func EndOfCentralDirectoryRecord10(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.getFileName(),None)
        fileheader.setFileName("")
        @Assert(fileheader.getFileName(),"")
        fileheader.setFileName("cangejie")
        @Assert(fileheader.getFileName(),"cangejie")
        fileheader.setFileName("仓颉123")
        @Assert(fileheader.getFileName(),"仓颉123")
    }

    @TestCase
    func EndOfCentralDirectoryRecord11(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.isEncrypted(),false)
        fileheader.setEncrypted(true)
        @Assert(fileheader.isEncrypted(),true)
        fileheader.setEncrypted(false)
        @Assert(fileheader.isEncrypted(),false)
    }

    @TestCase
    func AbstractFileHeader012(): Unit {
        var fileheader = FileHeader()
        var method = fileheader.getEncryptionMethod()
        @Assert(method==(EncryptionMethod.AES),false)
        fileheader.setEncryptionMethod(EncryptionMethod.ZIP_STANDARD)
        var method1 = fileheader.getEncryptionMethod()
        @Assert(method1==(EncryptionMethod.ZIP_STANDARD),true)
    }

    @TestCase
    func EndOfCentralDirectoryRecord13(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.isDataDescriptorExists(),false)
        fileheader.setDataDescriptorExists(true)
        @Assert(fileheader.isDataDescriptorExists(),true)
        fileheader.setDataDescriptorExists(false)
        @Assert(fileheader.isDataDescriptorExists(),false)
    }

    @TestCase
    func AbstractFileHeader014(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.getZip64ExtendedInfo().isNone(),true)
        fileheader.setZip64ExtendedInfo(Zip64ExtendedInfo())
        @Assert(fileheader.getZip64ExtendedInfo().getOrThrow().getSize(),0)
    }

    @TestCase
    func AbstractFileHeader015(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.getAesExtraDataRecord().isNone(),true)
        fileheader.setAesExtraDataRecord(AESExtraDataRecord())
        @Assert(fileheader.getAesExtraDataRecord().getOrThrow().getDataSize(),7)
    }

    @TestCase
    func EndOfCentralDirectoryRecord16(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.isFileNameUTF8Encoded(),false)
        fileheader.setFileNameUTF8Encoded(true)
        @Assert(fileheader.isFileNameUTF8Encoded(),true)
        fileheader.setFileNameUTF8Encoded(false)
        @Assert(fileheader.isFileNameUTF8Encoded(),false)
    }

    @TestCase
    func AbstractFileHeader017(): Unit {
        var fileheader = FileHeader()
        var record = ExtraDataRecord()
        var data = ArrayList<ExtraDataRecord>([record, record, record])
        @Assert(fileheader.getExtraDataRecords().isNone(),true)
        fileheader.setExtraDataRecords(data)
        @Assert(fileheader.getExtraDataRecords().getOrThrow().size,3)
    }

    @TestCase
    func EndOfCentralDirectoryRecord18(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.isDirectory(),false)
        fileheader.setDirectory(true)
        @Assert(fileheader.isDirectory(),true)
        fileheader.setDirectory(false)
        @Assert(fileheader.isDirectory(),false)
    }

    @TestCase
    func AbstractFileHeader019(): Unit {
        var fileheader = FileHeader()
        @Assert(fileheader.equals(FileHeader()),false)
        @Assert(fileheader==(FileHeader()),false)
        @Assert(fileheader!=(FileHeader()),true)
    }
}
