// RESOURCES: output.zip
// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import  zip4cj.util.*
import  zip4cj.model.*
import  zip4cj.tasks.*
import  zip4cj.progress.*
import  zip4cj.exception.*
import  zip4cj.io.outputstream.*
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*
import charset4cj.charset.*
import charset4cj.charset.encoding.*
main() { 

    let test = tasksTest()
    test.tasksTest01()
    test.tasksTest02()
    test.tasksTest03()
    test.tasksTest04()
    test.tasksTest05()
    return 0
}
@Test
public class tasksTest {

    @TestCase
    public func tasksTest01(): Unit {
        FileUtils()
        SetCommentTask(ZipModel(),AsyncTaskParameters(ExecutorService(),true,ProgressMonitor()))
        var sc = VersionMadeBy.WINDOWS
        let src = sc.getCode()
        var sc1 = VersionNeededToExtract.ZIP_64_FORMAT 
        var sc2 = VersionNeededToExtract.AES_ENCRYPTED  
        let src1 =sc1.getCode()
        let src2 =sc2.getCode()
        @Assert(src, 0)
        @Assert(src1, 45)
        @Assert(src2, 51)
    }

    @TestCase
    public func tasksTest02(): Unit {
        var sc = MergeSplitZipFileTask(ZipModel(),AsyncTaskParameters(ExecutorService(),true,ProgressMonitor()))
        ExtractFileTask(ZipModel(),Array<Rune>(),UnzipParameters(),AsyncTaskParameters(ExecutorService(),true,ProgressMonitor()))
        ExecutorService.new()
        AddStreamToZipTask(ZipModel(),Array<Rune>(),HeaderWriter(),AsyncTaskParameters(ExecutorService(),true,ProgressMonitor()))
        AddStreamToZipTaskParameters(ByteArrayStream(),ZipParameters(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
    }

    @TestCase
    public func tasksTest03(): Unit {
        var returnTag = 0
        try {
            FileUtils.getFilesInDirectoryRecursive(Path("123.txt"),ZipParameters())
        }catch (e: FSException) {
            returnTag = 1
        }
        @Assert(returnTag, 0)
    }

    @TestCase
    public func tasksTest04(): Unit {
        let sc = ZipException("")
        @Assert(sc.toString(), "ZipException")
    }

    @TestCase
    public func tasksTest05(): Unit {
        let s1 = ZipExceptionType.WRONG_PASSWORD
        let s2 = ZipExceptionType.TASK_CANCELLED_EXCEPTION
        let s3 = ZipExceptionType.CHECKSUM_MISMATCH
        let s4 = ZipExceptionType.UNKNOWN_COMPRESSION_METHOD
        let s5 = ZipExceptionType.FILE_NOT_FOUND
        let s6 = ZipExceptionType.UNSUPPORTED_ENCRYPTION
        let s7= ZipExceptionType.UNKNOWN
        let sc = ZipException("input size > 0")
        @Assert(sc.toString(), "ZipException: input size > 0")
    }

}