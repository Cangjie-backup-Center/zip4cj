// RESOURCES: output.zip
// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import  zip4cj.util.*
from zip4cj import  zip4cj.model.enums.*
from zip4cj import  zip4cj.model.*
from zip4cj import  zip4cj.tasks.*
from zip4cj import  zip4cj.progress.*
from zip4cj import  zip4cj.exception.*
from zip4cj import  zip4cj.io.outputstream.*
from std import collection.*
from std import fs.*
from std import io.*
from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.encoding.*
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

