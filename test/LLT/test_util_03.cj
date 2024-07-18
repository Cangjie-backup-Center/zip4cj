// RESOURCES: output.zip
// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f --test 
// EXEC: ./main

import zip4cj.util.*
import zip4cj.model.*
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
        var returnTag = 1
        try {
            FileUtils.getAllSortedNumberedSplitFiles(Path("123.txt"))
        }catch (e: NoneValueException) {
            returnTag = 0
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