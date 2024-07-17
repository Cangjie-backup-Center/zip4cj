// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import zip4cj.exception.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*
main() { 

    let test = ExceptionTest()
    test.Exception01()
    test.Exception02()
    test.Exception03()
    return 0
}
@Test
public class ExceptionTest {

    @TestCase
    public func Exception01(): Unit {
        let sc = ZipException("asc > 0")
        sc.getType()
        @Assert(sc.toString(), "ZipException: asc > 0")
    }

    @TestCase
    public func Exception02(): Unit {
        let sc = ZipException("input file List is None, cannot create zip file", ZipExceptionType.WRONG_PASSWORD)
        let scc = sc.toString()
        println(scc)
        @Assert(scc, "ZipException: input file List is None, cannot create zip file")
    }

    @TestCase
    public func Exception03(): Unit {
        let sc = ZipIOException("cannot create zip file")
        let sc1 = UnsupportedOperationException()
        let scc = sc.toString()
        println(scc)
        @Assert(scc, "ZipIOException: cannot create zip file")
    }

}