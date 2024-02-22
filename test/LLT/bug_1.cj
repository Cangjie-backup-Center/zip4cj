// RESOURCES: MobaXtermbackup.zip
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


}

