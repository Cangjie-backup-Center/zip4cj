// RESOURCES: output.zip
// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import  zip4cj.util.*
from zip4cj import  zip4cj.model.*
from zip4cj import  zip4cj.tasks.*
from zip4cj import  zip4cj.progress.*
from zip4cj import  zip4cj.exception.*
from zip4cj import  zip4cj.io.outputstream.*
from std import collection.*
from std import fs.*
from std import io.*
from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.encoding.*
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
        ExtractFileTask(ZipModel(),Array<Char>(),UnzipParameters(),AsyncTaskParameters(ExecutorService(),true,ProgressMonitor()))
        ExecutorService.new()
        AddStreamToZipTask(ZipModel(),Array<Char>(),HeaderWriter(),AsyncTaskParameters(ExecutorService(),true,ProgressMonitor()))
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