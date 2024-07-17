//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
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
        ExtractAllFilesTask(ZipModel(),None,UnzipParameters(),AsyncTaskParameters(None,true,ProgressMonitor()))
        ExtractAllFilesTask(ZipModel(),Array<Rune>(),UnzipParameters(),AsyncTaskParameters(None,true,ProgressMonitor()))
        ExtractAllFilesTask(ZipModel(),Array<Rune>(100,item: r'c'),UnzipParameters(),AsyncTaskParameters(None,true,ProgressMonitor()))
        var aesVersion=AesVersion.getFromVersionNumber(1)
        @Assert(aesVersion.getVersionNumber(), 1)
    }

    @TestCase
    func ExtractAllFilesTask02(): Unit {
        AddStreamToZipTask(ZipModel(),None,HeaderWriter(),AsyncTaskParameters(None,true,ProgressMonitor()))
        AddStreamToZipTask(ZipModel(),Array<Rune>(),HeaderWriter(),AsyncTaskParameters(None,true,ProgressMonitor()))
        AddStreamToZipTask(ZipModel(),Array<Rune>(100,item: r'c'),HeaderWriter(),AsyncTaskParameters(None,true,ProgressMonitor()))
        var aesVersion=AesVersion.getFromVersionNumber(2)
        @Assert(aesVersion.getVersionNumber(), 2)
    }

    @TestCase
    func ExtractAllFilesTask03(): Unit {
        ExecutorService()
        let sc = ExecutorService.new()
        sc.execute(names)
        sc.shutdown()
        var aesKeyStrength=AesKeyStrength.getAesKeyStrengthFromRawCode(3)
        @Assert(aesKeyStrength.getOrThrow().getRawCode(), 3)
    }

    @TestCase
    func ExtractAllFilesTask04(): Unit {
        let sc = ExecutorService.new()
        AsyncTaskParameters(sc,true,ProgressMonitor())
        AsyncTaskParameters(ExecutorService(),true,ProgressMonitor())
        AsyncTaskParameters(ExecutorService(),false,ProgressMonitor())
        var aesKeyStrength=AesKeyStrength.getAesKeyStrengthFromRawCode(3)
        @Assert(aesKeyStrength.getOrThrow().getRawCode(), 3)
    }

    @TestCase
    func ExtractAllFilesTask05(): Unit {
        AsyncZipTasks<String>(AsyncTaskParameters(None,true,ProgressMonitor()))
        AsyncZipTasks<String>(AsyncTaskParameters(None,false,ProgressMonitor()))
        var aesKeyStrength=AesKeyStrength.getAesKeyStrengthFromRawCode(3)
        @Assert(aesKeyStrength.getOrThrow().getRawCode(), 3)
    }

    @TestCase
    func ExtractAllFilesTask06(): Unit {
        MergeSplitZipFileTask(ZipModel(),AsyncTaskParameters(None,true,ProgressMonitor()))
        MergeSplitZipFileTask(ZipModel(),AsyncTaskParameters(None,false,ProgressMonitor()))
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_256
        @Assert(aesKeyStrength.getSaltLength(), 16)
    }

    @TestCase
    func ExtractAllFilesTask07(): Unit {
        AbstractExtractFileTasks<String>(ZipModel(),UnzipParameters(),AsyncTaskParameters(None,true,ProgressMonitor()))
        AbstractExtractFileTasks<String>(ZipModel(),UnzipParameters(),AsyncTaskParameters(None,false,ProgressMonitor()))
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_256
        @Assert(aesKeyStrength.getSaltLength(), 16)
    }

    @TestCase
    func ExtractAllFilesTask08(): Unit {
        AddFilesToZipTask(ZipModel(),None,HeaderWriter(),AsyncTaskParameters(None,true,ProgressMonitor()))
        AddFilesToZipTask(ZipModel(),Array<Rune>(),HeaderWriter(),AsyncTaskParameters(None,false,ProgressMonitor()))
        AddFilesToZipTask(ZipModel(),Array<Rune>(1000,item: r'c'),HeaderWriter(),AsyncTaskParameters(None,false,ProgressMonitor()))
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_256
        @Assert(aesKeyStrength.getSaltLength(), 16)
    }

    @TestCase
    func ExtractAllFilesTask09(): Unit {
        RemoveFilesFromZipTask(ZipModel(),HeaderWriter(),AsyncTaskParameters(None,true,ProgressMonitor()))
        RemoveFilesFromZipTask(ZipModel(),HeaderWriter(),AsyncTaskParameters(None,false,ProgressMonitor()))
        RemoveFilesFromZipTask(ZipModel(),HeaderWriter(),AsyncTaskParameters(ExecutorService(),false,ProgressMonitor()))
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_256
        @Assert(aesKeyStrength.getSaltLength(), 16)
    }
}
func names() {
    println("dsad--")
}

public class AsyncZipTasks<T> <: AsyncZipTask<T> {
    public init(asyncTaskParameters: AsyncTaskParameters) {
        super(asyncTaskParameters)
    }
    public func execute(_: T) {

    }

    protected func executeTask(_: T, _: ProgressMonitor): Unit {

    }

    protected func calculateTotalWork(_: T): Int64 {
        return 0
    }

    protected func getTask(): ProgressMonitorTask {
        return ProgressMonitorTask.REMOVE_ENTRY
    }
}

public class AbstractExtractFileTasks<T> <: AbstractExtractFileTask<T> {
    public init(zipModel: ZipModel, unzipParameters: UnzipParameters, asyncTaskParameters: AsyncTaskParameters) {
        super(zipModel,unzipParameters,asyncTaskParameters)
    }

    protected func executeTask(_: T, _: ProgressMonitor): Unit{

    }
    protected func calculateTotalWork(_: T): Int64{
        return 1
    }
}