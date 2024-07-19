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
import std.os.posix.*
import charset4cj.charset.*
import charset4cj.charset.encoding.*
import  zip4cj.*
@Test
public class FileUtilsTest {
    @TestCase
    func FileUtils01(): Unit {
        FileUtils.assertFilesExist(ArrayList<Path>(),SymbolicLinkAction.INCLUDE_LINK_ONLY)
        try {
            FileUtils.isNumberedSplitFile(Path(""))
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString() , "IllegalArgumentException: The `rawPath` cannot be an empty string!")
        }
    }

    @TestCase
    func FileUtils02(): Unit {
        FileUtils.assertFilesExist(ArrayList<Path>([Path("jar-dir-lfh-and-fh-entry-size-2.jar")]),SymbolicLinkAction.INCLUDE_LINK_ONLY)
        let sc = FileUtils.getFileExtension(Path("a.txt"))
        @Assert(sc, "txt")
    }

    @TestCase
    func FileUtils03(): Unit {
        try {
            FileUtils.assertFilesExist(ArrayList<Path>([Path("dsad")]),SymbolicLinkAction.INCLUDE_LINK_ONLY)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: File does not exist dsad")
        }
    }

    @TestCase
    func FileUtils04(): Unit {
        try {
            FileUtils.assertFilesExist(ArrayList<Path>([Path("dsad你好456")]),SymbolicLinkAction.INCLUDE_LINK_ONLY)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: File does not exist dsad你好456")
        }
    }

    @TestCase
    func FileUtils05(): Unit {
        try {
            FileUtils.assertFilesExist(ArrayList<Path>([Path("archive_with_invalid_zip64_headers.zip")]),SymbolicLinkAction.INCLUDE_LINK_ONLY)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException")
        }
    }
    
    @TestCase
    func FileUtils06(): Unit {
        try {
            FileUtils.isNumberedSplitFile(Path(""))
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString() , "IllegalArgumentException: The `rawPath` cannot be an empty string!")
        }
    }

    @TestCase
    func FileUtils07(): Unit {
        let sc = FileUtils.isNumberedSplitFile(Path("6456546456@#￥￥%"))
        @Assert(sc, false)
    }

    @TestCase
    func FileUtils08(): Unit {
        let sc = FileUtils.isNumberedSplitFile(Path("jar-dir-lfh-and-fh-entry-size-2.jar"))
        @Assert(sc, false)
    }
}