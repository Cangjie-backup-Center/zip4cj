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
        src.writeIntLittleEndian(ByteArrayStream(),0)
        src.writeIntLittleEndian(ByteArrayStream(),Int32.Max)
        src.writeIntLittleEndian(ByteArrayStream(),Int32.Min)
        try {
            src.writeIntLittleEndian(File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false)),0)
        } catch (e: FSException) {
            @Assert(e.toString() , "FSException: The file does not have the write permission.")
        }
    }

    @TestCase
    func RawIO02(): Unit {
        var src = RawIO()
        try {
            src.writeIntLittleEndian(File("a.txt", OpenOption.Open(true, false)),Int32.Min)
        } catch (e: FSException) {
            @Assert(e.toString() , "FSException: The file does not have the write permission.")
        }
    }

    @TestCase
    func RawIO03(): Unit {
        var src = RawIO()
        try {
            src.writeIntLittleEndian(File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)),0)
        } catch (e: FSException) {
            @Assert(e.toString() , "FSException: The file does not have the write permission.")
        }
    }

    @TestCase
    func RawIO04(): Unit {
        var src = RawIO()
        try {
            src.writeIntLittleEndian(File("a.txt", OpenOption.Open(true, false)),Int32.Max)
        } catch (e: FSException) {
            @Assert(e.toString() , "FSException: The file does not have the write permission.")
        }
    }

    @TestCase
    func RawIO05(): Unit {
        var src = RawIO()
        try {
            src.writeIntLittleEndian(Array<Byte>(),0,0)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO06(): Unit {
        var src = RawIO()
        try {
            src.writeIntLittleEndian(Array<Byte>(100,item: 0),Int64.Max,0)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO07(): Unit {
        var src = RawIO()
        src.writeIntLittleEndian(Array<Byte>(100,item: 0),0,Int32.Min)
        try {
            src.writeIntLittleEndian(Array<Byte>(100,item: 0),Int64.Max,Int32.Min)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }

    @TestCase
    func RawIO08(): Unit {
        var src = RawIO()
        try {
            src.writeIntLittleEndian(Array<Byte>(100,item: 0),Int64.Max,15)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException")
        }
    }
}