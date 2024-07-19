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
        let sc = AesKeyStrength.KEY_STRENGTH_128
        var sc1 = sc.getRawCode()
        @Assert(sc1, 1)
    }

    @TestCase
    public func modelTest02(): Unit {
        let sc = AesKeyStrength.KEY_STRENGTH_128
        var sc1 = sc.getSaltLength()
        @Assert(sc1, 8)
    }

    @TestCase
    public func modelTest03(): Unit {
        let sc = AesKeyStrength.KEY_STRENGTH_128
        var sc1 = sc.getMacLength()
        @Assert(sc1, 16)
    }

    @TestCase
    public func modelTest04(): Unit {
        let sc = AesKeyStrength.KEY_STRENGTH_128
        var sc1 = sc.getKeyLength()
        @Assert(sc1, 16)
    }

    @TestCase
    public func modelTest05(): Unit {
        let sc = AesKeyStrength.KEY_STRENGTH_128
        let sc6 = AesKeyStrength.KEY_STRENGTH_192
        var sc1 = AesKeyStrength.getAesKeyStrengthFromRawCode(1)
        var sc2 = AesKeyStrength.getAesKeyStrengthFromRawCode(2)
        var sc3 = AesKeyStrength.getAesKeyStrengthFromRawCode(3)
        var sc4 = AesKeyStrength.getAesKeyStrengthFromRawCode(4)
        @Assert(sc1.getOrThrow()==sc2.getOrThrow(), false)
        @Assert(sc==sc1.getOrThrow(), true)
        @Assert(sc==sc6, false)
    }

}

