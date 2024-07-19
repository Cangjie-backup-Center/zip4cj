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
func getSeek(): Int64 {
    22
}
@When[os == "Windows"]
func getSeek(): Int64 {
    131
}

@Test
public class SplitOutputStreamTest { 

    @TestCase
    func SplitOutputStream01(): Unit {
        try {
            SplitOutputStream(Path(""),-1)
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString() , "IllegalArgumentException: The file path cannot be empty.")
        }
    }

    @TestCase
    func SplitOutputStream02(): Unit {
        var splitOutputStream = SplitOutputStream(Path("a.txt"),-100)
        @Assert(splitOutputStream.getFilePointer() , 0)
    }

    @TestCase
    func SplitOutputStream03(): Unit {
        try {
            SplitOutputStream(Path("archive_with_invalid_zip64_headers.zip"),12)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: split length less than minimum allowed split length of 65536 Bytes")
        }
    }

    @TestCase
    func SplitOutputStream04(): Unit {
        var splitOutputStream = SplitOutputStream(Path("jar-dir-lfh-and-fh-entry-size-2.jar"))
        splitOutputStream.write(Array<Byte>())
        @Assert(splitOutputStream.getFilePointer() , 0)
    }

    @TestCase
    func SplitOutputStream05(): Unit {
        var splitOutputStream = SplitOutputStream(Path("invalid_aes_extra_data_record_length_in_header"))
        splitOutputStream.write(Array<Byte>(150,item: 0))
        @Assert(splitOutputStream.getFilePointer() , 150)
    }

    @TestCase
    func SplitOutputStream06(): Unit {
        var splitOutputStream = SplitOutputStream(Path("file_name_size_is_0_in_local_file_header"))
        splitOutputStream.write(Array<Byte>(5001,item: 0))
        @Assert(splitOutputStream.getFilePointer() , 5001)
    }

    @TestCase
    func SplitOutputStream07(): Unit {
        var splitOutputStream = SplitOutputStream(Path("invalid_zip_file_size_less_than_22kb.zip"))
        splitOutputStream.seek(15)
        @Assert(splitOutputStream.getFilePointer() , 15)
    }

    @TestCase
    func SplitOutputStream08(): Unit {
        var splitOutputStream = SplitOutputStream(Path("MobaXterm.2024-01-08_17.08.ini"))
        try {
            splitOutputStream.seek(-1)
        } catch (e: FSException) {
            @Assert(e.toString() , "FSException: Failed to seek: errno is ${getSeek()}")
        }
    }

}   


