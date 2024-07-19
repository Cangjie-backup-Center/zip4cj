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
        var sc = CentralDirectory()
        var sc1 = sc.getDigitalSignature().getSizeOfData()
        @Assert(sc1, 0)
    }

    @TestCase
    public func modelTest02(): Unit {
        var sc = CentralDirectory()
        var scc = DigitalSignature()
        scc.setSizeOfData(159)
        sc.setDigitalSignature(scc)
        var sc1 = sc.getDigitalSignature().getSizeOfData()
        @Assert(sc1, 159)
    }

    @TestCase
    public func modelTest03(): Unit {
        var sc = ArchiveExtraDataRecord()
        sc.setExtraFieldLength(735)
        var sc1 = sc.getExtraFieldLength()
        @Assert(sc1, 735)
    }

    @TestCase
    public func modelTest04(): Unit {
        var sc = ArchiveExtraDataRecord ()
        var sc1 = sc.getExtraFieldLength()
        @Assert(sc1, 0)
    }

    @TestCase
    public func modelTest05(): Unit {
        var sc = ArchiveExtraDataRecord ()
        var sc1 = sc.getExtraFieldData()
        @Assert(sc1, None)
    }

}

