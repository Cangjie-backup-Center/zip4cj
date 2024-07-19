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
public class FileUtilsTest {
    @TestCase
    func FileUtils01(): Unit {
        let sc = FileUtils.getFileExtension(Path("jar-dir-lfh-and-fh-entry-size-2.jar"))
        @Assert(sc, "jar")
    }

    @TestCase
    func FileUtils02(): Unit {
        let sc = FileUtils.getFileExtension(Path("archive_with_invalid_zip64_headers.zip"))
        @Assert(sc, "zip")
    }

    @TestCase
    func FileUtils03(): Unit {
        let sc = FileUtils.getFileExtension(Path("a.txt"))
        @Assert(sc, "txt")
    }

    @TestCase
    func FileUtils04(): Unit {
        try {
            FileUtils.getFileExtension(Path(""))
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString() , "IllegalArgumentException: The `rawPath` cannot be an empty string!")
        }
    }

    @TestCase
    func FileUtils05(): Unit {
        let sc = FileUtils.getFileExtension(Path("#$%#$%$"))
        @Assert(sc, "")
    }

    @TestCase
    func FileUtils06(): Unit {
        let sc = FileUtils.getFileExtension(Path("146521..12"))
        @Assert(sc, "12")
    }

    @TestCase
    func FileUtils07(): Unit {
        try {
            FileUtils.getAllSortedNumberedSplitFiles(Path("jar-dir-lfh-and-fh-entry-size-2.jar"))
        } catch (e: NoneValueException) {
            @Assert(e.toString() , "NoneValueException")
        }
    }

    @TestCase
    func FileUtils08(): Unit {
        try {
            FileUtils.getAllSortedNumberedSplitFiles(Path("archive_with_invalid_zip64_headers.zip"))
        } catch (e: NoneValueException) {
            @Assert(e.toString() , "NoneValueException")
        }
    }

    @TestCase
    func FileUtils09(): Unit {
        try {
            FileUtils.getAllSortedNumberedSplitFiles(Path("a.txt"))
        } catch (e: NoneValueException) {
            @Assert(e.toString() , "NoneValueException")
        }
    }

    @TestCase
    func FileUtils10(): Unit {
        try {
            FileUtils.getAllSortedNumberedSplitFiles(Path(""))
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString() , "IllegalArgumentException: The `rawPath` cannot be an empty string!")
        }
    }

    @TestCase
    func FileUtils11(): Unit {
        try {
            FileUtils.getAllSortedNumberedSplitFiles(Path("#$%#$%$"))
        } catch (e: NoneValueException) {
            @Assert(e.toString() , "NoneValueException")
        }
    }

    @TestCase
    func FileUtils12(): Unit {
        try {
            FileUtils.getAllSortedNumberedSplitFiles(Path("146521..12"))
        } catch (e: NoneValueException) {
            @Assert(e.toString() , "NoneValueException")
        }
    }   
}