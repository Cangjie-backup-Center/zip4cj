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

