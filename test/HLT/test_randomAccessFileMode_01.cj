//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
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
public class RandomAccessFileModeTest {
    @TestCase
    func RandomAccessFileMode01(): Unit {
        var randomAccessFileMode=RandomAccessFileMode.READ
        @Assert(randomAccessFileMode.getValue(), "r")
    }

    @TestCase
    func RandomAccessFileMode02(): Unit {
        var randomAccessFileMode=RandomAccessFileMode.WRITE
        @Assert(randomAccessFileMode.getValue(), "rw")
    }
}