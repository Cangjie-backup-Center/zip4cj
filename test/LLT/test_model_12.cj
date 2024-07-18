// RESOURCES: output.zip
// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import  zip4cj.util.*
import  zip4cj.model.enums.*
import  zip4cj.model.*
import  zip4cj.tasks.*
import  zip4cj.progress.*
import  zip4cj.exception.*
import  zip4cj.io.outputstream.*
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*
import  charset.*
import  charset.encoding.*
main() { 

    let test = modelTest()
    test.modelTest01()
    test.modelTest02()
    test.modelTest03()
    test.modelTest04()
    test.modelTest05()
    return 0
}
@Test
public class modelTest {

    @TestCase
    public func modelTest01(): Unit {
        var sc = ExtraDataRecord()
        var sc1 = sc.getSizeOfData()
        @Assert(sc1, 0)
    }

    @TestCase
    public func modelTest02(): Unit {
        var sc = ExtraDataRecord()
        var sc1 = sc.getData()
        @Assert(sc1, None)
    }

    @TestCase
    public func modelTest03(): Unit {
        var sc = EndOfCentralDirectoryRecord ()
        var sc1 = sc.getSizeOfCentralDirectory()
        @Assert(sc1, 0)
    }

    @TestCase
    public func modelTest04(): Unit {
        var sc = EndOfCentralDirectoryRecord ()
        sc.setComment("+----99")
        var sc1 = sc.getComment()
        @Assert(sc1, "+----99")
    }

    @TestCase
    public func modelTest05(): Unit {
        var sc = EndOfCentralDirectoryRecord ()
        sc.setOffsetOfStartOfCentralDirectory(336)
        var sc1 = sc.getOffsetOfStartOfCentralDirectory()
        @Assert(sc1, 336)
    }

}

