//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.math.*
import std.unittest.testmacro.*
import charset4cj.charset.*
import charset4cj.charset.encoding.*
import  zip4cj.*
@Test
public class LocalFileHeaderTest {
    @TestCase
    func LocalFileHeader01(): Unit {
        var localFileHeader=LocalFileHeader()
        @Assert(localFileHeader.getExtraField(), None)
    }

    @TestCase
    func LocalFileHeader02(): Unit {
        var localFileHeader=LocalFileHeader()
        localFileHeader.setExtraField(Array<Byte>())
        @Assert(localFileHeader.getExtraField().getOrThrow().size, 0)
    }

    @TestCase
    func LocalFileHeader03(): Unit {
        var localFileHeader=LocalFileHeader()
        localFileHeader.setExtraField(Array<Byte>(10,item:1))
        @Assert(localFileHeader.getExtraField().getOrThrow().size, 10)
    }

    @TestCase
    func LocalFileHeader04(): Unit {
        var localFileHeader=LocalFileHeader()
        try {
            localFileHeader.setExtraField(Array<Byte>(Int64.Max,item:1))
        } catch (e: OutOfMemoryError) {
            @Assert(e.toString() , "OutOfMemoryError")
        }
    }

    @TestCase
    func LocalFileHeader05(): Unit {
        var localFileHeader=LocalFileHeader()
        localFileHeader.setExtraField(Array<Byte>(10086,item:1))
        @Assert(localFileHeader.getExtraField().getOrThrow().size, 10086)
    }
}