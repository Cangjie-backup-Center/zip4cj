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
        FileUtils.setFileAttributes(Path(""),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("")).toString(), "[0, 0, 0, 0]")
    }

    @TestCase
    func FileUtils03(): Unit {
        FileUtils.setFileAttributes(Path(""),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("")).toString(), "[0, 0, 0, 0]")
    }

    @TestCase
    func FileUtils04(): Unit {
        FileUtils.setFileAttributes(Path("中国"),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("中国")).toString(), "[0, 0, 0, 0]")
    }

    @TestCase
    func FileUtils05(): Unit {
        FileUtils.setFileAttributes(Path("1231232"),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("1231232")).toString(), "[0, 0, 0, 0]")
    }

    @TestCase
    func FileUtils06(): Unit {
        FileUtils.setFileAttributes(Path("@#￥@￥#451"),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("@#￥@￥#451")).toString(), "[0, 0, 0, 0]")
    }

    @TestCase
    func FileUtils07(): Unit {
        FileUtils.setFileAttributes(Path("archive_with_invalid_zip64_headers.zip"),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("archive_with_invalid_zip64_headers.zip")).toString(), getFileAttributes_str())
    }

    @TestCase
    func FileUtils08(): Unit {
        FileUtils.setFileAttributes(Path("jar-dir-lfh-and-fh-entry-size-2.jar"),Array<Byte>())
        @Assert(FileUtils.getFileAttributes(Path("jar-dir-lfh-and-fh-entry-size-2.jar")).toString(), getFileAttributes_str())
    }

    @TestCase
    func FileUtils09(): Unit {
        try {
            FileUtils.setFileAttributes(Path("中国"),Array<Byte>(Int64.Max, item: 1))
        } catch (e: OutOfMemoryError) {
            @Assert(e.toString() , "OutOfMemoryError")
        }
    }
}