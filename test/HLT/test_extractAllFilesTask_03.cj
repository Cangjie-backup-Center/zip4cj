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
public class ExtractAllFilesTaskTest {

    @TestCase
    func ExtractAllFilesTask01(): Unit {
        AddFolderToZipTask(ZipModel(),None,HeaderWriter(),AsyncTaskParameters(None,true,ProgressMonitor()))
        AddFolderToZipTask(ZipModel(),Array<Rune>(),HeaderWriter(),AsyncTaskParameters(None,true,ProgressMonitor()))
        AddFolderToZipTask(ZipModel(),Array<Rune>(100,item: r'c'),HeaderWriter(),AsyncTaskParameters(None,true,ProgressMonitor()))
        var aesVersion=AesVersion.getFromVersionNumber(2)
        @Assert(aesVersion.getVersionNumber(), 2)
    }

    @TestCase
    func ExtractAllFilesTask02(): Unit {
        ExtractFileTask(ZipModel(),None,UnzipParameters(),AsyncTaskParameters(None,true,ProgressMonitor()))
        ExtractFileTask(ZipModel(),Array<Rune>(),UnzipParameters(),AsyncTaskParameters(None,true,ProgressMonitor()))
        ExtractFileTask(ZipModel(),Array<Rune>(100,item: r'c'),UnzipParameters(),AsyncTaskParameters(None,true,ProgressMonitor()))
        var aesVersion=AesVersion.getFromVersionNumber(2)
        @Assert(aesVersion.getVersionNumber(), 2)
    }

    @TestCase
    public func ExtractAllFilesTask03(): Unit {
        let sc = ZipException("asc > 0",ZipExceptionType.CHECKSUM_MISMATCH)
        sc.getType()
        @Assert(sc.toString(), "ZipException: asc > 0")
    }

    @TestCase
    public func ExtractAllFilesTask04(): Unit {
        let sc = ZipException("input file List is None, cannot create zip file", ZipExceptionType.TASK_CANCELLED_EXCEPTION)
        let scc = sc.toString()
        @Assert(scc, "ZipException: input file List is None, cannot create zip file")
    }

    @TestCase
    public func ExtractAllFilesTask05(): Unit {
        let sc = ZipException("Encryption method has to be set when encryptFiles flag is set in zip parameters", ZipExceptionType.WRONG_PASSWORD)
        sc.getType()
        ZipException("", ZipExceptionType.UNKNOWN_COMPRESSION_METHOD)
        ZipException("", ZipExceptionType.FILE_NOT_FOUND)
        ZipException("", ZipExceptionType.UNSUPPORTED_ENCRYPTION)
        ZipException("", ZipExceptionType.UNKNOWN)
        @Assert(sc.toString(), "ZipException: Encryption method has to be set when encryptFiles flag is set in zip parameters")
    }
}

