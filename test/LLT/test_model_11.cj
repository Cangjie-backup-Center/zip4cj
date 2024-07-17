// RESOURCES: output.zip
// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f --test
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
    return 0
}
@Test
public class modelTest {

    @TestCase
    public func modelTest01(): Unit {
        var sc = FileHeader()
        let sc1 = sc.getFileCommentLength()
        @Assert(sc1, 0)
    }

    @TestCase
    public func modelTest02(): Unit {
        var sc = FileHeader()
        let sc1 = sc.getInternalFileAttributes()
        @Assert(sc1, None)
    }

    @TestCase
    public func modelTest03(): Unit {
        var sc = FileHeader()
        var returnTag = 0
        try {
            sc.toString()
        }catch (e: NoneValueException) {
            returnTag = 1
        }
        @Assert(returnTag, 0)
    }

    @TestCase
    public func modelTest04(): Unit {
        var sc = FileHeader()
        sc.setVersionMadeBy(66)
        var sc1 = FileHeader()
        @Assert(sc1!=sc, true)
    }

    @TestCase
    public func modelTest05(): Unit {
        var sc = FileHeader()
        var sc1 = sc.hashCode()
        @Assert(sc1, 961)
    }

}

