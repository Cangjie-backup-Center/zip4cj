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

@Test
public class CentralDirectoryTest {
    @TestCase
    func CentralDirectory01(): Unit {
        var fileheader = FileHeader()
        var data = ArrayList<FileHeader>([fileheader, fileheader, fileheader])
        var central = CentralDirectory()
        @Assert(central.getFileHeaders().size,0)
        central.setFileHeaders(data)
        @Assert(central.getFileHeaders().size,3)
    }

    @TestCase
    func CentralDirectory02(): Unit {
        var data = ArrayList<FileHeader>()
        var central = CentralDirectory()
        @Assert(central.getFileHeaders().size,0)
        central.setFileHeaders(data)
        @Assert(central.getFileHeaders().size,0)
    }

    @TestCase
    func CentralDirectory03(): Unit {
        var signature = DigitalSignature()
        var central = CentralDirectory()
        @Assert(central.getDigitalSignature().getSizeOfData(),0)
        central.setDigitalSignature(signature)
        @Assert(central.getDigitalSignature().getSizeOfData(),0)
    }

    @TestCase
    func HeaderSignature01(): Unit {
        var headersignature = HeaderSignature.EXTRA_DATA_RECORD
        var headersignature1 = HeaderSignature.TEMPORARY_SPANNING_MARKER
        @Assert(headersignature==(headersignature1),false)
        @Assert(headersignature==(HeaderSignature.EXTRA_DATA_RECORD),true)
    }

    @TestCase
    func HeaderSignature02(): Unit {
        var headersignature = HeaderSignature.EXTRA_DATA_RECORD
        var headersignature1 = HeaderSignature.TEMPORARY_SPANNING_MARKER
        @Assert(headersignature!=(headersignature1),true)
        @Assert(HeaderSignature.EXTRA_DATA_RECORD!=(HeaderSignature.EXTRA_DATA_RECORD),false)
    }

    @TestCase
    func HeaderSignature03(): Unit {
        @Assert(HeaderSignature.values().size,12)
        @Assert(HeaderSignature.ZIP64_END_CENTRAL_DIRECTORY_LOCATOR.getValue(),117853008)
        @Assert(HeaderSignature.AES_EXTRA_DATA_RECORD.getValue(),39169)
        @Assert(HeaderSignature.ZIP64_EXTRA_FIELD_SIGNATURE.getValue(),1)
        @Assert(HeaderSignature.SPLIT_ZIP.getValue(),134695760)
    }

    @TestCase
    func HeaderSignature04(): Unit {
        @Assert(HeaderSignature.values().size,12)
        @Assert(HeaderSignature.DIGITAL_SIGNATURE.getValue(),84233040)
        @Assert(HeaderSignature.END_OF_CENTRAL_DIRECTORY.getValue(),101010256)
        @Assert(HeaderSignature.EXTRA_DATA_RECORD.getValue(),134695760)
        @Assert(HeaderSignature.DIGITAL_SIGNATURE.getValue(),84233040)
    }
}
