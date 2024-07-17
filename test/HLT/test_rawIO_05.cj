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
import  charset.*
import  charset.encoding.*
import  zip4cj.*
@Test
public class RawIOTest {
    @TestCase
    func RawIO01(): Unit {
        var src = RawIO()
        try {
            src.readIntLittleEndian(Array<Byte>(),0)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO02(): Unit {
        var src = RawIO()
        var file = File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false)).readToEnd()
        try {
            src.readIntLittleEndian(file,Int64.Max)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO03(): Unit {
        var src = RawIO()
        var file = File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)).readToEnd()
        try {
            src.readIntLittleEndian(file,Int64.Min)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO04(): Unit {
        var src = RawIO()
        var file = RandomAccessFile(File("a.txt", OpenOption.Open(true, false)))
        let sc = src.readShortLittleEndian(file)
        @Assert(sc, 49)
    }

    @TestCase
    func RawIO05(): Unit {
        var src = RawIO()
        var file = RandomAccessFile(File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false)))
        let sc = src.readShortLittleEndian(file)
        @Assert(sc, 19280)
    }

    @TestCase
    func RawIO06(): Unit {
        var src = RawIO()
        var file = RandomAccessFile(File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)))
        let sc = src.readShortLittleEndian(file)
        @Assert(sc, 19280)
    }
}