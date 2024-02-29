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
public class ZipInputStreamTest { 

    @TestCase
    func ZipInputStream01(): Unit {
        var zipInputStream = ZipInputStream(File("a.txt", OpenOption.Open(true, false)))
        @Assert(zipInputStream.available() , 1)
    }

    @TestCase
    func ZipInputStream02(): Unit {
        var zipInputStream = ZipInputStream(File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)))
        @Assert(zipInputStream.available() , 1)
    }

    @TestCase
    func ZipInputStream03(): Unit {
        var input = ByteArrayStream()
        input.write(Array<UInt8>(106,item:1))
        var zipInputStream = ZipInputStream(input)
        @Assert(zipInputStream.available() , 1)
    }

    @TestCase
    func ZipInputStream04(): Unit {
        var zipInputStream = ZipInputStream(File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false)),password:None,passwordCallback:None,config:Zip4cjConfig(None, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
        @Assert(zipInputStream.available() , 1)
    }

    @TestCase
    func ZipInputStream05(): Unit {
        var zipInputStream = ZipInputStream(File("invalid_aes_extra_data_record_length_in_header", OpenOption.Open(true, false)),password:None,passwordCallback:PasswordCallbacks(),config:Zip4cjConfig(None, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
        zipInputStream.setPassword(Array<Char>())
        @Assert(zipInputStream.available() , 1)
    }

    @TestCase
    func ZipInputStream06(): Unit {
        var zipInputStream = ZipInputStream(File("file_name_size_is_0_in_local_file_header", OpenOption.Open(true, false)),password:None,passwordCallback:PasswordCallbacks(),config:Zip4cjConfig(None, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
        zipInputStream.setPassword(None)
        @Assert(zipInputStream.available() , 1)
    }

    @TestCase
    func ZipInputStream07(): Unit {
        var zipInputStream = ZipInputStream(File("invalid_zip_file_size_less_than_22kb.zip", OpenOption.Open(true, false)),password:None,passwordCallback:PasswordCallbacks(),config:Zip4cjConfig(None, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
        @Assert(zipInputStream.available() , 1)
    }
    @TestCase
    func ZipInputStream08(): Unit {
        var zipInputStream = ZipInputStream(File("MobaXterm.2024-01-08_17.08.ini", OpenOption.Open(true, false)),password:None,passwordCallback:PasswordCallbacks(),config:Zip4cjConfig(None, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
        zipInputStream.close()
        try {
            zipInputStream.available()
        } catch (e: ZipIOException) {
            @Assert(e.toString() , "ZipIOException: Stream closed")
        }
    }
}

public class PasswordCallbacks <: PasswordCallback {
    public func getPassword(): Array<Char> {
        return Array<Char>()
    }
}

