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
        var sc = AESExtraDataRecord()
        sc.setCompressionMethod(CompressionMethod.AES_INTERNAL_ONLY)
        var sc1 = sc.getCompressionMethod().getCode()
        @Assert(sc1, 99)
    }

    @TestCase
    public func modelTest02(): Unit {
        let sc = HeaderSignature.LOCAL_FILE_HEADER
        let sc1 = HeaderSignature.EXTRA_DATA_RECORD
        HeaderSignature.values()
        @Assert(sc1!=sc, true)
    }

    @TestCase
    public func modelTest03(): Unit {
        let sc = HeaderSignature.EXTRA_DATA_RECORD 
        var sc1 = sc.getValue()
        @Assert(sc1, 134695760)
    }

    @TestCase
    public func modelTest04(): Unit {
        let sc = HeaderSignature.ARCEXTDATREC  
        var sc1 = sc.getValue()
        @Assert(sc1, 134630224)
    }

    @TestCase
    public func modelTest05(): Unit {
        let sc = HeaderSignature.SPLIT_ZIP  
        var sc1 = sc.getValue()
        @Assert(sc1, 134695760)
    }

}

