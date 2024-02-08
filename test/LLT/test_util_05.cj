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
        var sc = CRC32()
        let src = sc.crc32(10,Array<UInt8>(10, item: 1),0,1)
        @Assert(src, 1171273221)
    }

    @TestCase
    public func utilTest02(): Unit {
        var sc = CRC32()
        var returnTag = 0
        try {
            sc.crc32(6,Array<UInt8>(),0,5)
        }catch (e: IndexOutOfBoundsException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func utilTest03(): Unit {
        var sc = CRC32()
        sc.update(Array<Byte>(5, item: 6))
        let sc1 = sc.getValue()
        @Assert(sc1, 3619496800)
    }

    @TestCase
    public func utilTest04(): Unit {
        var sc = CRC32()
        sc.update(Array<Byte>(5, item: 6))
        sc.reset()
        let sc1 = sc.getValue()
        @Assert(sc1, 0)
    }

    @TestCase
    public func utilTest05(): Unit {
        var sc = CRC32()
        let sc1 = sc.getFinalCRC()
        @Assert(sc1, 0)
    }

}