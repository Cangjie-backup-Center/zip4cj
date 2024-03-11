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

//sources_file:1COMM_v24tagswithalbumimage1.mp3:123.txt:file_name_size_is_0_in_local_file_header:libssl.so.3
//sources_file:contrastFile/libssl.so.3.rar:unexpected-eof-when-reading-stream:a.txt:after_deflate_remaining_bytes.bin:1unexpected-eof-when-reading-stream
@Test
public class ZipFileTest {
    @TestCase
    func ZipFile04(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        let zipFile = ZipFile("output123o.zip")
        let files = [Path("123.txt")]
        zipFile.createSplitZipFile(files, zipParameters, false, 20)
        let zipFile1 = ZipFile("output123o.zip")
        zipFile1.extractAll("./contrast/txt")
        let input: File = File("contrast/txt/123.txt", Open(true, false))
        let input1: File = File("123.txt", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile05(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        let zipFile = ZipFile("contrast_file_name_size_is_0_in_local_file_header.zip")
        let files = [Path("file_name_size_is_0_in_local_file_header")]
        try {
            zipFile.createSplitZipFile(files, zipParameters, true, 20)
        } catch (e: ZipException) {
            @Assert(e.toString(),"ZipException: split length less than minimum allowed split length of 65536 Bytes")
        }
    }

    @TestCase
    func ZipFile06(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        let zipFile = ZipFile("contrast_file_name_size_is_0_in_local_file_header.zip")
        let files = [Path("file_name_size_is_0_in_local_file_header")]
        zipFile.createSplitZipFile(files, zipParameters, false, 20)
        let zipFile1 = ZipFile("contrast_file_name_size_is_0_in_local_file_header.zip")
        Directory.create("contrast/1")
        zipFile1.extractAll("./contrast/1")
        let input: File = File("contrast/1/file_name_size_is_0_in_local_file_header", Open(true, false))
        let input1: File = File("file_name_size_is_0_in_local_file_header", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile07(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        let zipFile = ZipFile("cangjie1111.zip")
        let files = [Path("cangjie1111")]
        try {
            zipFile.createSplitZipFile(files, zipParameters, false, 20)
        } catch (e: ZipException) {
            @Assert(e.toString(),"ZipException: The path `cangjie1111` does not exist")
        }
    }

    @TestCase
    func ZipFile08(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        let zipFile = ZipFile("cangjie11111.zip")
        let files = [Path(" ")]
        try {
            zipFile.createSplitZipFile(files, zipParameters, false, 20)
        } catch (e: ZipException) {
            @Assert(e.toString(),"ZipException: The path ` ` does not exist")
        }
    }

    @TestCase
    func ZipFile09(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        let zipFile = ZipFile("libssl.so.3.rar")
        let files = Path("libssl.so.3")
        zipFile.createSplitZipFile([files], zipParameters, false, 20)
        let zipFile1 = ZipFile("libssl.so.3.rar")
        Directory.create("contrast/221", recursive: true)
        zipFile1.extractAll("./contrast/221")
        let input: File = File("contrast/221/libssl.so.3", Open(true, false))
        let input1: File = File("libssl.so.3", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile10(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        let zipFile = ZipFile("llibssl.so.3.7z")
        let files = Path("libssl.so.3")
        zipFile.createSplitZipFile([files], zipParameters, false, 20)
        let zipFile1 = ZipFile("llibssl.so.3.7z")
        zipFile1.extractAll("./contrast/po")
        let input: File = File("contrast/po/libssl.so.3", Open(true, false))
        let input1: File = File("libssl.so.3", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile11(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        let zipFile = ZipFile("llibssl.so.3.mp4")
        let files = Path("libssl.so.3")
        zipFile.createSplitZipFile([files], zipParameters, false, 20)
        let zipFile1 = ZipFile("llibssl.so.3.mp4")
        zipFile1.extractAll("./contrast/ml")
        let input: File = File("contrast/ml/libssl.so.3", Open(true, false))
        let input1: File = File("libssl.so.3", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile12(): Unit {
        let zipParameters = ZipParameters()
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("unexpected-eof-when-reading-stream159.zip")
        let files = File("unexpected-eof-when-reading-stream", Open(true, false))
        try {
            zipFile.createSplitZipFile(files, zipParameters, false, 20)
        } catch (e: ZipException) {
            @Assert(e.toString(),"ZipException: fileNameInZip has to be set in zipParameters when adding stream")
        }
    }

    @TestCase
    func ZipFile13(): Unit {
        let zipParameters = ZipParameters()
        zipParameters.setFileNameInZip("123")
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("1unexpected-eof-when-reading-stream.zip")
        let files = File("1unexpected-eof-when-reading-stream", Open(true, false))
        zipFile.createSplitZipFile(files, zipParameters, false, 20)
        let zipFile1 = ZipFile("1unexpected-eof-when-reading-stream.zip")
        Directory.create("contrast/25")
        zipFile1.extractAll("./contrast/25")
        let input: File = File("contrast/25/123", Open(true, false))
        let input1: File = File("1unexpected-eof-when-reading-stream", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile14(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        let zipFile = ZipFile("admix.zip")
        let files = [Path("a.txt"), Path("after_deflate_remaining_bytes.bin")]
        zipFile.createSplitZipFile(files, zipParameters, false, 20)
        let zipFile1 = ZipFile("admix.zip")
        Directory.create("contrast/62", recursive: true)
        zipFile1.extractAll("./contrast/62")
        let input: File = File("contrast/62/a.txt", Open(true, false))
        let input1: File = File("a.txt", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
        let input2: File = File("contrast/62/after_deflate_remaining_bytes.bin", Open(true, false))
        let input3: File = File("after_deflate_remaining_bytes.bin", Open(true, false))
        @Assert(input2.readToEnd(),input3.readToEnd())
    }

    @TestCase
    func ZipFile15(): Unit {
        var a = 0
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        let zipFile = ZipFile("ppt789.zip")
        let files = [Path("../../../resources/ppt")]
        try {
            zipFile.createSplitZipFile(files, zipParameters, false, 20)
        } catch (e: Exception) {
            a++
        }
        @Assert(a,0)
    }

    @TestCase
    func ZipFile16(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        let zipFile = ZipFile("ppt1.zip")
        let path = Path("../../../resources/ppt")
        zipFile.addFolder(path, parameters: zipParameters, checkSplitArchive: true)
        let zipFile1 = ZipFile("ppt1.zip")
        Directory.create("contrast/72")
        zipFile1.extractAll("./contrast/72")
        let input: File = File("contrast/72/ppt/libssl.so.3", Open(true, false))
        let input1: File = File("../../../resources/ppt/libssl.so.3", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile17(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        zipParameters.setReadHiddenFiles(false)
        let zipFile = ZipFile("hidefile.zip")
        let path = Path("../../../resources/hidefile")
        zipFile.addFolder(path, parameters: zipParameters, checkSplitArchive: true)
        let zipFile1 = ZipFile("hidefile.zip")
        Directory.create("contrast/82", recursive: true)
        zipFile1.extractAll("./contrast/82")
        let input: File = File("contrast/82/hidefile/456.txt", Open(true, false))
        let input1: File = File("../../../resources/hidefile/456.txt", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }
}
