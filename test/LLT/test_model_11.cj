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
        var sc = FileHeader()
        let sc1 = sc.getFileCommentLength()
        @Assert(sc1, 0)
    }

    @TestCase
    public func modelTest02(): Unit {
        var sc = FileHeader()
        let sc1 = sc.getInternalFileAttributes()
        @Assert(sc1, None)
    }

    @TestCase
    public func modelTest03(): Unit {
        var sc = FileHeader()
        var returnTag = 0
        try {
            sc.toString()
        }catch (e: NoneValueException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func modelTest04(): Unit {
        var sc = FileHeader()
        sc.setVersionMadeBy(66)
        var sc1 = FileHeader()
        @Assert(sc1!=sc, true)
    }

    @TestCase
    public func modelTest05(): Unit {
        var sc = FileHeader()
        var sc1 = sc.hashCode()
        @Assert(sc1, 961)
    }

}

