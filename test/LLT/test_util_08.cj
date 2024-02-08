// RESOURCES: output.zip
// RESOURCES: 123.txt
// RESOURCES: a.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.util.*
from zip4cj import zip4cj.progress.*
from std import collection.*
from std import fs.*
from std import io.*
from std import os.posix.*
from std import unittest.*
from std import unittest.testmacro.*
main() { 

    let test = utilTest()
    test.utilTest01()
    test.utilTest02()
    test.utilTest03()
    test.utilTest04()
    test.utilTest05()
    return 0
}
@Test
public class utilTest {

    @TestCase
    public func utilTest01(): Unit {
        var sc = RandomAccessFile(File("a.txt",OpenOption.Open(true, true)))
        let src = RawIO()
        var sc1 = Zip4cjUtil()
        var returnTag = 0
        try {
            src.readLongLittleEndian(sc,10)
        }catch (e: IndexOutOfBoundsException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func utilTest02(): Unit {
        var sc = Zip4cjUtil.epochToExtendedDosTime(10)
        @Assert(sc, 2162688)
    }

    @TestCase
    public func utilTest03(): Unit {
        var returnTag = 0
        try {
            Zip4cjUtil.dosToExtendedEpochTme(101)
        }catch (e: IllegalArgumentException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func utilTest04(): Unit {
        var sc = Zip4cjUtil.convertCharArrayToByteArray(Array<Char>(),true)
        var sc1 = Zip4cjUtil.convertCharArrayToByteArray(Array<Char>(),false)
        @Assert(sc.toString(), "[]")
        @Assert(sc1.toString(), "[]")
    }

    @TestCase
    public func utilTest05(): Unit {
        var s1 = BufferOverflowException ()
        @Assert(s1.toString(), "Exception: BufferOverflowException: \n")
    }

}
