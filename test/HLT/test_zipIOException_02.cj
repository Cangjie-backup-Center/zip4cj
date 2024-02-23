//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
// sources_file:a.txt
// sources_file:archive_with_invalid_zip64_headers.zip
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
public class AesKeyStrengthTest {
    @TestCase
    func PasswordCallback01(): Unit {
        var src=PasswordCallbacks()
        @Assert(src.getPassword().size, 0)
    }

    @TestCase
    func PasswordCallback02(): Unit {
        var src=SymbolicLinkAction.INCLUDE_LINK_ONLY
        var src1=SymbolicLinkAction.INCLUDE_LINKED_FILE_ONLY
        @Assert(src==src1, false)
    }

    @TestCase
    func PasswordCallback03(): Unit {
        var src=SymbolicLinkAction.INCLUDE_LINKED_FILE_ONLY
        var src1=SymbolicLinkAction.INCLUDE_LINK_AND_LINKED_FILE
        @Assert(src==src1, false)
    }

    @TestCase
    func PasswordCallback04(): Unit {
        var src=SymbolicLinkAction.INCLUDE_LINK_AND_LINKED_FILE
        var src1=SymbolicLinkAction.INCLUDE_LINK_AND_LINKED_FILE
        @Assert(src==src1, true)
    }

    @TestCase
    func PasswordCallback05(): Unit {
        var src=ExcludeFileFilters()
        @Assert(src.isExcluded(Path("a.txt")), true)
    }

    @TestCase
    func PasswordCallback06(): Unit {
        var src=ExcludeFileFilters()
        @Assert(src.isExcluded(Path("archive_with_invalid_zip64_headers.zip")), true)
    }

    @TestCase
    func PasswordCallback07(): Unit {
        var src=ExcludeFileFilters()
        @Assert(src.isExcluded(Path("456.txt")), false)
    }
}
public class  PasswordCallbacks <: PasswordCallback {
    public func getPassword(): Array<Char> {
        return Array<Char>()
    }
}
public class  ExcludeFileFilters <: ExcludeFileFilter {
    public func isExcluded(file: Path): Bool {
        File.exists(file)
    }
}