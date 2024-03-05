//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
from std import collection.*
from std import fs.*
from std import io.*
from std import unittest.*
from std import unittest.testmacro.*
from std import fs.*
from std import os.*
from std import os.posix.*
from charset import charset.*
from charset import charset.encoding.*
from zip4cj import zip4cj.*

//sources_file:output123.zip:MP4.mp4:renames.zip:renames2.zip
@Test
public class ZipFileTest {
    @TestCase
    func ZipFile01(): Unit {
        let zipFile = ZipFile("output123.zip")
        @Assert(zipFile.getComment(),"")
        zipFile.setComment("123")
        @Assert(zipFile.getComment(),"123")
        zipFile.setComment("cangjie")
        @Assert(zipFile.getComment(),"cangjie")
        zipFile.setComment("仓颉")
        @Assert(zipFile.getComment(),"仓颉")
        zipFile.setComment("仓颉%……%12a")
        @Assert(zipFile.getComment(),"仓颉%……%12a")
    }

    @TestCase
    func ZipFile02(): Unit {
        let zipFile = ZipFile("output123.zip")
        var fileheader = FileHeader()
        fileheader.setFileName("MP4.mp4")
        @Assert(zipFile.getInputStream(fileheader).read(),-1)
    }

    @TestCase
    func ZipFile03(): Unit {
        let zipFile = ZipFile("output123.zip")
        var fileheader = FileHeader()
        fileheader.setFileName("MP4.mp4")
        @Assert(zipFile.getInputStream(fileheader).read(),-1)
    }

    @TestCase
    func ZipFile04(): Unit {
        let zipFile = ZipFile("output123.zip")
        @Assert(zipFile.getBufferSize(),4096)
        zipFile.setBufferSize(9223372036854775807)
        @Assert(zipFile.getBufferSize(),9223372036854775807)
        try {
            zipFile.setBufferSize(-9223372036854775808)
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: Buffer size cannot be less than 512 bytes")
        }
    }

    @TestCase
    func ZipFile05(): Unit {
        let zipFile = ZipFile("output123.zip")
        @Assert(zipFile.getProgressMonitor().getPercentDone(),0)
        @Assert(zipFile.getFile().toString(),"output123.zip")
        @Assert(zipFile.getCharset().toString(),"UTF-8")
        zipFile.setCharset(Charsets.UTF16BE)
        @Assert(zipFile.getCharset().toString(),"UTF-16BE")
    }

    @TestCase
    func ZipFile06(): Unit {
        let zipFile = ZipFile("output123.zip")
        @Assert(zipFile.isUseUtf8CharsetForPasswords(),true)
        zipFile.setUseUtf8CharsetForPasswords(false)
        @Assert(zipFile.isUseUtf8CharsetForPasswords(),false)
        zipFile.setUseUtf8CharsetForPasswords(true)
        @Assert(zipFile.isUseUtf8CharsetForPasswords(),true)
    }

    @TestCase
    func ZipFile07(): Unit {
        let zipFile = ZipFile("output123.zip")
        zipFile.getExecutorService()
        @Assert(zipFile.toString(),"output123.zip")
    }
    @TestCase
    func ZipFile08(): Unit {
        var name = HashMap<String, String>(
            [("renames/123.txt", "renames/456.txt"), ("renames/1/MP3.mp3", "renames/1/mp31.mp3")])
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE);
        let zipFile = ZipFile("renames.zip")
        zipFile.renameFiles(name)
        Directory.create("contrast/40", recursive: true)
        zipFile.extractAll("./contrast/40")
        @Assert(File.exists("contrast/40/renames/1/mp31.mp3"),true)
    }

    @TestCase
    func ZipFile09(): Unit {
        var name = HashMap<String, String>([("renames/12344.txt", "renames/456.txt"), ("", "")])
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE);
        let zipFile = ZipFile("renames2.zip")
        zipFile.renameFiles(name)
        Directory.create("contrast/41", recursive: true)
        zipFile.extractAll("./contrast/41")
        @Assert(File.exists("contrast/41/renames/456.txt"),false)
    }
}
