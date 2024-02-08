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
        var sc = Zip64EndOfCentralDirectoryRecord()
        sc.setVersionMadeBy(-66)
        let sc1 = sc.getVersionMadeBy()
        @Assert(sc1, -66)
    }

    @TestCase
    public func modelTest02(): Unit {
        var sc = Zip64EndOfCentralDirectoryRecord()
        sc.setVersionNeededToExtract(-616)
        let sc1 = sc.getVersionNeededToExtract()
        @Assert(sc1, -616)
    }

    @TestCase
    public func modelTest03(): Unit {
        var sc = Zip64EndOfCentralDirectoryRecord()
        sc.setNumberOfThisDisk(-997)
        let sc1 = sc.getNumberOfThisDisk()
        @Assert(sc1, -997)
    }

    @TestCase
    public func modelTest04(): Unit {
        var sc = Zip64EndOfCentralDirectoryRecord()
        sc.setNumberOfThisDiskStartOfCentralDirectory(967)
        let sc1 = sc.getNumberOfThisDiskStartOfCentralDirectory()
        @Assert(sc1, 967)
    }

    @TestCase
    public func modelTest05(): Unit {
        var sc = Zip64EndOfCentralDirectoryRecord()
        sc.setTotalNumberOfEntriesInCentralDirectoryOnThisDisk(199)
        let sc1 = sc.getTotalNumberOfEntriesInCentralDirectoryOnThisDisk()
        @Assert(sc1, 199)
    }

}

