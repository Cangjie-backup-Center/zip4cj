// RESOURCES: output.zip
// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import  zip4cj.util.*
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
        let sc = Zip64ExtendedInfo()
        sc.setUncompressedSize(-100)
        let sc1 = sc.getUncompressedSize()
        @Assert(sc1, -100)
    }

    @TestCase
    public func modelTest02(): Unit {
        let sc = Zip64ExtendedInfo()
        let sc1 = sc.getOffsetLocalHeader()
        @Assert(sc1, -1)
    }

    @TestCase
    public func modelTest03(): Unit {
        let sc = Zip64ExtendedInfo()
        sc.setOffsetLocalHeader(-100)
        let sc1 = sc.getOffsetLocalHeader()
        @Assert(sc1, -100)
    }

    @TestCase
    public func modelTest04(): Unit {
        let sc = Zip64ExtendedInfo()
        let sc1 = sc.getDiskNumberStart()
        @Assert(sc1, -1)
    }

    @TestCase
    public func modelTest05(): Unit {
        let sc = Zip64ExtendedInfo()
        sc.setDiskNumberStart(-99)
        let sc1 = sc.getDiskNumberStart()
        @Assert(sc1, -99)
    }

}