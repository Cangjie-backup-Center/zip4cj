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

@When[os == "Windows"]
func getFileAttributes_str(): String {
    "[32, 0, 0, 0]"
}
@When[os != "Windows"]
func getFileAttributes_str(): String {
    "[0, 0, 182, 129]"
}

@Test
public class FileUtilsTest {
    @TestCase
    func FileUtils01(): Unit {
        FileUtils.setFileAttributes(Path("a.txt"),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("a.txt")).toString(), getFileAttributes_str())
    }

    @TestCase
    func FileUtils02(): Unit {
        FileUtils.setFileLastModifiedTimeWithoutNio(Path("a.txt"),10)
        @Assert(FileUtils.getFileAttributes(Path("@#￥@￥#451")).toString(), "[0, 0, 0, 0]")
    }

    @TestCase
    func FileUtils03(): Unit {
        let sc = FileUtils.getFilesInDirectoryRecursive(Path("a.txt"),ZipParameters())
        @Assert(sc.toString(), "[]")
    }

    @TestCase
    func FileUtils04(): Unit {
        let sc = FileUtils.getFilesInDirectoryRecursive(Path(""),ZipParameters())
        @Assert(sc.toString(), "[]")
    }

    @TestCase
    func FileUtils05(): Unit {
        let sc = FileUtils.getFilesInDirectoryRecursive(Path("你好呀"),ZipParameters())
        @Assert(sc.toString(), "[]")
    }
    
    @TestCase
    func FileUtils06(): Unit {
        let sc = FileUtils.getFilesInDirectoryRecursive(Path("@#@#$@#45465"),ZipParameters())
        @Assert(sc.toString(), "[]")
    }

    @TestCase
    func FileUtils07(): Unit {
        let sc = FileUtils.getFilesInDirectoryRecursive(Path("54645654"),ZipParameters())
        @Assert(sc.toString(), "[]")
    }
}