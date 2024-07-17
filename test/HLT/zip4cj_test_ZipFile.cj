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

//sources_file:MobaXtermbackup.zip:1COMM_v24tagswithalbumimage1.zip:가나다.zip:unexpected-eof-when-reading-stream.zip:MP4.zip:video.zip
//sources_file:contrastFile/MobaXtermbackup/MobaXterm.2024-01-03_11.24.ini:contrastFile/MobaXtermbackup/456/test/123/456.txt:contrastFile/1COMM_v24tagswithalbumimage1.mp3
//sources_file:contrastFile/가나다.abc:contrastFile/unexpected-eof-when-reading-stream:contrastFile/MP41.mp4:contrastFile/d92da22644db9c78297dbfdcbaf25d7d.jpg:contrastFile/MP4.mp4
//sources_file:ppt.zip:contrastFile/ppt/1/2/3/4/5/6/7/8/9.1/9.11/9.12/9.13/9.14/9.15/9.16/9.17/9.18/9.19/123.xls:contrastFile/ppt/1/2/3/4/5.1/ppt.ppt:content_in_entry_which_is_directory.zip
//sources_file:contrastFile/content_in_entry_which_is_directory.jar
@Test
public class ZipFileTest {
    @TestCase
    func ZipFile01(): Unit {
        let zipFile = ZipFile("MobaXtermbackup.zip")
        Directory.create("MobaXtermbackup")
        zipFile.extractAll("./MobaXtermbackup");
        let input: File = File("contrastFile/MobaXtermbackup/MobaXterm.2024-01-03_11.24.ini", Open(true, false))
        let input1: File = File("MobaXtermbackup/MobaXterm.2024-01-03_11.24.ini", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
        let input2: File = File("contrastFile/MobaXtermbackup/456/test/123/456.txt", Open(true, false))
        let input3: File = File("MobaXtermbackup/456/test/123/456.txt", Open(true, false))
        @Assert(input2.readToEnd(),input3.readToEnd())
    }

    @TestCase
    func ZipFile02(): Unit {
        let zipFile = ZipFile("1COMM_v24tagswithalbumimage1.zip")
        zipFile.extractAll("./");
        let input: File = File("contrastFile/1COMM_v24tagswithalbumimage1.mp3", Open(true, false))
        let input1: File = File("1COMM_v24tagswithalbumimage1.mp3", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile03(): Unit {
        let zipFile = ZipFile("가나다.zip")
        zipFile.extractAll("./");
        let input: File = File("contrastFile/가나다.abc", Open(true, false))
        let input1: File = File("가나다.abc", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile04(): Unit {
        let zipFile = ZipFile("unexpected-eof-when-reading-stream.zip")
        zipFile.extractAll("./");
        let input: File = File("contrastFile/unexpected-eof-when-reading-stream", Open(true, false))
        let input1: File = File("unexpected-eof-when-reading-stream", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile05(): Unit {
        let zipFile = ZipFile("MP4.zip")
        zipFile.extractAll("./");
        let input: File = File("contrastFile/MP4.mp4", Open(true, false))
        let input1: File = File("MP4.mp4", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
    }

    @TestCase
    func ZipFile06(): Unit {
        let zipFile = ZipFile("video.zip")
        zipFile.extractAll("./");
        let input: File = File("contrastFile/MP41.mp4", Open(true, false))
        let input1: File = File("MP41.mp4", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
        let input2: File = File("contrastFile/d92da22644db9c78297dbfdcbaf25d7d.jpg", Open(true, false))
        let input3: File = File("d92da22644db9c78297dbfdcbaf25d7d.jpg", Open(true, false))
        @Assert(input2.readToEnd(),input3.readToEnd())
    }

    @TestCase
    func ZipFile07(): Unit {
        let zipFile = ZipFile("ppt.zip")
        zipFile.extractAll("./");
        let input: File = File("contrastFile/ppt/1/2/3/4/5.1/ppt.ppt", Open(true, false))
        let input1: File = File("ppt/1/2/3/4/5.1/ppt.ppt", Open(true, false))
        @Assert(input.readToEnd(),input1.readToEnd())
        let input2: File = File(
            "contrastFile/ppt/1/2/3/4/5/6/7/8/9.1/9.11/9.12/9.13/9.14/9.15/9.16/9.17/9.18/9.19/123.xls",
            Open(true, false))
        let input3: File = File("ppt/1/2/3/4/5/6/7/8/9.1/9.11/9.12/9.13/9.14/9.15/9.16/9.17/9.18/9.19/123.xls",
            Open(true, false))
        @Assert(input2.readToEnd(),input3.readToEnd())
    }

    @TestCase
    func ZipFile08(): Unit {
        let zipFile = ZipFile("content_in_entry_which_is_directory.zip")
        zipFile.extractAll("./");
        let input2: File = File("contrastFile/content_in_entry_which_is_directory.jar", Open(true, false))
        let input3: File = File("content_in_entry_which_is_directory.jar", Open(true, false))
        @Assert(input2.readToEnd(),input3.readToEnd())
    }
}
