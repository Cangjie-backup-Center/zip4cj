//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*
import  charset.*
import  charset.encoding.*
import  zip4cj.*

@Test
public class Zip4cjConfigTest {
    @TestCase
    func Zip4cjConfig01(): Unit {
        var config = Zip4cjConfig(Charsets.UTF8, 0, true)
        @Assert(config.getCharset().getOrThrow().toString(),"UTF-8")
        @Assert(config.getBufferSize(),0)
        @Assert(config.isUseUtf8CharsetForPasswords(),true)
    }

    @TestCase
    func Zip4cjConfig02(): Unit {
        var config = Zip4cjConfig(Charsets.UTF8, 0, false)
        @Assert(config.getCharset().getOrThrow().toString(),"UTF-8")
        @Assert(config.getBufferSize(),0)
        @Assert(config.isUseUtf8CharsetForPasswords(),false)
    }

    @TestCase
    func Zip4cjConfig03(): Unit {
        var config = Zip4cjConfig(Charsets.UTF8, -9223372036854775808, true)
        @Assert(config.getCharset().getOrThrow().toString(),"UTF-8")
        @Assert(config.getBufferSize(),-9223372036854775808)
        @Assert(config.isUseUtf8CharsetForPasswords(),true)
    }

    @TestCase
    func Zip4cjConfig04(): Unit {
        var config = Zip4cjConfig(Charsets.UTF8, 9223372036854775807, false)
        @Assert(config.getCharset().getOrThrow().toString(),"UTF-8")
        @Assert(config.getBufferSize(),9223372036854775807)
        @Assert(config.isUseUtf8CharsetForPasswords(),false)
    }
}
