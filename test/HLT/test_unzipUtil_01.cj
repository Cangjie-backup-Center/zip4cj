//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
// sources_file:a.txt
// sources_file:archive_with_invalid_zip64_headers.zip
// sources_file:jar-dir-lfh-and-fh-entry-size-2.jar
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
public class CipherInputStreamTest { 

    @TestCase
    func CipherInputStream01(): Unit {
        var zipModel = ZipModel()
        zipModel.setZipFile(Path("a.txt"))
        try {
            UnzipUtil.createZipInputStream(zipModel,FileHeader(),None)
        } catch (e: ZipException) {
            @Assert(e.toString() , "ZipException: Could not fill buffer")
        }
    }

    @TestCase
    func CipherInputStream02(): Unit {
        var zipModel = ZipModel()
        zipModel.setZipFile(Path("archive_with_invalid_zip64_headers.zip"))
        var src = UnzipUtil.createZipInputStream(zipModel,FileHeader(),None)
        var values = Array<Byte>(1,item: 1)
        @Assert(src.read(values) , -1)
    }

    @TestCase
    func CipherInputStream03(): Unit {
        UnzipUtil.applyFileAttributes(FileHeader(),Path("archive_with_invalid_zip64_headers.zip"))
        var sc = ZipModel()
        @Assert(sc.isSplitArchive() , false)
    }

    @TestCase
    func CipherInputStream04(): Unit {
        UnzipUtil.applyFileAttributes(FileHeader(),Path("45456"))
        var sc = ZipModel()
        @Assert(sc.isNestedZipFile() , false)
    }

    @TestCase
    func CipherInputStream05(): Unit {
        UnzipUtil.applyFileAttributes(FileHeader(),Path("a.txt"))
        var sc = ZipModel()
        @Assert(sc.getStart() , 0)
    }

    @TestCase
    func CipherInputStream06(): Unit {
        UnzipUtil.applyFileAttributes(FileHeader(),Path("jar-dir-lfh-and-fh-entry-size-2.jar"))
        var sc = ZipModel()
        @Assert(sc.getEnd() , 0)
    }

    @TestCase
    func CipherInputStream07(): Unit {
        var zipModel = ZipModel()
        zipModel.setZipFile(Path("archive_with_invalid_zip64_headers.zip"))
        var src = UnzipUtil.createSplitInputStream(zipModel)
        var values = Array<Byte>(123,item: 1)
        @Assert(src.read(values) , 123)
    }

    @TestCase
    func CipherInputStream08(): Unit {
        var zipModel = ZipModel()
        zipModel.setZipFile(Path("a.txt"))
        var src = UnzipUtil.createSplitInputStream(zipModel)
        var values = Array<Byte>(1,item: 1)
        @Assert(src.read(values) , 1)
    }

    @TestCase
    func CipherInputStream09(): Unit {
        var zipModel = ZipModel()
        zipModel.setZipFile(Path("jar-dir-lfh-and-fh-entry-size-2.jar"))
        var src = UnzipUtil.createSplitInputStream(zipModel)
        var values = Array<Byte>(5000,item: 1)
        @Assert(src.read(values) , 5000)
    }
    @TestCase
    func CipherInputStream10(): Unit {
        var zipModel = ZipModel()
        zipModel.setZipFile(Path("jar-dir-lfh-and-fh-entry-size-2.jar"))
        var src = UnzipUtil.createSplitInputStream(zipModel)
        var values = Array<Byte>(100000,item: 1)
        SplitFileInputStreams().prepareExtractionForFileHeader(FileHeader())
        @Assert(src.read(values) , 70637)
    }

    @TestCase
    func CipherInputStream11(): Unit {
        try {
            UnzipUtil.createZipInputStream(ZipModel(),FileHeader(),None)
        } catch (e: NoneValueException) {
            @Assert(e.toString() , "NoneValueException: zipFile is null")
        }
    }

    @TestCase
    func CipherInputStream12(): Unit {
        var zipModel = ZipModel()
        zipModel.setZipFile(Path("a.txt"))
        var src = UnzipUtil.createSplitInputStream(zipModel)
        try {
            src.read()
        } catch (e: IllegalArgumentException) {
            @Assert(e.toString() , "IllegalArgumentException: The buffer is empty.")
        }
    }
}

public class SplitFileInputStreams <: SplitFileInputStream {
    public func prepareExtractionForFileHeader(_: FileHeader): Unit {}
    public func close(): Unit {}
    public func isClosed(): Bool { 
        return true
    }
    public func read(b: Array<Byte>): Int64 {
        return b.size
    }
}
