//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
// sources_file:a.txt
// sources_file:archive_with_invalid_zip64_headers.zip
// sources_file:jar-dir-lfh-and-fh-entry-size-2.jar
from std import collection.*
from std import fs.*
from std import io.*
from std import unittest.*
from std import math.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.encoding.*
from zip4cj import zip4cj.*
@Test
public class FileUtilsTest {
    @TestCase
    func FileUtils01(): Unit {
        let sc = FileUtils.readSymbolicLink(Path("a.txt"))
        @Assert(sc, "")
    }

    //https://gitee.com/HW-PLLab/zip4cj/issues/I92XWL?from=project-issue
    @Skip
    @TestCase
    func FileUtils02(): Unit {
        let sc = FileUtils.readSymbolicLink(Path(""))
        @Assert(sc, "")
    }

    @TestCase
    func FileUtils03(): Unit {
        let sc = FileUtils.readSymbolicLink(Path("archive_with_invalid_zip64_headers.zip"))
        @Assert(sc, "")
    }

    @TestCase
    func FileUtils04(): Unit {
        let sc = FileUtils.readSymbolicLink(Path("jar-dir-lfh-and-fh-entry-size-2.jar"))
        @Assert(sc, "")
    }

    @Skip
    @TestCase
    func FileUtils05(): Unit {
        let sc = FileUtils.readSymbolicLink(Path("12125.98"))
        @Assert(sc, "")
    }

    @Skip
    @TestCase
    func FileUtils06(): Unit {
        let sc = FileUtils.readSymbolicLink(Path("#%^$^#$^%"))
        @Assert(sc, "")
    }

    @Skip
    @TestCase
    func FileUtils07(): Unit {
        let sc = FileUtils.readSymbolicLink(Path("zhon中国78893413#%^$^#$^%"))
        @Assert(sc, "")
    }

    @TestCase
    func FileUtils08(): Unit {
        let sc = FileUtils.getDefaultFileAttributes(false)
        @Assert(sc.toString(), "[0, 0, 164, 129]")
    }

    @TestCase
    func FileUtils09(): Unit {
        let sc = FileUtils.getDefaultFileAttributes(true)
        @Assert(sc.toString(), "[0, 0, 237, 65]")
    }

}