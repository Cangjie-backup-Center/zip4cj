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

@When[os == "Windows"]
func FileUtils09_str(): String {
    "[16, 0, 0, 0]"
}
@When[os != "Windows"]
func FileUtils09_str(): String {
    "[0, 0, 237, 65]"
}

@When[os == "Windows"]
func FileUtils08_str(): String {
    "[0, 0, 0, 0]"
}
@When[os != "Windows"]
func FileUtils08_str(): String {
    "[0, 0, 164, 129]"
}

@Test
public class FileUtilsTest {
    @TestCase
    func FileUtils01(): Unit {
        let sc = FileUtils.readSymbolicLink(Path("a.txt"))
        @Assert(sc, "")
    }

    @TestCase
    func FileUtils02(): Unit {
        let sc = FileUtils.readSymbolicLink(Path(""))
        @Assert(sc, "")
    }

    @TestCase
    func FileUtils03(): Unit {
        let sc = FileUtils.readSymbolicLink(Path("archive_with_invalid_zip64_headers.zip"))
        @Assert(sc, "")
    }

    @TestCase
    func FileUtils04(): Unit {
        let sc = FileUtils.readSymbolicLink(Path("jar-dir-lfh-and-fh-entry-size-2.jar"))
        @Assert(sc, "")
    }

    @TestCase
    func FileUtils05(): Unit {
        let sc = FileUtils.readSymbolicLink(Path("12125.98"))
        @Assert(sc, "")
    }

    @TestCase
    func FileUtils06(): Unit {
        let sc = FileUtils.readSymbolicLink(Path("#%^$^#$^%"))
        @Assert(sc, "")
    }

    @TestCase
    func FileUtils07(): Unit {
        let sc = FileUtils.readSymbolicLink(Path("zhon中国78893413#%^$^#$^%"))
        @Assert(sc, "")
    }

    @TestCase
    func FileUtils08(): Unit {
        let sc = FileUtils.getDefaultFileAttributes(false)
        @Assert(sc.toString(), FileUtils08_str())
    }

    @TestCase
    func FileUtils09(): Unit {
        let sc = FileUtils.getDefaultFileAttributes(true)
        @Assert(sc.toString(), FileUtils09_str())
    }

}