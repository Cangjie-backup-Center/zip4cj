// RESOURCES: output.zip
// RESOURCES: 123.txt
// RESOURCES: a.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.util.*
from zip4cj import zip4cj.*
from zip4cj import zip4cj.progress.*
from std import collection.*
from std import fs.*
from std import io.*
from std import os.posix.*
from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.encoding.*
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
        sc.setPassword(Array<Char>())
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
