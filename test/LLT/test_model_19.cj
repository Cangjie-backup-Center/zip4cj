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
        let sc = HeaderSignature.ZIP64_END_CENTRAL_DIRECTORY_RECORD   
        var sc1 = sc.getValue()
        @Assert(sc1, 101075792)
    }

    @TestCase
    public func modelTest02(): Unit {
        let sc = RandomAccessFileMode.READ 
        var sc1 = sc.getValue()
        @Assert(sc1, "r")
    }

    @TestCase
    public func modelTest03(): Unit {
        let sc = RandomAccessFileMode.WRITE 
        var sc1 = sc.getValue()
        @Assert(sc1, "rw")
    }

    @TestCase
    public func modelTest04(): Unit {
        let sc = EncryptionMethod.NONE
        let sc1 = EncryptionMethod.ZIP_STANDARD
        let sc2 = EncryptionMethod.ZIP_STANDARD_VARIANT_STRONG
        @Assert(sc1==sc1, true)
        @Assert(sc==sc, true)
        @Assert(sc2== sc2, true)
    }

    @TestCase
    public func modelTest05(): Unit {
        let sc = EncryptionMethod.NONE
        let sc1 = EncryptionMethod.AES
        @Assert(sc1==sc1, true)
        @Assert(sc==sc1, false)
    }

}

