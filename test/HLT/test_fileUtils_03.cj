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
public class FileUtilsTest {
    @TestCase
    func FileUtils01(): Unit {
        let sc = FileUtils.getFilesInDirectoryRecursive(File("a.txt",OpenOption.Open(true,true)),ZipParameters())
        @Assert(sc.size, 0)
    }

    @TestCase
    func FileUtils02(): Unit {
        let sc = FileUtils.getFileNameWithoutExtension("")
        @Assert(sc, "")
    }

    @TestCase
    func FileUtils03(): Unit {
        let sc = FileUtils.getFileNameWithoutExtension("你好")
        @Assert(sc, "你好")
    }

    @TestCase
    func FileUtils04(): Unit {
        let sc = FileUtils.getFileNameWithoutExtension("dsadsaffasf")
        @Assert(sc, "dsadsaffasf")
    }

    @TestCase
    func FileUtils05(): Unit {
        let sc = FileUtils.getFileNameWithoutExtension("3453453453453.0212")
        @Assert(sc, "3453453453453")
    }
    
    @TestCase
    func FileUtils06(): Unit {
        let sc = FileUtils.getFileNameWithoutExtension("@#$$#$^^&^&^&*^*")
        @Assert(sc, "@#$$#$^^&^&^&*^*")
    }

    @TestCase
    func FileUtils07(): Unit {
        let sc = FileUtils.getFileNameWithoutExtension("@#$$#$^^&^&^&*^*3453453453453.0212你好")
        @Assert(sc, "@#$$#$^^&^&^&*^*3453453453453")
    }
}