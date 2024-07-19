//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
// sources_file:a.txt
// sources_file:archive_with_invalid_zip64_headers.zip
// sources_file:jar-dir-lfh-and-fh-entry-size-2.jar
// sources_file:invalid_aes_extra_data_record_length_in_header
// sources_file:file_name_size_is_0_in_local_file_header
// sources_file:invalid_zip_file_size_less_than_22kb.zip
// sources_file:MobaXterm.2024-01-08_17.08.ini
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.math.*
import std.unittest.testmacro.*
import charset4cj.charset.*
import charset4cj.charset.encoding.*
import  zip4cj.*

@When[os != "Windows"]
func getNL(): Int64 {
    0
}
@When[os == "Windows"]
func getNL(): Int64 {
    1
}

@Test
public class ZipEntryInputStreamTest { 

    @TestCase
    func ZipEntryInputStream01(): Unit {
        var file = File("MobaXterm.2024-01-08_17.08.ini", OpenOption.Open(true, true))
        var zipEntryInputStream = ZipEntryInputStream(file,100)
        var values = Array<Byte>(100,item: 0)
        @Assert(zipEntryInputStream.read(values) , 100)
    }

    @TestCase
    func ZipEntryInputStream02(): Unit {
        var file = File("invalid_zip_file_size_less_than_22kb.zip", OpenOption.Open(true, true))
        var zipEntryInputStream = ZipEntryInputStream(file,100)
        var values = Array<Byte>(100,item: 0)
        @Assert(zipEntryInputStream.read(values) , 15 + getNL())
    }

    @TestCase
    func ZipEntryInputStream03(): Unit {
        var file = File("file_name_size_is_0_in_local_file_header", OpenOption.Open(true, true))
        var zipEntryInputStream = ZipEntryInputStream(file,100)
        var values = Array<Byte>(100,item: 0)
        @Assert(zipEntryInputStream.read(values) , 100)
    }

    @TestCase
    func ZipEntryInputStream04(): Unit {
        var file = File("invalid_aes_extra_data_record_length_in_header", OpenOption.Open(true, true))
        var zipEntryInputStream = ZipEntryInputStream(file,92131)
        var values = Array<Byte>(931,item: 0)
        @Assert(zipEntryInputStream.read(values) , 74)
    }

    @TestCase
    func ZipEntryInputStream05(): Unit {
        var file = File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, true))
        var zipEntryInputStream = ZipEntryInputStream(file,62)
        var values = Array<Byte>(100,item: 0)
        @Assert(zipEntryInputStream.read(values) , 62)
    }

    @TestCase
    func ZipEntryInputStream06(): Unit {
        var file = File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, true))
        var zipEntryInputStream = ZipEntryInputStream(file,6344)
        var values = Array<Byte>(6000,item: 0)
        @Assert(zipEntryInputStream.read(values) , 6000)
    }

    @TestCase
    func ZipEntryInputStream07(): Unit {
        var file = File("a.txt", OpenOption.Open(true, true))
        var zipEntryInputStream = ZipEntryInputStream(file,-691)
        var values = Array<Byte>(1000,item: 0)
        @Assert(zipEntryInputStream.read(values) , -1)
    }

    @TestCase
    func ZipEntryInputStream08(): Unit {
        var zipEntryInputStream = ZipEntryInputStream(ByteArrayStream(),100)
        var values = Array<Byte>(45,item: 0)
        @Assert(zipEntryInputStream.read(values) , 0)
    }
}

