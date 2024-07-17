// RESOURCES: output.zip
// RESOURCES: 123.txt
// RESOURCES: a.txt
// EXEC: cjc %import-path %L %l %f --test
// EXEC: ./main

import zip4cj.util.*
import zip4cj.progress.*
import std.collection.*
import std.fs.*
import std.io.*
import std.os.posix.*
import std.unittest.*
import std.unittest.testmacro.*
main() { 

    let test = utilTest()
    return 0
}
@Test
public class utilTest {

    @TestCase
    public func utilTest01(): Unit {
        var sc = RandomAccessFile(File("a.txt",OpenOption.Open(true, true)))
        let src = RawIO()
        var returnTag = 0
        try {
            src.readLongLittleEndian(sc,10)
        }catch (e: IndexOutOfBoundsException) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }
    
    // @TestCase
    // public func utilTest02(): Unit {
    //     var sc = Zip4cjUtil.epochToExtendedDosTime(10)
    //     @Assert(sc, -335413248)
    // }

    // @TestCase
    // public func utilTest03(): Unit {
    //     var returnTag = 0
    //     try {
    //         Zip4cjUtil.dosToExtendedEpochTme(101)
    //     }catch (e: IllegalArgumentException) {
    //         returnTag = 1
    //     }
    //     @Assert(returnTag, 1)
    // }

    // @TestCase
    // public func utilTest04(): Unit {
    //     var sc = Zip4cjUtil.convertCharArrayToByteArray(Array<Rune>(),true)
    //     var sc1 = Zip4cjUtil.convertCharArrayToByteArray(Array<Rune>(),false)
    //     @Assert(sc.toString(), "[]")
    //     @Assert(sc1.toString(), "[]")
    // }


}
