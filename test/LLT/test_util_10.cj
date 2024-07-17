// RESOURCES: output.zip
// RESOURCES: 123.txt
// RESOURCES: a.txt
// EXEC: cjc %import-path %L %l %f --test
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
    return 0
}
@Test
public class utilTest {

    @TestCase
    public func utilTest01(): Unit {
        var sc = ZipFile(Path("123.txt"))
        var returnTag = 0
        try {
            sc.createSplitZipFileFromFolder(Path("a.txt"),ZipParameters(),false,1)
        }catch (e: ZipException) {
            returnTag = 1
        }
        try {
            sc.addFolder(Path("a.txt"))
        }catch (e: ZipException) {
            returnTag = returnTag + 1
        }
        try {
            sc.addStream(ByteArrayStream(),ZipParameters())
        }catch (e: ZipException) {
            returnTag = returnTag + 1
        }
        try {
            sc.extractFile(FileHeader(),"ad")
        }catch (e: NoneValueException) {
            returnTag = returnTag + 1
        }
        @Assert(returnTag, 4)
    }

    @TestCase
    public func utilTest02(): Unit {
        var sc = ZipFile(Path("123.txt"))
        var returnTag = 0
        try {
            sc.addFile("a.txt")
        }catch (e: ZipException) {
            returnTag = returnTag+ 1
        }
        try {
            sc.addFile("a.txt", parameters: ZipParameters())
        }catch (e: ZipException) {
            returnTag = returnTag+ 1
        }
        try {
            sc.addFile(Path("a.txt"))
        }catch (e: ZipException) {
            returnTag = returnTag+ 1
        }
        try {
            sc.addFile(Path("a.txt"),parameters: ZipParameters())
        }catch (e: ZipException) {
            returnTag = returnTag+ 1
        }
        try {
            sc.addFiles(ArrayList<Path>())
        }catch (e: ZipException) {
            returnTag = returnTag+ 1
        }
        try {
            sc.addFiles(ArrayList<Path>(),parameters: ZipParameters())
        }catch (e: ZipException) {
            returnTag = returnTag+ 1
        }
        @Assert(returnTag, 6)
    }

    @TestCase
    public func utilTest03(): Unit {
        var sc = ZipFile(Path("123.txt"))
        var fh = FileHeader()
        fh.setFileName("6666")
        var returnTag = 0
        try {
            sc.extractFile(fh,"2112")
        }catch (e: ZipException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func utilTest04(): Unit {
        var sc = ZipFile(Path("123.txt"))
        var fh = FileHeader()
        fh.setFileName("111")
        var returnTag = 0
        try {
            sc.extractFile(fh, "2112")
        }catch (e: ZipException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func utilTest05(): Unit {
        var sc = ZipFile(Path("123.txt"))
        var fh = FileHeader()
        fh.setFileName("111")
        var returnTag = 0
        try {
            sc.extractFile(fh,"2112",newFileName: "da6", parameters: UnzipParameters())
        }catch (e: ZipException) {
            returnTag = returnTag + 1
        }

        try {
            sc.extractFile("2112","da6")
        }catch (e: ZipException) {
            returnTag = returnTag + 1
        }
        @Assert(returnTag, 2)
    }

}
