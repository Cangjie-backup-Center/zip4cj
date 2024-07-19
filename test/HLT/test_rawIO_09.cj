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
            src.writeIntLittleEndian(Array<Byte>(),0,0)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO02(): Unit {
        var src = RawIO()
        try {
            src.writeIntLittleEndian(Array<Byte>(),Int64.Max,Int32.Max)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO03(): Unit {
        var src = RawIO()
        try {
            src.writeIntLittleEndian(Array<Byte>(),0,Int32.Min)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO04(): Unit {
        var src = RawIO()
        src.writeLongLittleEndian(ByteArrayStream(),Int64.Max)
        src.writeLongLittleEndian(ByteArrayStream(),0)
        try {
            src.writeLongLittleEndian(File("a.txt", OpenOption.Open(true, false)),Int64.Min)
        } catch (e: FSException) {
            @Assert(e.toString() , "FSException: The file does not have the write permission.")
        }
    }

    @TestCase
    func RawIO05(): Unit {
        var src = RawIO()
        try {
            src.writeLongLittleEndian(File("a.txt", OpenOption.Open(true, false)),Int64.Max)
        } catch (e: FSException) {
            @Assert(e.toString() , "FSException: The file does not have the write permission.")
        }
    }

    @TestCase
    func RawIO06(): Unit {
        var src = RawIO()
        try {
            src.writeLongLittleEndian(File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false)),Int64.Min)
        } catch (e: FSException) {
            @Assert(e.toString() , "FSException: The file does not have the write permission.")
        }
    }

    @TestCase
    func RawIO07(): Unit {
        var src = RawIO()
        try {
            src.writeLongLittleEndian(File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)),0)
        } catch (e: FSException) {
            @Assert(e.toString() , "FSException: The file does not have the write permission.")
        }
    }
}