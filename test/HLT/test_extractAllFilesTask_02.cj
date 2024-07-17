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
        AbstractAddFileToZipTasks<String>(ZipModel(),None,HeaderWriter(),AsyncTaskParameters(None,true,ProgressMonitor()))
        AbstractAddFileToZipTasks<String>(ZipModel(),Array<Rune>(),HeaderWriter(),AsyncTaskParameters(None,true,ProgressMonitor()))
        AbstractAddFileToZipTasks<String>(ZipModel(),Array<Rune>(100,item: r'c'),HeaderWriter(),AsyncTaskParameters(None,true,ProgressMonitor()))
        var aesVersion=AesVersion.getFromVersionNumber(1)
        @Assert(aesVersion.getVersionNumber(), 1)
    }

    @TestCase
    func ExtractAllFilesTask02(): Unit {
        ExtractAllFilesTaskParameters("",Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        ExtractAllFilesTaskParameters("454533",Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        ExtractAllFilesTaskParameters("@#$@$@$@n;l;",Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),0,false))
        ExtractAllFilesTaskParameters("你好@#$@$@$@n;l;",Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),11121,false))
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_256
        @Assert(aesKeyStrength.getSaltLength(), 16)
    }

    @TestCase
    func ExtractAllFilesTask03(): Unit {
        RemoveFilesFromZipTaskParameters(ArrayList<String>(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        RemoveFilesFromZipTaskParameters(ArrayList<String>(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),0,true))
        RemoveFilesFromZipTaskParameters(ArrayList<String>(["dsad"]),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,false))
        RemoveFilesFromZipTaskParameters(ArrayList<String>(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),-16565,false))
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_192
        @Assert(aesKeyStrength.getSaltLength(), 12)
    }

    @TestCase
    func ExtractAllFilesTask04(): Unit {
        AddFolderToZipTaskParameters(Path("a.txt"),ZipParameters(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        AddFolderToZipTaskParameters(Path("archive_with_invalid_zip64_headers.zip"),ZipParameters(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),0,true))
        AddFolderToZipTaskParameters(Path(""),ZipParameters(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,false))
        AddFolderToZipTaskParameters(Path("jar-dir-lfh-and-fh-entry-size-2.jar"),ZipParameters(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),-16565,false))
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_192
        @Assert(aesKeyStrength.getSaltLength(), 12)
    }

    @TestCase
    func ExtractAllFilesTask05(): Unit {
        AddStreamToZipTaskParameters(File("a.txt", OpenOption.Open(true, false)),ZipParameters(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        AddStreamToZipTaskParameters(File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)),ZipParameters(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),0,true))
        AddStreamToZipTaskParameters(ByteArrayStream(),ZipParameters(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,false))
        AddStreamToZipTaskParameters(File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false)),ZipParameters(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),-16565,false))
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_128
        @Assert(aesKeyStrength.getSaltLength(), 8)
    }

    @TestCase
    func ExtractAllFilesTask06(): Unit {
        ExtractFileTaskParameters("","","",Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        ExtractFileTaskParameters("454533","dsad","",Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        ExtractFileTaskParameters("@#$@$@$@n;l;","","41564",Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),0,false))
        ExtractFileTaskParameters("你好@#$@$@$@n;l;","","",Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),11121,false))
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_256
        @Assert(aesKeyStrength.getSaltLength(), 16)
    }

    @TestCase
    func ExtractAllFilesTask07(): Unit {
        MergeSplitZipFileTaskParameters(Path("a.txt"),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        MergeSplitZipFileTaskParameters(Path("archive_with_invalid_zip64_headers.zip"),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),0,true))
        MergeSplitZipFileTaskParameters(Path("jar-dir-lfh-and-fh-entry-size-2.jar"),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),-16565,false))
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_128
        @Assert(aesKeyStrength.getSaltLength(), 8)
    }

    @TestCase
    func ExtractAllFilesTask08(): Unit {
        RenameFilesTaskParameters(HashMap<String, String>(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        RenameFilesTaskParameters(HashMap<String, String>(10),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),0,true))
        RenameFilesTaskParameters(HashMap<String, String>(100),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),-16565,false))
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_128
        @Assert(aesKeyStrength.getSaltLength(), 8)
    }

    @TestCase
    func ExtractAllFilesTask09(): Unit {
        SetCommentTaskTaskParameters("",Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        SetCommentTaskTaskParameters("454564",Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),0,true))
        SetCommentTaskTaskParameters("asdasd#$",Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),-16565,false))
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_128
        @Assert(aesKeyStrength.getSaltLength(), 8)
    }

    @TestCase
    func ExtractAllFilesTask10(): Unit {
        AddFilesToZipTaskParameters(ArrayList<Path>(),ZipParameters(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true))
        AddFilesToZipTaskParameters(ArrayList<Path>(),ZipParameters(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),0,true))
        AddFilesToZipTaskParameters(ArrayList<Path>(10),ZipParameters(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,false))
        AddFilesToZipTaskParameters(ArrayList<Path>(5),ZipParameters(),Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),-16565,false))
        var aesKeyStrength=AesKeyStrength.KEY_STRENGTH_128
        @Assert(aesKeyStrength.getRawCode(), 1)
    }
}

public class AbstractAddFileToZipTasks<T> <: AbstractAddFileToZipTask<T> {
    public init(
        zipModel: ZipModel,
        password: ?Array<Rune>,
        headerWriter: HeaderWriter,
        asyncTaskParameters: AsyncTaskParameters
    ) {
        super(zipModel,password,headerWriter,asyncTaskParameters)
    }

    protected func executeTask(_: T, _: ProgressMonitor): Unit{

    }

    protected func calculateTotalWork(_: T): Int64{
        return 1
    }
}