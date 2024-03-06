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

//sources_file:1234.txt:MP4.mp4:archive-with-no-dir-entries1.zip:a.txt:1COMM_v24tagswithalbumimage1.mp3:missing_exended_local_file_header.zip:ab.txt:1COMM_v24tagswithalbumimagea.mp3
//sources_file:end_of_cen_dir_not_at_expected_position.zip:video.zip:yinpin.mp4:archive-with-no-dir-entriesaa.zip:missing_exended_local_file_headera.zip
@Test
public class ZipFileTest {
    @TestCase
    func ZipFile01(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("output12345.zip")
        let files = [Path("1234.txt")]
        try {
            zipFile.createSplitZipFile(files, zipParameters, true, 2)
        } catch (e: ZipException) {
            @Assert(e.toString(),"ZipException: split length less than minimum allowed split length of 65536 Bytes")
        }
    }

    @TestCase
    func ZipFile02(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("output12345.zip")
        let files = [Path("123.txt")]
        try {
            zipFile.createSplitZipFile(files, zipParameters, true, 1)
        } catch (e: ZipException) {
            @Assert(e.toString(),"ZipException: split length less than minimum allowed split length of 65536 Bytes")
        }
    }

    @TestCase
    func ZipFile03(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("output123456.zip")
        let files = [Path("123.txt")]
        try {
            zipFile.createSplitZipFile(files, zipParameters, true, 0)
        } catch (e: ZipException) {
            @Assert(e.toString(),"ZipException: split length less than minimum allowed split length of 65536 Bytes")
        }
    }

    @TestCase
    func ZipFile04(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        Directory.create("contrastp/p", recursive: true)
        let zipFile = ZipFile("contrastp/p/yinpin.mp4.zip")
        let files = Path("yinpin.mp4")
        zipFile.createSplitZipFile([files], zipParameters, true, 65536)
        let zipFile1 = ZipFile("contrastp/p/yinpin.mp4.zip")
        Directory.create("contrastp/y", recursive: true)
        zipFile1.extractAll("./contrastp/y")
        let input: File = File("contrastp/y/yinpin.mp4", Open(true, true))
        let input1: File = File("yinpin.mp4", Open(true, true))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile05(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        Directory.create("contrast/26", recursive: true)
        let zipFile = ZipFile("contrast/26/MP4.mp4.zip")
        let path = [Path("MP4.mp4")]
        zipFile.createSplitZipFile(path, zipParameters, true, 65536)

        let zipFile1 = ZipFile("contrast/26/MP4.mp4.zip")
        Directory.create("contrast/261")
        zipFile1.extractAll("./contrast/261")
        let input: File = File("contrast/261/MP4.mp4", Open(true, true))
        let input1: File = File("MP4.mp4", Open(true, true))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile06(): Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        Directory.create("contrast/m", recursive: true)
        let zipFile = ZipFile("contrast/m/MP4.mp4.zip")
        let path = Path("../../../resources/123")
        zipFile.createSplitZipFileFromFolder(path, zipParameters, true, 65536)
        let zipFile1 = ZipFile("contrast/m/MP4.mp4.zip")
        Directory.create("contrast/n", recursive: true)
        zipFile1.extractAll("./contrast/n")
        let input: File = File("contrast/n/123/MP4.mp4", Open(true, true))
        let input1: File = File("../../../resources/123/MP4.mp4", Open(true, true))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile07(): Unit {
        let zipFile = ZipFile("archive-with-no-dir-entriesaa.zip")
        zipFile.setRunInThread(false);
        Directory.create("contrast/z", recursive: true)
        zipFile.extractAll("./contrast/z");
        @Assert(zipFile.isRunInThread(),false)
        @Assert(zipFile.toString(),"archive-with-no-dir-entriesaa.zip")
    }

    @TestCase
    func ZipFile08(): Unit {
        Directory.create("contrast/w", recursive: true)
        var zipFile = ZipFile(Path("contrast/w/addfiles.zip"))
        zipFile.addFile("ab.txt")
        zipFile.addFile(Path("1COMM_v24tagswithalbumimagea.mp3"), parameters: ZipParameters())
        var paths = [Path("missing_exended_local_file_headera.zip")]
        zipFile.addFiles(paths, parameters: ZipParameters())

        let zipFile1 = ZipFile("contrast/w/addfiles.zip")
        zipFile1.extractAll("./contrast/ww")
        let input: File = File("contrast/ww/1COMM_v24tagswithalbumimagea.mp3", Open(true, true))
        let input1: File = File("1COMM_v24tagswithalbumimagea.mp3", Open(true, true))
        @Assert(input.readToEnd(),input1.readToEnd())
        let input2: File = File("contrast/ww/ab.txt", Open(true, true))
        let input3: File = File("ab.txt", Open(true, true))
        @Assert(input2.readToEnd(),input3.readToEnd())
        let input4: File = File("contrast/ww/missing_exended_local_file_headera.zip", Open(true, true))
        let input5: File = File("missing_exended_local_file_headera.zip", Open(true, true))
        @Assert(input4.readToEnd(),input5.readToEnd())
    }

    @TestCase
    func ZipFile09(): Unit {
        Directory.create("contrast/30", recursive: true)
        var zipFile = ZipFile(Path("contrast/30/addfiles.zip"))
        zipFile.addFile("a.txt")
        zipFile.addFolder(Path("../../../resources/ppt"), parameters: ZipParameters(), checkSplitArchive: true)
        let zipFile1 = ZipFile("contrast/30/addfiles.zip")
        Directory.create("contrast/301")
        zipFile1.extractAll("./contrast/301")
        let input2: File = File("contrast/301/a.txt", Open(true, true))
        let input3: File = File("a.txt", Open(true, true))
        @Assert(input2.readToEnd(),input3.readToEnd())
        let input4: File = File("contrast/301/ppt/libssl.so.3", Open(true, true))
        let input5: File = File("../../../resources/ppt/libssl.so.3", Open(true, true))
        @Assert(input4.readToEnd(),input5.readToEnd())
    }

    @TestCase
    func ZipFile10(): Unit {
        let zipParameters = ZipParameters()
        let files = Array<String>(["mimetype", "META-INF/container.xml"])
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("end_of_cen_dir_not_at_expected_position.zip")
        zipFile.removeFiles(files)
        Directory.create("contrast/d", recursive: true)
        zipFile.extractAll("./contrast/d")
        let zipFile1 = ZipFile("end_of_cen_dir_not_at_expected_position.zip")
        Directory.create("contrast/e", recursive: true)
        zipFile1.extractAll("./contrast/e")
        let input: File = File("contrast/d/OEBPS/toc.ncx", Open(true, false))
        let input1: File = File("contrast/e/OEBPS/toc.ncx", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile11(): Unit {
        let zipParameters = ZipParameters()
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("end_of_cen_dir_not_at_expected_position.zip")
        try {
            zipFile.renameFile(FileHeader(), "123")
        } catch (e: NoneValueException) {
            @Assert(e.toString(),"NoneValueException: The fileName of the FileHeader class is None.")
        }
    }

    @TestCase
    func ZipFile12(): Unit {
        let zipParameters = ZipParameters()
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("video.zip")
        var fileheader = FileHeader()
        fileheader.setFileName("MP41.mp4")
        zipFile.renameFile(fileheader, "123.mp4")
        Directory.create("contrast/h", recursive: true)
        zipFile.extractAll("./contrast/h")
        @Assert(File.exists("contrast/h/123.mp4"),true)
    }

    @TestCase
    func ZipFile13(): Unit {
        let zipParameters = ZipParameters()
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("video.zip")
        var fileheader = FileHeader()
        fileheader.setFileName("MP41.mp4")
        try {
            zipFile.renameFile(fileheader, " ")
        } catch (e: ZipException) {
            @Assert(e.toString(),"ZipException: newFileName is None or empty")
        }
    }
}
