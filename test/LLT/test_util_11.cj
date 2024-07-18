// RESOURCES: output.zip
// RESOURCES: 123.txt
// RESOURCES: a.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import zip4cj.util.*
import  zip4cj.*
import zip4cj.progress.*
import std.collection.*
import std.fs.*
import std.io.*
import std.os.posix.*
import std.unittest.*
import std.unittest.testmacro.*
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
        var sc = ZipFile(Path("123.txt"))
        var returnTag = 0
        try {
            sc.isSplitArchive()
        }catch (e: ZipException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func utilTest02(): Unit {
        var sc = ZipFile(Path("123.txt"))
        var fh = FileHeader()
        fh.setFileName("111")
        var returnTag = 0
        try {
            sc.removeFile(fh)
        }catch (e: ZipException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func utilTest03(): Unit {
        var sc = ZipFile(Path("123.txt"))
        var returnTag = 0
        var fh = FileHeader()
        fh.setFileName("111")
        try {
            sc.renameFile(fh,"99")
        }catch (e: ZipException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func utilTest04(): Unit {
        var sc = ZipFile(Path("123.txt"))
        var returnTag = 0
        try {
            sc.mergeSplitFiles(Path("a.txt"))
        }catch (e: ZipException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func utilTest05(): Unit {
        var sc = ZipFile(Path("123.txt"))
        var returnTag = 0
        var fh = FileHeader()
        fh.setFileName("111")
        try {
            sc.getInputStream(fh)
        }catch (e: ZipException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

}
