// RESOURCES: output.zip
// RESOURCES: 123.txt
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
        let src = CrcUtil.computeFileCrc(Path("123.txt"),ProgressMonitor())
        @Assert(src, 3904355907)
    }

    @TestCase
    public func utilTest02(): Unit {
        let src = CrcUtil.computeFileCrc(Path("123.txt"),Option<ProgressMonitor>.None)
        @Assert(src, 3904355907)
    }

    @TestCase
    public func utilTest03(): Unit {
        var sc = PasswordCallbacks()
        let sc1 = sc.getPassword().size
        @Assert(sc1, 0)
    }

    @TestCase
    public func utilTest04(): Unit {
        var sc = RandomAccessFile("123.txt",OpenOption.Open(true, false))
        let sc1 = sc.getFilePointer()
        @Assert(sc1, 0)
    }

    @TestCase
    public func utilTest05(): Unit {
        var sc = RandomAccessFile(Path("123.txt"),OpenOption.Open(true, false))
        sc.seek(1)
        let sc1 = sc.read(Array<Byte>())
        @Assert(sc1, 0)
    }

}
public class PasswordCallbacks <: PasswordCallback {

    public func getPassword(): Array<Char>{
        return Array<Char>()
    }
}