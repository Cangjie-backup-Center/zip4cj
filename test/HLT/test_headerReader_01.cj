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
import  charset.*
import  charset.encoding.*
import  zip4cj.*
@Test
public class HeaderReaderTest { 

    @TestCase
    func HeaderReader01(): Unit {
        var headerReader = HeaderReader()
        var file = RandomAccessFile(File("a.txt", OpenOption.Open(true, false)))
        var zip4cjConfig = Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true)
        try {
            headerReader.readAllHeaders(file,zip4cjConfig)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Zip file size less than minimum expected zip file size. Probably not a zip file or a corrupted zip file")
        }
    }

    @TestCase
    func HeaderReader02(): Unit {
        var headerReader = HeaderReader()
        var file = RandomAccessFile(File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)))
        var zip4cjConfig = Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true)
        try {
            headerReader.readAllHeaders(file,zip4cjConfig)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Zip file size less than minimum expected zip file size. Probably not a zip file or a corrupted zip file")
        }
    }


    @TestCase
    func HeaderReader03(): Unit {
        var headerReader = HeaderReader()
        var file = RandomAccessFile(File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false)))
        var zip4cjConfig = Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true)
        try {
            headerReader.readAllHeaders(file,zip4cjConfig)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Zip file size less than minimum expected zip file size. Probably not a zip file or a corrupted zip file")
        }
    }

    @TestCase
    func HeaderReader04(): Unit {
        var headerReader = HeaderReader()
        var file = File("a.txt", OpenOption.Open(true, false))
        try {
            headerReader.readLocalFileHeader(file,None).getOrThrow()
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Could not fill buffer")
        }
    }
    @TestCase
    func HeaderReader05(): Unit {
        var headerReader = HeaderReader()
        var file = File("invalid_zip_file_size_less_than_22kb.zip", OpenOption.Open(true, false))
        try {
            headerReader.readLocalFileHeader(file,None).getOrThrow()
        } catch (e: NoneValueException) {
            @Assert(e.toString() , "NoneValueException")
        }
    }
    @TestCase
    func HeaderReader06(): Unit {
        var headerReader = HeaderReader()
        var file = File("file_name_size_is_0_in_local_file_header", OpenOption.Open(true, false))
        try {
            headerReader.readLocalFileHeader(file,None).getOrThrow()
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Invalid entry name in local file header")
        }
    }

    @TestCase
    func HeaderReader07(): Unit {
        var headerReader = HeaderReader()
        try {
            headerReader.isDirectory(Array<Byte>(),None)
        } catch (e: IndexOutOfBoundsException) {
            @Assert(e.toString() , "IndexOutOfBoundsException: Index 0 out of bounds for length 0")
        }
    }

    @TestCase
    func HeaderReader08(): Unit {
        var headerReader = HeaderReader()
        var src = headerReader.isDirectory(Array<Byte>(100,item:0),None)
        @Assert(src , false)
    }

    @TestCase
    func HeaderReader09(): Unit {
        var headerReader = HeaderReader()
        var src = headerReader.isDirectory(Array<Byte>(100,item:0),"MobaXterm.2024-01-08_17.08.ini")
        @Assert(src , false)
    }

    @TestCase
    func HeaderReader10(): Unit {
        var headerReader = HeaderReader()
        var src = headerReader.isDirectory(Array<Byte>(100,item:0),"")
        @Assert(src , false)
    }

    @TestCase
    func HeaderReader11(): Unit {
        var headerReader = HeaderReader()
        var src = headerReader.isDirectory(Array<Byte>(96,item:0),"jar-dir-lfh-and-fh-entry-size-2.jar")
        @Assert(src , false)
    }
}

