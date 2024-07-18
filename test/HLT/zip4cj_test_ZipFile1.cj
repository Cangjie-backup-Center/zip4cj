//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*
import std.os.*
import std.os.posix.*
import  charset.*
import  charset.encoding.*
import  zip4cj.*

//sources_file:öüäöäö.rar:öüäöäö.zip:contrastFile/öüäöäö.rar:1COMM_v24tagswithalbumimage1.mp3:123.txt:file_name_size_is_0_in_local_file_header1:libssl.so.3
//sources_file:contrastFile/libssl.so.3.rar:unexpected-eof-when-reading-stream:a.txt:after_deflate_remaining_bytes.bin:libssl/libssl.so.3:file_name_size_is_0_in_local_file_header2
//sources_file:file_name_size_is_0_in_local_file_header3:alibssl.so.3
@Test
public class ZipFileTest {
    @TestCase
    func ZipFile01(): Unit {
        let zipFile = ZipFile("öüäöäö.rar")
        try {
            zipFile.extractAll("./")
        } catch (e: Exception) {
            @Assert(e.toString(),"ZipException: Zip headers not found. Probably not a zip file")
        }
    }

    @TestCase
    func ZipFile02(): Unit {
        var byte = Array<Rune>([])
        let zipFile = ZipFile("öüäöäö.zip", password: byte)
        zipFile.extractAll("./");
        let input: File = File("contrastFile/öüäöäö.rar", Open(true, false))
        let input1: File = File("öüäöäö.rar", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile03(): Unit {
        let zipFile = ZipFile("1COMM_v24tagswithalbumimage1.mp3")
        try {
            zipFile.extractAll("./")
        } catch (e: Exception) {
            @Assert(e.toString(),"ZipException: Zip headers not found. Probably not a zip file")
        }
    }

    @TestCase
    func ZipFile04(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("output1234.zip")
        let files = [Path("123.txt")]
        zipFile.createSplitZipFile(files, zipParameters, false, 20)
        let zipFile1 = ZipFile("output1234.zip")
        zipFile1.extractAll("./contrast/f")
        let input: File = File("contrast/f/123.txt", Open(true, false))
        let input1: File = File("123.txt", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile05(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("contrast_file_name_size_is_0_in_local_file_header1.zip")
        let files = [Path("file_name_size_is_0_in_local_file_header1")]
        try {
            zipFile.createSplitZipFile(files, zipParameters, true, 20)
        } catch (e: Exception) {
            @Assert(e.toString(),"ZipException: split length less than minimum allowed split length of 65536 Bytes")
        }
    }

    @TestCase
    func ZipFile06(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("contrast_file_name_size_is_0_in_local_file_header3.zip")
        let files = [Path("file_name_size_is_0_in_local_file_header3")]
        zipFile.createSplitZipFile(files, zipParameters, false, 20)
        let zipFile1 = ZipFile("contrast_file_name_size_is_0_in_local_file_header3.zip")
        zipFile1.extractAll("./contrast/a")
        let input: File = File("contrast/a/file_name_size_is_0_in_local_file_header3", Open(true, false))
        let input1: File = File("file_name_size_is_0_in_local_file_header3", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile07(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("cangjie111.zip")
        let files = [Path("cangjie1111")]
        try {
            zipFile.createSplitZipFile(files, zipParameters, false, 20)
        } catch (e: Exception) {
            @Assert(e.toString(),"ZipException: The path `cangjie1111` does not exist")
        }
    }

    @TestCase
    func ZipFile08(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("cangjieabc.zip")
        let files = [Path(" ")]
        try {
            zipFile.createSplitZipFile(files, zipParameters, false, 20)
        } catch (e: Exception) {
            @Assert(e.toString(),"ZipException: The path ` ` does not exist")
        }
    }

    @TestCase
    func ZipFile09(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("alibssl.so.3.rar")
        let files = Path("alibssl.so.3")
        zipFile.createSplitZipFile([files], zipParameters, false, 20)
        let zipFile1 = ZipFile("alibssl.so.3.rar")
        zipFile1.extractAll("./contrast/b")
        let input: File = File("contrast/b/alibssl.so.3", Open(true, false))
        let input1: File = File("alibssl.so.3", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile10(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("libssl.so.3.7z")
        let files = Path("libssl")
        zipFile.createSplitZipFileFromFolder(files, zipParameters, false, 20)
        let zipFile1 = ZipFile("libssl.so.3.7z")
        zipFile1.extractAll("./contrast/31")
        let input: File = File("contrast/31/libssl/libssl.so.3", Open(true, false))
        let input1: File = File("libssl/libssl.so.3", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile11(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("libssl.so.3.mp4")
        let files = Path("libssl")
        zipFile.createSplitZipFileFromFolder(files, zipParameters, false, 20)
        let zipFile1 = ZipFile("libssl.so.3.mp4")
        zipFile1.extractAll("./contrast/4")
        let input: File = File("contrast/4/libssl/libssl.so.3", Open(true, false))
        let input1: File = File("libssl/libssl.so.3", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }


    @TestCase
    func ZipFile12(): Unit {
        let zipParameters = ZipParameters()
        zipParameters.setFileNameInZip("123741")
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("unexpected-eof-when-reading-stream111.zip")
        let files = File("unexpected-eof-when-reading-stream", Open(true, false))
        zipFile.createSplitZipFile(files, zipParameters, false, 20)
        let zipFile1 = ZipFile("unexpected-eof-when-reading-stream111.zip")
        zipFile1.extractAll("./contrast/l")
        let input: File = File("contrast/l/123741", Open(true, false))
        let input1: File = File("unexpected-eof-when-reading-stream", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile13(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("abdmix.zip")
        let files = [Path("a.txt"), Path("after_deflate_remaining_bytes.bin")]
        zipFile.createSplitZipFile(files, zipParameters, false, 20)
        let zipFile1 = ZipFile("abdmix.zip")
        Directory.create("contrast/c")
        zipFile1.extractAll("./contrast/c")
        let input: File = File("contrast/c/a.txt", Open(true, false))
        let input1: File = File("a.txt", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
        let input2: File = File("contrast/c/after_deflate_remaining_bytes.bin", Open(true, false))
        let input3: File = File("after_deflate_remaining_bytes.bin", Open(true, false))
        @Assert(input2.readToEnd(),input3.readToEnd())
    }

    @TestCase
    func ZipFile14(): Unit {
        var a = 0
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("pptabc.zip")
        let files = [Path("../../../resources/ppt")]
        try {
            zipFile.createSplitZipFile(files, zipParameters, false, 20)
        } catch (e: Exception) {
            a++
        }
        @Assert(a,0)
    }

    @TestCase
    func ZipFile15(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("ppt1.zip")
        let path = Path("../../../resources/ppt")
        zipFile.addFolder(path, parameters: zipParameters, checkSplitArchive: true)
        let zipFile1 = ZipFile("ppt1.zip")
        Directory.create("contrast/7")
        zipFile1.extractAll("./contrast/7")
        let input: File = File("contrast/7/ppt/libssl.so.3", Open(true, false))
        let input1: File = File("../../../resources/ppt/libssl.so.3", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile16(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        zipParameters.setReadHiddenFiles(false)
        let zipFile = ZipFile("hidefile.zip")
        let path = Path("../../../resources/hidefile")
        zipFile.addFolder(path, parameters: zipParameters, checkSplitArchive: true)
        let zipFile1 = ZipFile("hidefile.zip")
        Directory.create("contrast/8", recursive: true)
        zipFile1.extractAll("contrast/8")
        let input: File = File("contrast/8/hidefile/456.txt", Open(true, false))
        let input1: File = File("../../../resources/hidefile/456.txt", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }
}
