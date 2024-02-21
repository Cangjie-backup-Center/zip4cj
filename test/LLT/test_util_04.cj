// RESOURCES: output.zip
// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.util.*
from std import collection.*
from std import fs.*
from std import io.*
from std import os.posix.*
from std import unittest.*
from std import unittest.testmacro.*
main() { 

    let test = utilTest()
    test.execute()
    test.printResult()
    return 0
}
@Test
public class utilTest {

    @TestCase
    public func utilTest01(): Unit {
        var returnTag = 0
        try {
            BitUtils.isBitSet(3,10)
        }catch (e: ArithmeticException) {
            returnTag = 1
        }
        @Assert(returnTag, 0)
    }

    @TestCase
    public func utilTest02(): Unit {
        let sc = BitUtils.isBitSet(1,6)
        @Assert(sc, false)
    }

    @TestCase
    public func utilTest03(): Unit {
        let sc = BitUtils.isBitSet(1,0)
        @Assert(sc, true)
    }

    @TestCase
    public func utilTest04(): Unit {
        let sc = BitUtils.setBit(1,6)
        @Assert(sc, 65)
    }

    @TestCase
    public func utilTest05(): Unit {
        let sc = BitUtils.unsetBit(2,7)
        @Assert(sc, 2)
    }

}