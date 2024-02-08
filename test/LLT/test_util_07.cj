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
        var sc = RandomAccessFile(File("123.txt",OpenOption.Open(true, false)))
        let sc1 = sc.read(Array<Byte>(1,item: 0))
        @Assert(sc1, 1)
    }

    @TestCase
    public func utilTest02(): Unit {
        var sc = RandomAccessFile(File("output.zip",OpenOption.Open(true, false)))
        var returnTag = 0
        try {
            sc.read(Array<Byte>(5,item: 0),0,10)
        }catch (e: IndexOutOfBoundsException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func utilTest03(): Unit {
        var sc = RandomAccessFile(File("a.txt",OpenOption.Open(true, true)))
        sc.readFully(Array<Byte>(10,item: 0))
        sc.write(Array<Byte>())
        sc.flush()
        sc.close()
        let sc1 = sc.isClosed()
        @Assert(sc1, true)
    }

    @TestCase
    public func utilTest04(): Unit {
        var sc = RandomAccessFile(File("a.txt",OpenOption.Open(true, true)))
        let src = RawIO()
        let sc1 = src.readLongLittleEndian(sc)
        @Assert(sc1, 49)
    }

    @TestCase
    public func utilTest05(): Unit {
        var sc = RandomAccessFile(File("a.txt",OpenOption.Open(true, true)))
        let src = RawIO()
        let sc1 = src.readLongLittleEndian(sc,0)
        println(sc1)
        @Assert(sc1, 0)
    }

}
