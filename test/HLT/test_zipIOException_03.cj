//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
// sources_file:a.txt
// sources_file:archive_with_invalid_zip64_headers.zip
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
public class AesKeyStrengthTest {
    @TestCase
    func PasswordCallback01(): Unit {
        var src=OutputStreamWithSplitZipSupports()
        @Assert(src.getFilePointer(), 0)
    }

    @TestCase
    func PasswordCallback02(): Unit {
        var src=OutputStreamWithSplitZipSupports()
        @Assert(src.getCurrentSplitFileCounter(), 6)
    }

}
public class  OutputStreamWithSplitZipSupports <: OutputStreamWithSplitZipSupport {

    public func getFilePointer(): Int64 {
        return 0
    }

    public func getCurrentSplitFileCounter(): Int32 {
        return 6
    }
}