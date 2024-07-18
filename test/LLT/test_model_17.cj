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
        var sc = AESExtraDataRecord()
        sc.setVendorID("wadsd")
        var sc1 = sc.getVendorID()
        @Assert(sc1, "wadsd")
    }

    @TestCase
    public func modelTest02(): Unit {
        var sc = AESExtraDataRecord()
        var sc1 = sc.getVendorID()
        @Assert(sc1, "AE")
    }

    @TestCase
    public func modelTest03(): Unit {
        var sc = AESExtraDataRecord()
        var sc1 = sc.getAesKeyStrength().getRawCode()
        @Assert(sc1, 3)
    }

    @TestCase
    public func modelTest04(): Unit {
        var sc = AESExtraDataRecord()
        sc.setAesKeyStrength(AesKeyStrength.KEY_STRENGTH_128)
        var sc1 = sc.getAesKeyStrength().getRawCode()
        @Assert(sc1, 1)
    }

    @TestCase
    public func modelTest05(): Unit {
        var sc = AESExtraDataRecord()
        var sc1 = sc.getCompressionMethod().getCode()
        @Assert(sc1, 8)
    }

}

