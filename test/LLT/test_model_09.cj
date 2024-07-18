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
        var sc = Zip64EndOfCentralDirectoryLocator()
        sc.setOffsetZip64EndOfCentralDirectoryRecord(159)
        let sc1 = sc.getOffsetZip64EndOfCentralDirectoryRecord()
        @Assert(sc1, 159)
    }

    @TestCase
    public func modelTest02(): Unit {
        var sc = Zip64EndOfCentralDirectoryLocator()
        sc.setTotalNumberOfDiscs(327)
        let sc1 = sc.getTotalNumberOfDiscs()
        @Assert(sc1, 327)
    }

    @TestCase
    public func modelTest03(): Unit {
        var sc = Zip4cjConfig(Charsets.forName("UTF-8").getOrThrow(),1,true)
        let sc1 = sc.isUseUtf8CharsetForPasswords()
        @Assert(sc1, true)
    }

    @TestCase
    public func modelTest04(): Unit {
        var sc = UnzipParameters()
        let sc1 = sc.isExtractSymbolicLinks()
        @Assert(sc1, true)
    }

    @TestCase
    public func modelTest05(): Unit {
        var sc = UnzipParameters()
        sc.setExtractSymbolicLinks(false)
        let sc1 = sc.isExtractSymbolicLinks()
        @Assert(sc1, false)
    }

}

