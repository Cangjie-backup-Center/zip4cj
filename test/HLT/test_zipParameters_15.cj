//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
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
public class ZipParametersTest {
    @TestCase
    func ZipParameters01(): Unit {
        var zipParameters=ZipParameters()
        @Assert(zipParameters.getSymbolicLinkAction()==SymbolicLinkAction.INCLUDE_LINK_ONLY , false)
    }

    @TestCase
    func ZipParameters02(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setSymbolicLinkAction(SymbolicLinkAction.INCLUDE_LINKED_FILE_ONLY)
        @Assert(zipParameters.getSymbolicLinkAction()==SymbolicLinkAction.INCLUDE_LINKED_FILE_ONLY , true)
    }

    @TestCase
    func ZipParameters03(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setSymbolicLinkAction(SymbolicLinkAction.INCLUDE_LINKED_FILE_ONLY)
        @Assert(zipParameters.getSymbolicLinkAction()==SymbolicLinkAction.INCLUDE_LINK_AND_LINKED_FILE , false)
    }

    @TestCase
    func ZipParameters04(): Unit {
        var zipParameters=ZipParameters()
        try {
            zipParameters.getExcludeFileFilter().getOrThrow()
        } catch (e: NoneValueException) {
            @Assert(e.toString() , "NoneValueException")
        }
    }

    @TestCase
    func ZipParameters05(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setExcludeFileFilter(ExcludeFileFilterTest())
        @Assert(zipParameters.getExcludeFileFilter().getOrThrow().isExcluded(Path("66")) , true)
    }
    @TestCase
    func ZipParameters06(): Unit {
        var zipParameters=ZipParameters()
        @Assert(zipParameters.isUnixMode() , false)
    }

    @TestCase
    func ZipParameters07(): Unit {
        var zipParameters=ZipParameters()
        zipParameters.setUnixMode(true)
        @Assert(zipParameters.isUnixMode() , true)
    }
}
public class ExcludeFileFilterTest <: ExcludeFileFilter {
    public func isExcluded(_: Path): Bool {
        return true
    }
}