// RESOURCES: output.zip
// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import zip4cj.util.*
import std.collection.*
import std.fs.*
import std.io.*
import std.os.posix.*
import std.unittest.*
import std.unittest.testmacro.*
main() { 

    let test = utilTest()
    test.utilTest03()
    test.utilTest04()
    return 0
}
@Test
public class utilTest {

    @TestCase
    public func utilTest03(): Unit {
        var sc = CRC32()
        sc.update(Array<Byte>(5, item: 6))
        let sc1 = sc.getValue()
        @Assert(sc1, 3619496800)
    }

    @TestCase
    public func utilTest04(): Unit {
        var sc = CRC32()
        sc.update(Array<Byte>(5, item: 6))
        sc.reset()
        let sc1 = sc.getValue()
        @Assert(sc1, 0)
    }
}