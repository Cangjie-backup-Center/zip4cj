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

