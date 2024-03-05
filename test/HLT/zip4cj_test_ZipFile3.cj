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

//sources_file:archive_with_invalid_zip64_headers.zip:archive-with-no-dir-entries.zip
@Test
public class ZipFileTest {
    @TestCase
    func ZipFile01(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE);
        let zipFile = ZipFile("archive_with_invalid_zip64_headers.zip")
        zipFile.renameFile("index.html", "123123123")
        zipFile.renameFile("123123123", "index.html")
        Directory.create("contrast/10", recursive: true)
        zipFile.extractAll("./contrast/10")
        let zipFile1 = ZipFile("archive_with_invalid_zip64_headers.zip")
        Directory.create("contrast/11", recursive: true)
        zipFile1.extractAll("./contrast/11")
        let input: File = File("contrast/10/index.html", Open(true, false))
        let input1: File = File("contrast/11/index.html", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile02(): Unit {
        var a = 0
        let zipParameters = ZipParameters()
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("archive_with_invalid_zip64_headers.zip")
        try {
            zipFile.renameFile("index.html", "123123123")
        } catch (e: Exception) {
            a++
        }
        @Assert(a,0)
    }

    @TestCase
    func ZipFile03(): Unit {
        let zipParameters = ZipParameters()
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("archive-with-no-dir-entries.zip")
        zipFile.removeFile("root.txt")
        Directory.create("contrast/12", recursive: true)
        zipFile.extractAll("./contrast/12")
        let zipFile1 = ZipFile("archive-with-no-dir-entries.zip")
        Directory.create("contrast/13", recursive: true)
        zipFile1.extractAll("./contrast/13")
        let input: File = File("contrast/12/more/alpha.txt", Open(true, false))
        let input1: File = File("contrast/13/more/alpha.txt", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }
}
