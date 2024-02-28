// RESOURCES: MobaXtermbackup.zip
// RESOURCES: 1COMM_v24tagswithalbumimage1.mp3
// RESOURCES: output123.zip
// RESOURCES: missing_exended_local_file_header.zip
// RESOURCES: unexpected-eof-when-reading-stream
// RESOURCES: 123.txt
// RESOURCES: a.txt
// RESOURCES: archive_with_invalid_zip64_headers.zip
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.*
from charset import charset.*
from std import os.posix.*
from std import fs.*
from std import collection.*
from std import io.*
from std import sync.*
from std import random.*
from std import time.*
from std import math.*
from std import unittest.*
from std import unittest.testmacro.*


main() { 
    let test = IssuesFix()
    test.execute()
    test.printResult()
}

@Test
public class IssuesFix {

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I91UHF
    func I91UHF (): Unit {
        try{
            let fileHeader= FileHeader();
            let fileHeaders = ArrayList<FileHeader>(fileHeader, fileHeader, fileHeader, fileHeader, fileHeader, fileHeader);
            println(HeaderUtil.getTotalUncompressedSizeOfAllFileHeaders(HeaderUtil.getFileHeadersUnderDirectory(fileHeaders,  "cangjie")));
            throw Exception()
        } catch (e: NoneValueException) {
            @Assert(e.message.toString(), "FileHeader.getFileName() is null.")
        }
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I91W2J
    func I91W2J () : Unit {
        var zipparameters=ZipParameters()
        var rawio=RawIO()
        var fileheaderfactory=FileHeaderFactory()
        try {
           fileheaderfactory.generateFileHeader(zipparameters,true,0,Charsets.UTF8,rawio) 
        }catch (e:Exception) {
            @Assert(e.toString(),"ZipException: fileNameInZip is null or empty")
        }
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I91X4L
    func I91X4L () : Unit {
        var fileHeader = FileHeader()
        var rawio=RawIO()
        var factory=FileHeaderFactory()
        try {
           factory.generateLocalFileHeader(fileHeader);
        }catch (e:Exception) {
            @Assert(e.toString(),"NoneValueException: FileHeader.getGeneralPurposeFlag() is null")
        }
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I91XKI
    func I91XKI () : Unit {
        var unsetbit = BitUtils.unsetBit(15, -2147483648)
        @Assert(14, unsetbit)
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I91XLU
    func I91XLU () : Unit {
        var unsetbit = BitUtils.isBitSet(125, 213647)
        @Assert(false, unsetbit)
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I91XIX
    func I91XIX () : Unit {
        var unsetbit = BitUtils.setBit(125, 2147483647)
        @Assert(125, unsetbit)
    }
    
    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I92KLA
    func I92KLA () : Unit {
        var fileheader=FileHeader()
        var madeby=fileheader.toString()
        @Assert(madeby, "None")
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I92KL6
    func I92KL6 () : Unit {
        try{
            var fileheader=FileHeader()
            var madeby=fileheader.toString()
        } catch (_) {
            throw Exception()
        }
    }
    
    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I92DB1
    // https://gitee.com/HW-PLLab/zip4cj/issues/I92D6L
    func I92DB1 () : Unit {
        @Assert(HeaderSignature.EXTRA_DATA_RECORD == HeaderSignature.EXTRA_DATA_RECORD, true)
        @Assert(HeaderSignature.EXTRA_DATA_RECORD != HeaderSignature.EXTRA_DATA_RECORD, false)
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I92AIM
    func I92AIM () : Unit {
        try {
            FileUtils.getRelativeFileName(Path("你好"), ZipParameters())
            FileUtils.getRelativeFileName(Path(""), ZipParameters())
        } catch (_) {
            throw Exception()
        }
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I926U8
    func I926U8 () : Unit {
        let byte = Array<Byte>()
        var input = File("MobaXtermbackup.zip", Open(true, true))
        Zip4cjUtil.readFully(input, byte)
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I926LO
    func I926LO () : Unit {
        let sc = FileUtils.getFilesInDirectoryRecursive(Path(""), ZipParameters())
    }


    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I92XWL
    func I92XWL () : Unit {
        @Assert(FileUtils.readSymbolicLink(Path("")), "") 
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I92XKE
    func I92XKE () : Unit {
        let zipParameters = ZipParameters();
        zipParameters.setFileNameInZip("123");
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("I92XKE.zip")
        let files = File("unexpected-eof-when-reading-stream", Open(true, true))
        zipFile.createSplitZipFile(files, zipParameters, false, 20) 
        @Assert(File.exists("I92XKE.zip"), true)
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I92XJ5
    func I92XJ5 () : Unit {
        try {
             let zipParameters = ZipParameters();
            zipParameters.setCompressionMethod(CompressionMethod.STORE)
            let zipFile = ZipFile("I92XJ5.zip")
            let files = File("unexpected-eof-when-reading-stream", Open(true, true))
            zipFile.createSplitZipFile(files, zipParameters, false, 20) 
            throw Exception(" I92XJ5 ")
        } catch (e: ZipException) {
            ()
        }
    } 
    
    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I93PKN?from=project-issue
    func I93PKN () : Unit {
        try {
            let input = File("archive_with_invalid_zip64_headers.zip", Open(true, true))
            var buf:Array<Char>=Array<Char>([])
            var buf1:Array<UInt8>=Array<UInt8>([1,2,3,4,5,6,85,4,2,1,22,1,5,2,1,1,2])
            var config=Zip4cjConfig(Charsets.UTF8,666,true)
            var zipoutputstream=ZipOutputStream(input)//,password: buf,zip4cjConfig: config, zipModel: ZipModel())
            zipoutputstream.write(buf1)
        } catch (e: NoneValueException) {
            @Assert(e.message, "please add an entry first, which requires calling the putNextEntry function before calling the other function operation.")
        }
    }


    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I93TWM?from=project-issue
    func I93TWM () : Unit {
        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        // zipParameters.setFileNameInZip("123")
        // let zipFile = ZipFile("MP4mp4.zip")
        // let files = Path("/home/liyanqing/test/test")
        // zipFile.createSplitZipFileFromFolder(files, zipParameters, true, 65536)
    }
    
    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I93PKN?from=project-issue
    // https://gitee.com/HW-PLLab/zip4cj/issues/I93PLH?from=project-issue
    func I93PLH () : Unit {
        var msg = ""
        try{
            let input = File("archive_with_invalid_zip64_headers.zip", Open(true, false))
            var zipoutputstream=ZipOutputStream(input)
            zipoutputstream.write(0)
        } catch(e: NoneValueException) {
            msg = e.message
        }
        @Assert(msg, "please add an entry first, which requires calling the putNextEntry function before calling the other function operation.")
    }
    
    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I93PP3?from=project-issue
    func I93PP3 () : Unit {
        var msg = ""
        try{
            let input = File("123.txt", Open(true, true))
            let headerwriter = HeaderWriter()
            headerwriter.writeLocalFileHeader(ZipModel(),LocalFileHeader(),input,Charsets.UTF8)
        } catch(e: NoneValueException) {
            msg = e.message
        }
        @Assert(msg, "cannot read the array length because array is None")
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I93YL1?from=project-issue
    func I93YL1 () : Unit {
        var msg = ""
        try{
            UnzipUtil.createZipInputStream(ZipModel(),FileHeader(),None)
        } catch(e: NoneValueException) {
            msg = e.message
        }
        @Assert(msg, "zipFile is null")
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I93ZBG?from=project-issue
    func I93ZBG () : Unit {
        var zipModel = ZipModel()
        zipModel.setZipFile(Path("a.txt"))
        var src = UnzipUtil.createSplitInputStream(zipModel)
        @Assert(src.read(), 0)
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I93ZK4?from=project-issue
    func I93ZK4 () : Unit {
        var msg = ""
        try{
            let zipParameters = ZipParameters()
            let files = Array<String>(["mimetype","container.xml"])
            zipParameters.setCompressionMethod(CompressionMethod.STORE)
            let zipFile = ZipFile("end_of_cen_dir_not_at_expected_position.zip")
            zipFile.renameFile(FileHeader(),"123")
        } catch (e: NoneValueException) {
             msg = e.message
        }
        @Assert(msg, "The fileName of the FileHeader class is None.")
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I9409B?from=project-issue
    func I9409B () : Unit {
        var msg = ""
        try{
            let zipParameters = ZipParameters()
            zipParameters.setCompressionMethod(CompressionMethod.STORE)
            let zipFile = ZipFile("video.zip")
            var fileheader=FileHeader()
            fileheader.setFileName("MP41.mp4")
            zipFile.renameFile(fileheader," ")
        } catch (e: ZipException) {
             msg = e.message
        }
        @Assert(msg, "newFileName is None or empty")
    }


    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I940SJ?from=project-issue
    func I940SJ () : Unit {
        let zipFile = ZipFile("archive_with_invalid_zip64_headers.zip")
        @Assert(zipFile.getComment(),"")
        zipFile.setComment("123")
        @Assert(zipFile.getComment(),"123")
    }
    
    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I943D8?from=project-issue
    func I943D8 () : Unit {
        let zipFile = ZipFile("output123.zip")
        var fileheader=FileHeader()
        fileheader.setFileName("MP4.mp4")
        @Assert(zipFile.getInputStream(fileheader).read(),-1)
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I93UFV?from=project-issue
    func I93UFV () : Unit {
        Directory.create("contrast/29",recursive: true) 
        var zipFile = ZipFile(Path("contrast/29/addfiles.zip"))
        zipFile.addFile("a.txt")
        zipFile.addFile(Path("1COMM_v24tagswithalbumimage1.mp3"), parameters: ZipParameters())
        var paths=[Path("missing_exended_local_file_header.zip")]
        zipFile.addFiles(paths,parameters: ZipParameters())           //添加文件压缩

        let zipFile1 = ZipFile("contrast/29/addfiles.zip")
        Directory.create("contrast/291")  
        zipFile1.extractAll("./contrast/291")          //解压
        let input: File = File("contrast/291/1COMM_v24tagswithalbumimage1.mp3", Open(true, true))
        let input1: File = File("1COMM_v24tagswithalbumimage1.mp3", Open(true, true))
        @Assert(input.readToEnd(),input1.readToEnd())
        let input2: File = File("contrast/291/a.txt", Open(true, true))
        let input3: File = File("a.txt", Open(true, true))
        @Assert(input2.readToEnd(),input3.readToEnd())
        let input4: File = File("contrast/291/missing_exended_local_file_header.zip", Open(true, true))
        let input5: File = File("missing_exended_local_file_header.zip", Open(true, true))
        @Assert(input4.readToEnd(),input5.readToEnd())
    }

    @TestCase
    // https://gitee.com/HW-PLLab/zip4cj/issues/I946RI?from=project-issue
    func I946RI(): Unit {
        var str = ""
        try {
            var headerReader = HeaderReader()
            var src = headerReader.isDirectory(Array<Byte>(),None)
            @Assert(src , true)
        } catch (e: IndexOutOfBoundsException) {
            str = e.message
        }
        @Assert(str, "Index 0 out of bounds for length 0")
        
    }
}

