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
        let sc = SymbolicLinkAction.INCLUDE_LINK_ONLY
        let sc1 = SymbolicLinkAction.INCLUDE_LINKED_FILE_ONLY
        let sc2 = SymbolicLinkAction.INCLUDE_LINK_AND_LINKED_FILE
        @Assert(sc1==sc1, true)
        @Assert(sc2==sc2, true)
        @Assert(sc==sc, true)
        @Assert(sc==sc1, false)
    }

    @TestCase
    public func modelTest02(): Unit {
        var sc = ZipModel()
        sc.setLocalFileHeaders(ArrayList<LocalFileHeader>())
        let sc1 = sc.getLocalFileHeaders().size
        @Assert(sc1, 0)
    }

    @TestCase
    public func modelTest03(): Unit {
        var sc = ZipModel()
        sc.setDataDescriptors(ArrayList<DataDescriptor>())
        let sc1 = sc.getDataDescriptors().size
        @Assert(sc1, 0)
    }

    @TestCase
    public func modelTest04(): Unit {
        var sc = ZipModel()
        sc.setArchiveExtraDataRecord(ArchiveExtraDataRecord())
        let sc1 = sc.getArchiveExtraDataRecord().getExtraFieldLength()
        @Assert(sc1, 0)
    }

    @TestCase
    public func modelTest05(): Unit {
        var sc = ZipModel()
        sc.getZip64EndOfCentralDirectoryLocator()
        sc.setZip64EndOfCentralDirectoryRecord(Zip64EndOfCentralDirectoryRecord())
        let sc1 = sc.getZip64EndOfCentralDirectoryRecord().getVersionMadeBy()
        @Assert(sc1, 0)
    }

}

