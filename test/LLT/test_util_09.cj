// RESOURCES: output.zip
// RESOURCES: 123.txt
// RESOURCES: a.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import zip4cj.util.*
import  zip4cj.*
import zip4cj.progress.*
import std.collection.*
import std.fs.*
import std.io.*
import std.os.posix.*
import std.unittest.*
import std.unittest.testmacro.*
main() { 

    let test = utilTest()
    test.utilTest05()
    return 0
}
@Test
public class utilTest {

    @TestCase
    public func utilTest05(): Unit {
        var sc = ZipFile(Path("123.txt"))
        ZipFile(Path("123.txt"), password: Array<Rune>())
        var returnTag = 0
        try {
            sc.createSplitZipFile(ByteArrayStream(),ZipParameters(),true,6)
        }catch (e: Exception) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

}
