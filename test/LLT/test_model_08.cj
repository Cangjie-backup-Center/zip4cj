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
        var sc = Zip64EndOfCentralDirectoryRecord()
        sc.setTotalNumberOfEntriesInCentralDirectory(-696)
        let sc1 = sc.getTotalNumberOfEntriesInCentralDirectory()
        @Assert(sc1, -696)
    }

    @TestCase
    public func modelTest02(): Unit {
        var sc = Zip64EndOfCentralDirectoryRecord()
        sc.setSizeOfCentralDirectory(145)
        let sc1 = sc.getSizeOfCentralDirectory()
        @Assert(sc1, 145)
    }

    @TestCase
    public func modelTest03(): Unit {
        var sc = Zip64EndOfCentralDirectoryRecord()
        sc.setOffsetStartCentralDirectoryWRTStartDiskNumber(369)
        let sc1 = sc.getOffsetStartCentralDirectoryWRTStartDiskNumber()
        @Assert(sc1, 369)
    }

    @TestCase
    public func modelTest04(): Unit {
        var sc = Zip64EndOfCentralDirectoryRecord()
        sc.setExtensibleDataSector(Array<Byte>())
        let sc1 = sc.getExtensibleDataSector().getOrThrow().size
        @Assert(sc1, 0)
    }

    @TestCase
    public func modelTest05(): Unit {
        var sc = Zip64EndOfCentralDirectoryLocator()
        sc.setNumberOfDiskStartOfZip64EndOfCentralDirectoryRecord(199)
        let sc1 = sc.getNumberOfDiskStartOfZip64EndOfCentralDirectoryRecord()
        @Assert(sc1, 199)
    }

}

