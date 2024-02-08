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
        var sc = ZipModel()
        sc.setNestedZipFile(false)
        let sc1 = sc.isNestedZipFile()
        @Assert(sc1, false)
    }

    @TestCase
    public func modelTest02(): Unit {
        var sc = ZipModel()
        sc.setStart(666)
        let sc1 = sc.getStart()
        @Assert(sc1, 666)
    }

    @TestCase
    public func modelTest03(): Unit {
        var sc = ZipModel()
        sc.setEnd(1001)
        let sc1 = sc.getEnd()
        @Assert(sc1, 1001)
    }

    @TestCase
    public func modelTest04(): Unit {
        var sc = ZipModel()
        let sc1 = sc.clone().getEnd()
        @Assert(sc1, 0)
    }

    @TestCase
    public func modelTest05(): Unit {
        var sc = Zip64EndOfCentralDirectoryRecord()
        sc.setSizeOfZip64EndCentralDirectoryRecord(1001)
        let sc1 = sc.getSizeOfZip64EndCentralDirectoryRecord()
        @Assert(sc1, 1001)
    }

}

