//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
from std import collection.*
from std import fs.*
from std import io.*
from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.encoding.*
from zip4cj import zip4cj.*
from std import math.*

//sources_file:sample.pdf:after_deflate_remaining_bytes.bin:sample_text_large.txt:가나다.abc:jar-dir-lfh-and-fh-entry-size-2.jar:MobaXterm.2024-01-03_11.24.ini
//sources_file:libssl.so.3:picture.webp:1COMM_v24tagswithalbumimage1.mp3
@Test
public class Zip4cjUtilTest {
    @TestCase
    func Zip4cjUtil01(): Unit {
        @Assert(Zip4cjUtil.isStringNullOrEmpty("cangjie"),false)
        @Assert(Zip4cjUtil.isStringNotNullAndNotEmpty("cangjie"),true)
    }

    @TestCase
    func Zip4cjUtil02(): Unit {
        @Assert(Zip4cjUtil.isStringNullOrEmpty("仓颉"),false)
        @Assert(Zip4cjUtil.isStringNotNullAndNotEmpty("仓颉"),true)
    }

    @TestCase
    func Zip4cjUtil03(): Unit {
        @Assert(Zip4cjUtil.isStringNullOrEmpty("123"),false)
        @Assert(Zip4cjUtil.isStringNotNullAndNotEmpty("123"),true)
    }

    @TestCase
    func Zip4cjUtil04(): Unit {
        @Assert(Zip4cjUtil.isStringNullOrEmpty("$%^&"),false)
        @Assert(Zip4cjUtil.isStringNotNullAndNotEmpty("$%^&"),true)
    }

    @TestCase
    func Zip4cjUtil05(): Unit {
        @Assert(Zip4cjUtil.isStringNullOrEmpty(""),true)
        @Assert(Zip4cjUtil.isStringNotNullAndNotEmpty(""),false)
    }

    @TestCase
    func Zip4cjUtil06(): Unit {
        @Assert(Zip4cjUtil.createDirectoryIfNotExists(Path("sample.pdf\\1")),true)
        try {
            @Assert(Zip4cjUtil.createDirectoryIfNotExists(Path("after_deflate_remaining_bytes.bin")),true)
        } catch (e: Exception) {
            @Assert(e.toString(),"ZipException: output directory is not valid")
        }
    }

    @TestCase
    func Zip4cjUtil09(): Unit {
        try {
            Zip4cjUtil.getCompressionMethod(FileHeader()).getCode()
        } catch (e: Exception) {
            @Assert(e.toString(),"NoneValueException")
        }
    }

    @TestCase
    func Zip4cjUtil10(): Unit {
        var byte = Array<Byte>([])
        var input: File = File("sample.pdf", Open(true, true))
        @Assert(Zip4cjUtil.readFully(input,byte),0)
    }

    @TestCase
    func Zip4cjUtil11(): Unit {
        var byte = Array<Byte>([1, 2, 3, 4, 5, 7])
        var input: File = File("sample.pdf", Open(true, true))
        @Assert(Zip4cjUtil.readFully(input,byte),6)
        @Assert(Zip4cjUtil.readFully(input,byte,2,2),2)
    }

    @TestCase
    func Zip4cjUtil12(): Unit {
        var byte = Array<Byte>([1, 2, 3, 4, 5, 7])
        var input: File = File("sample.pdf", Open(true, true))
        @Assert(Zip4cjUtil.readFully(input,byte),6)
        try {
            Zip4cjUtil.readFully(input, byte, 2, 888)
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: Length greater than buffer size")
        }
    }

    @TestCase
    func Zip4cjUtil13(): Unit {
        var byte = Array<Byte>([1, 2, 3, 4, 5, 7])
        var input: File = File("after_deflate_remaining_bytes.bin", Open(true, true))
        @Assert(Zip4cjUtil.readFully(input,byte),6)
        @Assert(Zip4cjUtil.readFully(input,byte,2,2),2)
    }
}
