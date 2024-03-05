//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
// sources_file:a.txt
// sources_file:archive_with_invalid_zip64_headers.zip
from std import collection.*
from std import fs.*
from std import io.*
from std import unittest.*
from std import math.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.encoding.*
from zip4cj import zip4cj.*
@Test
public class FileUtilsTest {
    @TestCase
    func FileUtils01(): Unit {
        var src = ZipModel()
        src.setZipFile(Path("a.txt"))
        let sc = FileUtils.getSplitZipFiles(src)
        @Assert(sc.size, 1)
    }

    @TestCase
    func FileUtils02(): Unit {
        try {
            FileUtils.getSplitZipFiles(ZipModel())
        } catch (e: NoneValueException) {
            @Assert(e.toString() , "NoneValueException")
        }
    }

    @TestCase
    func FileUtils03(): Unit {
        let sc = FileUtils.getRelativeFileName(Path("你好"),ZipParameters())
        @Assert(sc, "你好")
    }

    @TestCase
    func FileUtils04(): Unit {
        let sc = FileUtils.getRelativeFileName(Path("dsadsaffasf"),ZipParameters())
        @Assert(sc, "dsadsaffasf")
    }
 
    @TestCase
    func FileUtils05(): Unit {
        let sc = FileUtils.getRelativeFileName(Path("3453453453453.0212"),ZipParameters())
        @Assert(sc, "3453453453453.0212")
    }
    
    @TestCase
    func FileUtils06(): Unit {
        let sc = FileUtils.getRelativeFileName(Path("@#$$#$^^&^&^&*^*"),ZipParameters())
        @Assert(sc, "@#$$#$^^&^&^&*^*")
    }

    @TestCase
    func FileUtils07(): Unit {
        let sc = FileUtils.getRelativeFileName(Path("@#$$#$^^&^&^&*^*3453453453453.0212你好"),ZipParameters())
        @Assert(sc, "@#$$#$^^&^&^&*^*3453453453453.0212你好")
    }

    @TestCase
    func FileUtils08(): Unit {
        let sc = FileUtils.getRelativeFileName(Path("archive_with_invalid_zip64_headers.zip"),ZipParameters())
        @Assert(sc, "archive_with_invalid_zip64_headers.zip")
    }

    @TestCase
    func FileUtils09(): Unit {
        let sc = FileUtils.getRelativeFileName(Path(""),ZipParameters())
        @Assert(sc, "")
    }
}