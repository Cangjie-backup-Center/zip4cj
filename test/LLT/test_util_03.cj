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
        var returnTag = 0
        try {
            FileUtils.getAllSortedNumberedSplitFiles(Path("123.txt"))
        }catch (e: NoneValueException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func utilTest02(): Unit {
        let sc = FileUtils.isSymbolicLink(Path("123.txt"))
        @Assert(sc, false)
    }

    @TestCase
    public func utilTest03(): Unit {
        let sc = FileUtils.readSymbolicLink(Path("123.txt"))
        @Assert(sc, "")
    }

    @TestCase
    public func utilTest04(): Unit {
        let sc = FileUtils.getDefaultFileAttributes(true)
        @Assert(sc.toString(), "[0, 0, 237, 65]")
    }

    @TestCase
    public func utilTest05(): Unit {
        let sc = FileUtils.getDefaultFileAttributes(false)
        @Assert(sc.toString(), "[0, 0, 164, 129]")
    }

}