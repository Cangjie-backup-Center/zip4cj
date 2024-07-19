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
@Test
public class SplitOutputStreamTest { 

    @TestCase
    func SplitOutputStream01(): Unit {
        var splitOutputStream = SplitOutputStream(Path("invalid_zip_file_size_less_than_22kb.zip"))
        @Assert(splitOutputStream.isSplitZipFile() , false)
        
    }

    @TestCase
    func SplitOutputStream02(): Unit {
        var splitOutputStream = SplitOutputStream(Path("a.txt"))
        @Assert(splitOutputStream.isSplitZipFile() , false)
    }

    @TestCase
    func SplitOutputStream03(): Unit {
        var splitOutputStream = SplitOutputStream(Path("archive_with_invalid_zip64_headers.zip"))
        @Assert(splitOutputStream.isSplitZipFile() , false)
    }

    @TestCase
    func SplitOutputStream04(): Unit {
        var splitOutputStream = SplitOutputStream(Path("jar-dir-lfh-and-fh-entry-size-2.jar"))
        @Assert(splitOutputStream.getSplitLength() , -1)
    }

    @TestCase
    func SplitOutputStream05(): Unit {
        var splitOutputStream = SplitOutputStream(Path("invalid_aes_extra_data_record_length_in_header"))
        @Assert(splitOutputStream.getSplitLength() , -1)
    }

    @TestCase
    func SplitOutputStream06(): Unit {
        var splitOutputStream = SplitOutputStream(Path("file_name_size_is_0_in_local_file_header"))
        @Assert(splitOutputStream.getCurrentSplitFileCounter() , 0)
    }

    @TestCase
    func SplitOutputStream07(): Unit {
        var splitOutputStream = SplitOutputStream(Path("invalid_zip_file_size_less_than_22kb.zip"))
        @Assert(splitOutputStream.getCurrentSplitFileCounter() , 0)
    }

    @TestCase
    func SplitOutputStream08(): Unit {
        var splitOutputStream = SplitOutputStream(Path("MobaXterm.2024-01-08_17.08.ini"))
        splitOutputStream.close()
        @Assert(splitOutputStream.getCurrentSplitFileCounter() , 0)
    }

}   


