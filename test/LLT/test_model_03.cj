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
        let sc = Zip64ExtendedInfo()
        let sc1 = Zip64ExtendedInfo()
        sc1.setDiskNumberStart(100)
        @Assert(sc == sc1, false)
    }

    @TestCase
    public func modelTest02(): Unit {
        let sc = Zip64ExtendedInfo()
        let sc1 = Zip64ExtendedInfo()
        sc1.setDiskNumberStart(100)
        @Assert(sc != sc1, true)
    }

    @TestCase
    public func modelTest03(): Unit {
        var sc = ZipParameters()
        sc.setCompressionLevel(CompressionLevel.NO_COMPRESSION)
        sc.setReadHiddenFiles(false)
        let sc1 = sc.isReadHiddenFiles()
        @Assert(sc1, false)
    }

    @TestCase
    public func modelTest04(): Unit {
        var sc = ZipParameters()
        sc.setReadHiddenFolders(false)
        sc.setAesKeyStrength(AesKeyStrength.KEY_STRENGTH_192)
        let sc1 = sc.isReadHiddenFolders()
        @Assert(sc1, false)
    }

    @TestCase
    public func modelTest05(): Unit {
        var sc = ZipParameters()
        sc.setAesVersion(AesVersion.ONE)
        sc.setIncludeRootFolder(false)
        let sc1 = sc.isIncludeRootFolder()
        @Assert(sc1, false)
    }

}