// RESOURCES: output.zip
// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.util.*
from std import collection.*
from std import fs.*
from std import io.*
from std import os.posix.*
from std import unittest.*
from std import unittest.testmacro.*
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