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
from std import os.posix.*
from charset import charset.*
from charset import charset.encoding.*
from zip4cj import zip4cj.*
@Test
public class FileUtilsTest {
    @TestCase
    func FileUtils01(): Unit {
        FileUtils.assertFilesExist(ArrayList<Path>(),SymbolicLinkAction.INCLUDE_LINK_ONLY)
        var returnTag = 0
        try {
            FileUtils.isNumberedSplitFile(Path(""))
        } catch (e: IllegalArgumentException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }

    @TestCase
    func FileUtils02(): Unit {
        var returnTag = 0
        try {
            FileUtils.assertFilesExist(ArrayList<Path>([Path("jar-dir-lfh-and-fh-entry-size-2.jar")]),SymbolicLinkAction.INCLUDE_LINK_ONLY)
        } catch (e: ZipException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }

    @TestCase
    func FileUtils03(): Unit {
        var returnTag = 0
        try {
            FileUtils.assertFilesExist(ArrayList<Path>([Path("dsad")]),SymbolicLinkAction.INCLUDE_LINK_ONLY)
        } catch (e: FSException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }

    @TestCase
    func FileUtils04(): Unit {
        var returnTag = 0
        try {
            FileUtils.assertFilesExist(ArrayList<Path>([Path("dsad你好456")]),SymbolicLinkAction.INCLUDE_LINK_ONLY)
        } catch (e: FSException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }

    @TestCase
    func FileUtils05(): Unit {
        var returnTag = 0
        try {
            FileUtils.assertFilesExist(ArrayList<Path>([Path("archive_with_invalid_zip64_headers.zip")]),SymbolicLinkAction.INCLUDE_LINK_ONLY)
        } catch (e: ZipException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }
    
    @TestCase
    func FileUtils06(): Unit {
        var returnTag = 0
        try {
            FileUtils.isNumberedSplitFile(Path(""))
        } catch (e: IllegalArgumentException) {
            returnTag = 1
        }
        @Assert(returnTag , 1)
    }

    @TestCase
    func FileUtils07(): Unit {
        let sc = FileUtils.isNumberedSplitFile(Path("6456546456@#￥￥%"))
        @Assert(sc, false)
    }

    @TestCase
    func FileUtils08(): Unit {
        let sc = FileUtils.isNumberedSplitFile(Path("jar-dir-lfh-and-fh-entry-size-2.jar"))
        @Assert(sc, false)
    }
}