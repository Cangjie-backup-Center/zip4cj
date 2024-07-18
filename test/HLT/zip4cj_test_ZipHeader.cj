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
public class ZipHeaderTest {
    @TestCase
    func BitUtils01(): Unit {
        var endof = EndOfCentralDirectoryRecord()
        var signature = endof.getSignature()
        @Assert(signature.isNone(),false)
        @Assert(signature.getOrThrow().getValue(),101010256)
    }

    @TestCase
    func BitUtils02(): Unit {
        var endof = EndOfCentralDirectoryRecord()
        endof.setSignature(HeaderSignature.LOCAL_FILE_HEADER)
        var signature = endof.getSignature()
        @Assert(signature.isNone(),false)
        @Assert(signature.getOrThrow().getValue(),67324752)
    }
}
