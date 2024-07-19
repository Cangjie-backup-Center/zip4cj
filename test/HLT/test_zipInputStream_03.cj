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
public class ZipInputStreamTest { 

    @TestCase
    func ZipInputStream01(): Unit {
        var zipInputStream = ZipInputStream(File("a.txt", OpenOption.Open(true, false)))
        try {
            zipInputStream.getNextEntry(None,true).getOrThrow()
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Could not fill buffer")
        }
    }

    @TestCase
    func ZipInputStream02(): Unit {
        var zipInputStream = ZipInputStream(File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)))
        var src = zipInputStream.getNextEntry(None,false).getOrThrow()
        @Assert(src.getOffsetStartOfData() , 0)
    }

    @TestCase
    func ZipInputStream03(): Unit {
        var input = ByteArrayStream()
        input.write(Array<UInt8>(106,item:1))
        var zipInputStream = ZipInputStream(input)
        try {
            zipInputStream.getNextEntry(FileHeader(),false).getOrThrow()
        } catch (e: NoneValueException) {
            @Assert(e.toString() , "NoneValueException")
        }
    }

    @TestCase
    func ZipInputStream04(): Unit {
        var zipInputStream = ZipInputStream(File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false)),password:None,passwordCallback:None,config:Zip4cjConfig(None, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
        var src = zipInputStream.getNextEntry(FileHeader(),true).getOrThrow()
        @Assert(src.getOffsetStartOfData() , 0)
    }

    @TestCase
    func ZipInputStream05(): Unit {
        var zipInputStream = ZipInputStream(File("invalid_aes_extra_data_record_length_in_header", OpenOption.Open(true, false)),password:None,passwordCallback:PasswordCallbacks(),config:Zip4cjConfig(None, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
        var input = Array<Byte>()
        @Assert(zipInputStream.read(input) , -1)
    }

    @TestCase
    func ZipInputStream06(): Unit {
        var zipInputStream = ZipInputStream(File("file_name_size_is_0_in_local_file_header", OpenOption.Open(true, false)),password:None,passwordCallback:PasswordCallbacks(),config:Zip4cjConfig(None, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
        var input = Array<Byte>(100,item:1)
        @Assert(zipInputStream.read(input) , -1)
    }

    @TestCase
    func ZipInputStream07(): Unit {
        var zipInputStream = ZipInputStream(File("invalid_zip_file_size_less_than_22kb.zip", OpenOption.Open(true, false)),password:None,passwordCallback:PasswordCallbacks(),config:Zip4cjConfig(None, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
        var input = Array<Byte>(6484,item:1)
        @Assert(zipInputStream.read(input) , -1)
    }
    @TestCase
    func ZipInputStream08(): Unit {
        var zipInputStream = ZipInputStream(File("MobaXterm.2024-01-08_17.08.ini", OpenOption.Open(true, false)),password:None,passwordCallback:PasswordCallbacks(),config:Zip4cjConfig(None, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
        var input = Array<Byte>(5000,item:1)
        @Assert(zipInputStream.read(input) , -1)
    }
}

public class PasswordCallbacks <: PasswordCallback {
    public func getPassword(): Array<Rune> {
        return Array<Rune>()
    }
}

