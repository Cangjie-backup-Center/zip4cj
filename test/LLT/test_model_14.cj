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
import charset4cj.charset.*
import charset4cj.charset.encoding.*
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
        var sc = DataDescriptor()
        sc.setCrc(110)
        var sc1 = sc.getCrc()
        @Assert(sc1, 110)
    }

    @TestCase
    public func modelTest02(): Unit {
        var sc = DataDescriptor()
        var sc1 = sc.getCompressedSize()
        @Assert(sc1, 0)
    }

    @TestCase
    public func modelTest03(): Unit {
        var sc = DataDescriptor()
        sc.setCompressedSize(336)
        var sc1 = sc.getCompressedSize()
        @Assert(sc1, 336)
    }

    @TestCase
    public func modelTest04(): Unit {
        var sc = DataDescriptor()
        var sc1 = sc.getUncompressedSize()
        @Assert(sc1, 0)
    }

    @TestCase
    public func modelTest05(): Unit {
        var sc = DataDescriptor()
        sc.setUncompressedSize(979)
        var sc1 = sc.getUncompressedSize()
        @Assert(sc1, 979)
    }

}

