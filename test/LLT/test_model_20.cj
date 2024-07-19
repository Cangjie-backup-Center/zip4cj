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
        let sc = CompressionLevel.MEDIUM_FAST  
        var sc1 = CompressionLevel.FASTER
        @Assert(sc== sc1, false)
    }

    @TestCase
    public func modelTest02(): Unit {
        let sc = AesVersion.ONE
        var sc1 = sc.getVersionNumber()
        @Assert(sc1, 1)
    }

    @TestCase
    public func modelTest03(): Unit {
        let sc = AesVersion.TWO
        var sc1 = sc.getVersionNumber()
        @Assert(sc1, 2)
    }

    @TestCase
    public func modelTest04(): Unit {
        var sc = AesVersion.getFromVersionNumber(1)
        AesVersion.getFromVersionNumber(2)
        var sc1 = sc.getVersionNumber()
        @Assert(sc1, 1)
    }

    @TestCase
    public func modelTest05(): Unit {
        let sc = AesVersion.TWO
        var sc1 = AesVersion.getFromVersionNumber(1)
        @Assert(sc1==sc, false)
        @Assert(sc==sc, true)
    }

}

