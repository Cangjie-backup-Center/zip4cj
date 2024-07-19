//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
// sources_file:a.txt
// sources_file:archive_with_invalid_zip64_headers.zip
// sources_file:jar-dir-lfh-and-fh-entry-size-2.jar
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
public class RawIOTest {
    @TestCase
    func RawIO01(): Unit {
        var src = RawIO()
        try {
            src.readShortLittleEndian(ByteArrayStream())
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Could not fill buffer")
        }
    }

    @TestCase
    func RawIO02(): Unit {
        var src = RawIO()
        var sc = src.readShortLittleEndian(File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)))
        @Assert(sc , 19280)
    }

    @TestCase
    func RawIO03(): Unit {
        var src = RawIO()
        try {
            src.readShortLittleEndian(File("a.txt", OpenOption.Open(true, false)))
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Could not fill buffer")
        }
    }

    @TestCase
    func RawIO04(): Unit {
        var src = RawIO()
        var file = File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)).readToEnd()
        try {
            src.readShortLittleEndian(file,Int64.Max)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO05(): Unit {
        var src = RawIO()
        try {
            src.readShortLittleEndian( Array<Byte>(),0)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO06(): Unit {
        var src = RawIO()
        var file = File("a.txt", OpenOption.Open(true, false)).readToEnd()
        try {
            src.readShortLittleEndian(file,Int64.Min)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }
}