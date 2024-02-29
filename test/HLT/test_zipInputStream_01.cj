//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
// sources_file:a.txt
// sources_file:archive_with_invalid_zip64_headers.zip
// sources_file:jar-dir-lfh-and-fh-entry-size-2.jar
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
        var zipInputStream = ZipInputStream(ByteArrayStream())
        @Assert(zipInputStream.read() , -1)
    }

    @TestCase
    func ZipInputStream02(): Unit {
        var data = ByteArrayStream()
        data.write(Array<Byte>(10,item:0))
        var zipInputStream = ZipInputStream(data)
        @Assert(zipInputStream.read() , -1)
    }

    @TestCase
    func ZipInputStream03(): Unit {
        var input = ByteArrayStream()
        input.write(Array<UInt8>(106,item:1))
        var zipInputStream = ZipInputStream(input,password:None,passwordCallback:None,config:Zip4cjConfig(None, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
        @Assert(zipInputStream.read() , -1)
    }

    @TestCase
    func ZipInputStream04(): Unit {
        var zipInputStream = ZipInputStream(ByteArrayStream(),password:None,passwordCallback:None,config:Zip4cjConfig(None, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
        @Assert(zipInputStream.read() , -1)
    }

    @TestCase
    func ZipInputStream05(): Unit {
        var zipInputStream = ZipInputStream(ByteArrayStream(),password:None,passwordCallback:PasswordCallbacks(),config:Zip4cjConfig(None, InternalZipConstants.BUFF_SIZE,
            InternalZipConstants.USE_UTF8_FOR_PASSWORD_ENCODING_DECODING))
        @Assert(zipInputStream.read() , -1)
    }

    @TestCase
    func ZipInputStream06(): Unit {
        try {
            ZipInputStream(ByteArrayStream(),password:None,passwordCallback:None,config:Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString() , "IllegalArgumentException: Buffer size cannot be less than  512 bytes")
        }
    }

    @TestCase
    func ZipInputStream07(): Unit {
        try {
            ZipInputStream(ByteArrayStream(),password:None,passwordCallback:PasswordCallbacks(),config:Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString() , "IllegalArgumentException: Buffer size cannot be less than  512 bytes")
        }
    }

    @TestCase
    func ZipInputStream08(): Unit {
        try {
            ZipInputStream(ByteArrayStream(),password:Array<Char>(),passwordCallback:None,config:Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString() , "IllegalArgumentException: Buffer size cannot be less than  512 bytes")
        }
    }
}

public class PasswordCallbacks <: PasswordCallback {
    public func getPassword(): Array<Char> {
        return Array<Char>()
    }
}

