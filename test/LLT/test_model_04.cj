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
        let sc = ZipParameters()
        sc.setEntryCRC(100)
        let sc1 = sc.getEntryCRC()
        @Assert(sc1, 100)
    }

    @TestCase
    public func modelTest02(): Unit {
        let sc = ZipParameters()
        sc.setOverrideExistingFilesInZip(false)
        let sc1 = sc.isOverrideExistingFilesInZip()
        @Assert(sc1, false)
    }

    @TestCase
    public func modelTest03(): Unit {
        let sc = ZipParameters()
        sc.setRootFolderNameInZip("false")
        let sc1 = sc.getRootFolderNameInZip().getOrThrow()
        @Assert(sc1, "false")
    }

    @TestCase
    public func modelTest04(): Unit {
        let sc = ZipParameters()
        sc.setFileComment("false---")
        let sc1 = sc.getFileComment().getOrThrow()
        @Assert(sc1, "false---")
    }

    @TestCase
    public func modelTest05(): Unit {
        let sc = ZipParameters()
        sc.setSymbolicLinkAction(SymbolicLinkAction.INCLUDE_LINK_ONLY)
        sc.setExcludeFileFilter(ExcludeFileFilters())
        sc.setUnixMode(true)
        let sc1 = sc.isUnixMode()
        @Assert(sc1, true)
    }

}

public class ExcludeFileFilters <:  ExcludeFileFilter{
    public func isExcluded(file: Path): Bool {
        return true
    }
}