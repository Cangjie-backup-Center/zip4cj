// RESOURCES: output.zip
// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import  zip4cj.util.*
from zip4cj import  zip4cj.model.*
from std import collection.*
from std import fs.*
from std import unittest.*
from std import unittest.testmacro.*
main() { 

    let test = utilTest()
    test.utilTest01()
    test.utilTest02()
    test.utilTest03()
    test.utilTest04()
    test.utilTest05()
    return 0
}
@Test
public class utilTest {

    @TestCase
    public func utilTest01(): Unit {
        let sc = FileUtils.DEFAULT_POSIX_FILE_ATTRIBUTES
        FileUtils.setFileAttributes(Path("output.zip"),FileUtils.DEFAULT_POSIX_FILE_ATTRIBUTES)
        FileUtils.setFileAttributes(Path("output.zip"),Array<Byte>())
        FileUtils.setFileLastModifiedTime(Path("output.zip"),10)
        FileUtils.setFileLastModifiedTime(Path("output.zip"),0)
        FileUtils.setFileLastModifiedTimeWithoutNio(Path("output.zip"),0)
        @Assert(sc.toString(), "[0, 0, 164, 129]")
    }

    @TestCase
    public func utilTest02(): Unit {
        let sc1 = FileUtils.DEFAULT_POSIX_FOLDER_ATTRIBUTES
        var sc = FileUtils.getFileAttributes(Path("output.zip"))
        var returnTag = 0
        try {
            FileUtils.getFilesInDirectoryRecursive(Path("output.zip"),ZipParameters())
        }catch (e: FSException) {
            returnTag = 1
        }
        @Assert(returnTag, 0)
        @Assert(sc1.toString(), "[0, 0, 237, 65]")
        @Assert(sc.toString(), "[0, 0, 182, 129]")
    }

    @TestCase
    public func utilTest03(): Unit {
        var returnTag = 0
        try {
            FileUtils.getFilesInDirectoryRecursive(Path("123.txt"),ZipParameters())
        }catch (e: FSException) {
            returnTag = 1
        }
        @Assert(returnTag, 0)
    }

    @TestCase
    public func utilTest04(): Unit {
        let src = FileUtils.getFileNameWithoutExtension("/home/cwl/cangjie/workspace/zip4cj/test/resources/a.txt")
        @Assert(src, "/home/cwl/cangjie/workspace/zip4cj/test/resources/a")
        let src1 = FileUtils.getFileNameWithoutExtension("/test/resources")
        @Assert(src1, "/test/resources")
    }

    @TestCase
    public func utilTest05(): Unit {
        let src = FileUtils.getZipFileNameWithoutExtension("output.zip")
        @Assert(src, "output")
    }

}