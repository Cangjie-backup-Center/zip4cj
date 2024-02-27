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
    test.utilTest05()
    return 0
}
@Test
public class utilTest {

    @TestCase
    public func utilTest05(): Unit {
        var sc = ZipFile(Path("123.txt"))
        ZipFile(Path("123.txt"), password: Array<Char>())
        var returnTag = 0
        try {
            sc.createSplitZipFile(ByteArrayStream(),ZipParameters(),true,6)
        }catch (e: Exception) {
            returnTag = 1
        }
        @Assert(returnTag, 1)
    }

}
