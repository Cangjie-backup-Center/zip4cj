//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.math.*
import std.unittest.testmacro.*
import  charset.*
import  charset.encoding.*
import  zip4cj.*

//sources_file:123.txt:archive_with_invalid_zip64_headers.zip

@Test
public class HeaderWriterTest {
    @TestCase
    func HeaderWriter01(): Unit {
        let output = File("123.txt", Open(true, false))
        let headerwriter = HeaderWriter()
        try {
            headerwriter.writeLocalFileHeader(ZipModel(), LocalFileHeader(), output, Charsets.UTF8)
        } catch (e: NoneValueException) {
            @Assert(e.toString(),"NoneValueException: cannot read the array length because array is None")
        }
    }

    @TestCase
    func HeaderWriter02(): Unit {
        var a = 0
        let output = File("123.txt", Open(true, true))
        let headerwriter = HeaderWriter()
        try {
            headerwriter.writeExtendedLocalHeader(LocalFileHeader(), output)
            headerwriter.finalizeZipFile(ZipModel(), output, Charsets.UTF8)
        } catch (e: Exception) {
            a++
        }
        @Assert(a,0)
    }

    @TestCase
    func HeaderWriter03(): Unit {
        var a = 0
        let output = SplitOutputStream(Path("sample.pdf"))
        let headerwriter = HeaderWriter()
        try {
            headerwriter.finalizeZipFileWithoutValidations(ZipModel(), output, Charsets.UTF8)
            headerwriter.updateLocalFileHeader(FileHeader(), ZipModel(), output)
        } catch (e: Exception) {
            a++
        }
        @Assert(a,0)
    }
}
