// RESOURCES: output.zip
// RESOURCES: 123.txt
// RESOURCES: a.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.util.*
from zip4cj import zip4cj.*
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
        var sc = ByteBuffer.allocate(10)
        ByteBuffer.wrap(Array<UInt8>(15,item: 1),0,10)
        ByteBuffer.wrap(Array<UInt8>())
        sc.get(Array<UInt8>())
        sc.put(Array<UInt8>())
        var src = sc.hasArray()
        sc.array()
        sc.arrayOffset()
        sc.position(0)
        sc.limit(6)
        sc.clear()
        sc.flip()
        sc.rewind()
        @Assert(src, false)
    }

    @TestCase
    public func utilTest02(): Unit {
        var sc1 = ByteBuffer.allocate(10)
        var sc = ByteBuffer.wrap(Array<UInt8>(15,item: 1),0,10)
        var src = sc.toString()
        sc.hashCode()
        sc.slice()
        sc.slice(0,1)
        sc.duplicate()
        sc.asReadOnlyBuffer()
        sc.put(1)
        sc.put(1,1)
        sc.put(Array<Byte>(10,item:6),1,1)
        sc.get()
        sc.get(1)
        sc.get(Array<Byte>(10,item:6),1,1)
        @Assert(sc1==sc, false)
        @Assert(sc1!=sc, true)
        @Assert(src, "ByteBuffer: [offset=0 mark=-1 pos=0 lim=10 cap=15]")
    }

    @TestCase
    public func utilTest03(): Unit {
        var sc1 = ByteBuffer.allocate(100)
        var sc = ByteBuffer.wrap(Array<UInt8>(15,item: 1),0,15)
        sc1.put(sc)
        sc1.putLong(1)
        sc1.putInt(1)
        sc1.putShort(1)
        sc1.putUInt64(6)
        sc1.putUInt32(7)
        sc1.putUInt16(5)
        sc1.getLong()
        sc1.getInt()
        sc1.getShort()
        sc1.getUInt64()
        sc1.getUInt32()
        var src = sc1.getUInt32()
        @Assert(src, 0)
    }

    @TestCase
    public func utilTest04(): Unit {
        var sc = ByteBuffer.wrap(Array<UInt8>(15,item: 1),0,15)
        var returnTag = 0
        try {
            sc.reset()
        }catch (e: Exception) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

    @TestCase
    public func utilTest05(): Unit {
        ZipVersionUtils()
        var sc = ZipFile(Path("123.txt"))
        ZipFile(Path("123.txt"),Array<Char>())
        var returnTag = 0
        try {
            sc.createSplitZipFile(ByteArrayStream(),ZipParameters(),true,6)
        }catch (e: Exception) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

}
