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
import charset4cj.charset.*
import charset4cj.charset.encoding.*
main() { 

    let test = utilTest()
    test.utilTest01()
    test.utilTest02()
    test.utilTest03()
    return 0
}
@Test
public class utilTest {

    @TestCase
    public func utilTest01(): Unit {
        var sc = ZipFile(Path("123.txt"))
        var fh = FileHeader()
        fh.setFileName("111")
        var returnTag = 0
        try {
            sc.isValidZipFile()
        }catch (e: ZipException) {
            returnTag = returnTag + 1
        }
        sc.getBufferSize()
        sc.setBufferSize(566)
        sc.getProgressMonitor()
        sc.getFile()
        sc.getCharset()
        sc.setCharset(Charsets.forName("UTF-8").getOrThrow())
        sc.getExecutorService()
        sc.isUseUtf8CharsetForPasswords()
        sc.setUseUtf8CharsetForPasswords(false)
        sc.setPassword(Array<Rune>())
        @Assert(returnTag, 0)
    }

    @TestCase
    public func utilTest02(): Unit {
        var sc = ZipFile(Path("123.txt"))
        var returnTag = 0
        try {
            sc.getSplitZipFiles()
        }catch (e: ZipException) {
            returnTag = returnTag + 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func utilTest03(): Unit {
        var sc = ZipFile(Path("123.txt"))
        var returnTag = 0
        try {
            sc.setBufferSize(1)
        }catch (e: IllegalArgumentException) {
            returnTag = returnTag + 1
        }
        @Assert(returnTag, 1)
    }

}
