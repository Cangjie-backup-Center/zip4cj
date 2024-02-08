// RESOURCES: output.zip
// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.util.*
from zip4cj import zip4cj.model.*
from zip4cj import zip4cj.progress.*
from std import collection.*
from std import fs.*
from std import io.*
from std import os.posix.*
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
        var zipmo = ZipModel()
        zipmo.setZipFile(Path("123.txt"))
        println(zipmo.getZipFile().getOrThrow().toString())
        let sc = FileUtils.getSplitZipFiles(zipmo)
        @Assert(sc.toString(), "[123.txt]")
    }

    @TestCase
    public func utilTest02(): Unit {
        let sc = FileUtils.getRelativeFileName(Path("123.txt"),ZipParameters())
        @Assert(sc, "123.txt")
    }

    @TestCase
    public func utilTest03(): Unit {
        let sc = FileUtils.isZipEntryDirectory("123.txt")
        let sc1 = FileUtils.isZipEntryDirectory("23.txt\\")
        @Assert(sc, false)
        @Assert(sc1, true)
    }

    @TestCase
    public func utilTest04(): Unit {
        var file = RandomAccessFile(File("123.txt", OpenOption.Open(true, false)))
        var pro = ProgressMonitor()
        var scc = pro.setCancelAllTasks(true)
        FileUtils.copyFile(file,ByteArrayStream(),0,2,pro,2)
        let sc = FileUtils.isNumberedSplitFile(Path("123.txt"))
        @Assert(sc, false)
    }

    @TestCase
    public func utilTest05(): Unit {
        FileUtils.assertFilesExist(ArrayList<Path>(), SymbolicLinkAction.INCLUDE_LINK_ONLY)
        let sc = FileUtils.getFileExtension(Path("123.txt"))
        @Assert(sc, "txt")
    }

}