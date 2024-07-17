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

//sources_file:123.txt:archive_with_invalid_zip64_headers.zip:archive_with_invalid_zip64_headers1.zip

@Test
public class ZipOutputStreamTest {
    @TestCase
    func ZipOutputStream01(): Unit {
        let input = File("123.txt", Open(true, false))
        var buf: Array<Rune> = Array<Rune>([])
        var config = Zip4cjConfig(Charsets.UTF8, 0, true)
        try {
            ZipOutputStream(input, password: buf, zip4cjConfig: config, zipModel: ZipModel())
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString(),"IllegalArgumentException: Buffer size cannot be less than 512 bytes")
        }
    }

    @TestCase
    func ZipOutputStream02(): Unit {
        let input = File("archive_with_invalid_zip64_headers.zip", Open(true, false))
        var buf: Array<Rune> = Array<Rune>([])
        var config = Zip4cjConfig(Charsets.UTF8, 666, true)
        var zipoutputstream = ZipOutputStream(input, password: buf, zip4cjConfig: config, zipModel: ZipModel())
        try {
            zipoutputstream.putNextEntry(ZipParameters())
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString(),"IllegalArgumentException: fileNameInZip is null or empty")
        }
    }

    @TestCase
    func ZipOutputStream03(): Unit {
        let input = File("archive_with_invalid_zip64_headers.zip", Open(true, false))
        var buf: Array<Rune> = Array<Rune>([])
        var buf1: Array<UInt8> = Array<UInt8>([1, 2, 3, 4, 5, 6, 85, 4, 2, 1, 22, 1, 5, 2, 1, 1, 2])
        var config = Zip4cjConfig(Charsets.UTF8, 666, true)
        var zipoutputstream = ZipOutputStream(input, password: buf, zip4cjConfig: config, zipModel: ZipModel())
        try {
            zipoutputstream.write(buf1)
        } catch (e: NoneValueException) {
            @Assert(e.toString(),"NoneValueException: please add an entry first, which requires calling the putNextEntry function before calling the other function operation.")
        }
    }

    @TestCase
    func ZipOutputStream04(): Unit {
        let input = File("archive_with_invalid_zip64_headers.zip", Open(true, false))
        var buf: Array<Rune> = Array<Rune>([])
        var buf1: Array<UInt8> = Array<UInt8>([1, 2, 3, 4, 5, 6, 85, 4, 2, 1, 22, 1, 5, 2, 1, 1, 2])
        var config = Zip4cjConfig(Charsets.UTF8, 666, true)
        var zipoutputstream = ZipOutputStream(input)
        try {
            zipoutputstream.write(0)
        } catch (e: NoneValueException) {
            @Assert(e.toString(),"NoneValueException: please add an entry first, which requires calling the putNextEntry function before calling the other function operation.")
        }
    }

    @TestCase
    func ZipOutputStream06(): Unit {
        let input = File("archive_with_invalid_zip64_headers1.zip", Open(true, true))
        var buf: Array<Rune> = Array<Rune>([])
        var config = Zip4cjConfig(Charsets.UTF8, 666, true)
        var zipoutputstream = ZipOutputStream(input, password: buf, zip4cjConfig: config, zipModel: ZipModel())
        zipoutputstream.close()
        @Assert(zipoutputstream.isClosed(),true)
    }
}
