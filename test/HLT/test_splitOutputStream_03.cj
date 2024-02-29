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
from std import collection.*
from std import fs.*
from std import io.*
from std import unittest.*
from std import math.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.encoding.*
from zip4cj import zip4cj.*
@Test
public class SplitOutputStreamTest { 

    @TestCase
    func SplitOutputStream01(): Unit {
        var splitOutputStream = SplitOutputStream(Path("a.txt"))
        try {
            splitOutputStream.checkBufferSizeAndStartNextSplitFile(-10)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: negative buffersize for checkBufferSizeAndStartNextSplitFile")
        }
    }

    @TestCase
    func SplitOutputStream02(): Unit {
        var splitOutputStream = SplitOutputStream(Path("a.txt"))
        @Assert(splitOutputStream.checkBufferSizeAndStartNextSplitFile(1) , false)
    }

    @TestCase
    func SplitOutputStream03(): Unit {
        var splitOutputStream = SplitOutputStream(Path("archive_with_invalid_zip64_headers.zip"))
        @Assert(splitOutputStream.checkBufferSizeAndStartNextSplitFile(15) , false)
    }

    @TestCase
    func SplitOutputStream04(): Unit {
        var splitOutputStream = SplitOutputStream(Path("jar-dir-lfh-and-fh-entry-size-2.jar"))
        @Assert(splitOutputStream.checkBufferSizeAndStartNextSplitFile(0) , false)
    }

    @TestCase
    func SplitOutputStream05(): Unit {
        var splitOutputStream = SplitOutputStream(Path("invalid_aes_extra_data_record_length_in_header"))
        @Assert(splitOutputStream.skipBytes(-6) , -6)
    }

    @TestCase
    func SplitOutputStream06(): Unit {
        var splitOutputStream = SplitOutputStream(Path("file_name_size_is_0_in_local_file_header"))
        @Assert(splitOutputStream.skipBytes(15) , 15)
    }

    @TestCase
    func SplitOutputStream07(): Unit {
        var splitOutputStream = SplitOutputStream(Path("invalid_zip_file_size_less_than_22kb.zip"))
        @Assert(splitOutputStream.isClosed() , false)
    }

    @TestCase
    func SplitOutputStream08(): Unit {
        var splitOutputStream = SplitOutputStream(Path("MobaXterm.2024-01-08_17.08.ini"))
        splitOutputStream.close()
        @Assert(splitOutputStream.isClosed() , true)
    }

}   


