//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*
import  charset.*
import  charset.encoding.*
import  zip4cj.*

//sources_file:sample.pdf:after_deflate_remaining_bytes.bin:sample_text_large.txt:가나다.abc:jar-dir-lfh-and-fh-entry-size-2.jar:MobaXterm.2024-01-03_11.24.ini
//sources_file:libssl.so.3:picture.webp:öüäöäö.rar:1COMM_v24tagswithalbumimage1.mp3

@Test
public class ZipModelTest {
    @TestCase
    func ZipModel01(): Unit {
        var zipmodel = ZipModel()
        var signature = zipmodel.getLocalFileHeaders()
        @Assert(signature.size,0)
        var localfileheader = LocalFileHeader()
        var data = ArrayList<LocalFileHeader>([localfileheader, localfileheader, localfileheader])
        zipmodel.setLocalFileHeaders(data)
        @Assert(zipmodel.getLocalFileHeaders().size,3)
    }

    @TestCase
    func ZipModel02(): Unit {
        var zipmodel = ZipModel()
        var data = ArrayList<LocalFileHeader>()
        zipmodel.setLocalFileHeaders(data)
        @Assert(zipmodel.getLocalFileHeaders().size,0)
    }

    @TestCase
    func ZipModel03(): Unit {
        var zipmodel = ZipModel()
        var signature = zipmodel.getDataDescriptors()
        @Assert(signature.size,0)
        var datadescriptor = DataDescriptor()
        var data = ArrayList<DataDescriptor>([datadescriptor, datadescriptor, datadescriptor])
        zipmodel.setDataDescriptors(data)
        @Assert(zipmodel.getDataDescriptors().size,3)
    }

    @TestCase
    func ZipModel04(): Unit {
        var zipmodel = ZipModel()
        var data = ArrayList<DataDescriptor>()
        zipmodel.setDataDescriptors(data)
        @Assert(zipmodel.getDataDescriptors().size,0)
    }

    @TestCase
    func ZipModel05(): Unit {
        var zipmodel = ZipModel()
        var signature = zipmodel.getCentralDirectory().getOrThrow()
        @Assert(signature.getDigitalSignature().getSizeOfData(),0)
        var centraldirectory = CentralDirectory()
        zipmodel.setCentralDirectory(centraldirectory)
        @Assert(zipmodel.getCentralDirectory().getOrThrow().getDigitalSignature().getSizeOfData(),0)
    }

    @TestCase
    func ZipModel06(): Unit {
        var zipmodel = ZipModel()
        var signature = zipmodel.getEndOfCentralDirectoryRecord()
        @Assert(signature.getNumberOfThisDisk(),0)
        var endofcentraldirectoryrecord = EndOfCentralDirectoryRecord()
        zipmodel.setEndOfCentralDirectoryRecord(endofcentraldirectoryrecord)
        @Assert(zipmodel.getEndOfCentralDirectoryRecord().getNumberOfThisDisk(),0)
    }

    @TestCase
    func ZipModel07(): Unit {
        var zipmodel = ZipModel()
        var signature = zipmodel.getArchiveExtraDataRecord()
        @Assert(signature.getExtraFieldLength(),0)
        var archiveextra = ArchiveExtraDataRecord()
        zipmodel.setArchiveExtraDataRecord(archiveextra)
        @Assert(zipmodel.getArchiveExtraDataRecord().getExtraFieldLength(),0)
    }

    @TestCase
    func ZipModel08(): Unit {
        var zipmodel = ZipModel()
        var signature = zipmodel.isSplitArchive()
        @Assert(signature,false)
        zipmodel.setSplitArchive(true)
        @Assert(zipmodel.isSplitArchive(),true)
    }

    @TestCase
    func ZipModel09(): Unit {
        var zipmodel = ZipModel()
        var zipfile = zipmodel.getZipFile()
        @Assert(zipfile.toString(),"None")
    }

    @TestCase
    func ZipModel10(): Unit {
        var zipmodel = ZipModel()
        zipmodel.setZipFile(Path("sample.pdf"))
        @Assert(zipmodel.getZipFile().getOrThrow().toString(),"sample.pdf")
        zipmodel.setZipFile(Path("sam1312pl11e.pdf"))
        @Assert(zipmodel.getZipFile().getOrThrow().toString(),"sam1312pl11e.pdf")
        zipmodel.setZipFile(Path("cangjie"))
        @Assert(zipmodel.getZipFile().getOrThrow().toString(),"cangjie")
    }

    @TestCase
    func ZipModel11(): Unit {
        var zipmodel = ZipModel()
        var signature = zipmodel.getZip64EndOfCentralDirectoryLocator()
        @Assert(signature.isNone(),false)
        zipmodel.setZip64EndOfCentralDirectoryLocator(Zip64EndOfCentralDirectoryLocator())
        @Assert(zipmodel.getZip64EndOfCentralDirectoryLocator().getOrThrow().getNumberOfDiskStartOfZip64EndOfCentralDirectoryRecord(),0)
    }

    @TestCase
    func ZipModel12(): Unit {
        var zipmodel = ZipModel()
        var signature = zipmodel.getZip64EndOfCentralDirectoryRecord()
        @Assert(signature.getSizeOfZip64EndCentralDirectoryRecord(),0)
        zipmodel.setZip64EndOfCentralDirectoryRecord(Zip64EndOfCentralDirectoryRecord())
        @Assert(zipmodel.getZip64EndOfCentralDirectoryRecord().getSizeOfZip64EndCentralDirectoryRecord(),0)
    }

    @TestCase
    func ZipModel13(): Unit {
        var zipmodel = ZipModel()
        var signature = zipmodel.isZip64Format()
        @Assert(signature,false)
        zipmodel.setZip64Format(true)
        @Assert(zipmodel.isZip64Format(),true)
        zipmodel.setZip64Format(false)
        @Assert(zipmodel.isZip64Format(),false)
    }

    @TestCase
    func ZipModel14(): Unit {
        var zipmodel = ZipModel()
        var signature = zipmodel.isNestedZipFile()
        @Assert(signature,false)
        zipmodel.setNestedZipFile(true)
        @Assert(zipmodel.isNestedZipFile(),true)
        zipmodel.setNestedZipFile(false)
        @Assert(zipmodel.isNestedZipFile(),false)
    }

    @TestCase
    func ZipModel15(): Unit {
        var zipmodel = ZipModel()
        @Assert(zipmodel.getStart(),0)
        zipmodel.setStart(-9223372036854775808)
        @Assert(zipmodel.getStart(),-9223372036854775808)
        zipmodel.setStart(9223372036854775807)
        @Assert(zipmodel.getStart(),9223372036854775807)
    }

    @TestCase
    func ZipModel16(): Unit {
        var zipmodel = ZipModel()
        @Assert(zipmodel.getEnd(),0)
        zipmodel.setEnd(-9223372036854775808)
        @Assert(zipmodel.getEnd(),-9223372036854775808)
        zipmodel.setEnd(9223372036854775807)
        @Assert(zipmodel.getEnd(),9223372036854775807)
    }

    @TestCase
    func ZipModel17(): Unit {
        var zipmodel = ZipModel()
        @Assert(zipmodel.getSplitLength(),-1)
        zipmodel.setSplitLength(-9223372036854775808)
        @Assert(zipmodel.getSplitLength(),-9223372036854775808)
        zipmodel.setSplitLength(9223372036854775807)
        @Assert(zipmodel.getSplitLength(),9223372036854775807)
        @Assert(zipmodel.clone().getSplitLength(),9223372036854775807)
    }
}
