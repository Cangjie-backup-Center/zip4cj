// RESOURCES: output.zip
// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import  zip4cj.util.*
import  zip4cj.model.*
import  zip4cj.tasks.*
import  zip4cj.progress.*
import  zip4cj.exception.*
import  zip4cj.io.outputstream.*
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*
import  charset.*
import  charset.encoding.*
main() { 

    let test = progressTest()
    test.progressTest01()
    test.progressTest02()
    test.progressTest03()
    test.progressTest04()
    test.progressTest05()
    return 0
}
@Test
public class progressTest {

    @TestCase
    public func progressTest01(): Unit {
        let sc = ProgressMonitorState.READY
        let sc1 = ProgressMonitorState.BUSY
        @Assert(sc==sc, true)
        @Assert(sc1==sc1, true)
    }

    @TestCase
    public func progressTest02(): Unit {
        let sc = ProgressMonitor()
        sc.getCurrentTask()
        let src = sc.getPercentDone()
        @Assert(src, 0)
    }

    @TestCase
    public func progressTest03(): Unit {
        let sc = ProgressMonitor()
        sc.getResult()
        sc.setFileName("666699")
        let src = sc.getFileName()
        @Assert(src, "666699")
    }

    @TestCase
    public func progressTest04(): Unit {
        let sc = ProgressMonitor()
        sc.setException(ZipException(""))
        let src = sc.getException().toString()
        @Assert(src, "ZipException")
    }

    @TestCase
    public func progressTest05(): Unit {
        let sc = ProgressMonitor()
        sc.setPause(false)
        let src = sc.isPause()
        @Assert(src, false)
    }

}