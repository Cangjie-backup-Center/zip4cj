//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
from std import collection.*
from std import fs.*
from std import io.*
from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.encoding.*
from zip4cj import zip4cj.*

@Test
public class ZipHeaderTest {
    @TestCase
    func EndOfCentralDirectoryRecord01(): Unit {
        var directoryrecord = EndOfCentralDirectoryRecord()
        @Assert(directoryrecord.getNumberOfThisDisk(),0)
        directoryrecord.setNumberOfThisDisk(0)
        @Assert(directoryrecord.getNumberOfThisDisk(),0)
        directoryrecord.setNumberOfThisDisk(-2147483648)
        @Assert(directoryrecord.getNumberOfThisDisk(),-2147483648)
        directoryrecord.setNumberOfThisDisk(2147483647)
        @Assert(directoryrecord.getNumberOfThisDisk(),2147483647)
    }

    @TestCase
    func EndOfCentralDirectoryRecord02(): Unit {
        var directoryrecord = EndOfCentralDirectoryRecord()
        @Assert(directoryrecord.getNumberOfThisDiskStartOfCentralDir(),0)
        directoryrecord.setNumberOfThisDiskStartOfCentralDir(0)
        @Assert(directoryrecord.getNumberOfThisDiskStartOfCentralDir(),0)
        directoryrecord.setNumberOfThisDiskStartOfCentralDir(-2147483648)
        @Assert(directoryrecord.getNumberOfThisDiskStartOfCentralDir(),-2147483648)
        directoryrecord.setNumberOfThisDiskStartOfCentralDir(2147483647)
        @Assert(directoryrecord.getNumberOfThisDiskStartOfCentralDir(),2147483647)
    }

    @TestCase
    func EndOfCentralDirectoryRecord03(): Unit {
        var directoryrecord = EndOfCentralDirectoryRecord()
        @Assert(directoryrecord.getTotalNumberOfEntriesInCentralDirectoryOnThisDisk(),0)
        directoryrecord.setTotalNumberOfEntriesInCentralDirectoryOnThisDisk(0)
        @Assert(directoryrecord.getTotalNumberOfEntriesInCentralDirectoryOnThisDisk(),0)
        directoryrecord.setTotalNumberOfEntriesInCentralDirectoryOnThisDisk(-2147483648)
        @Assert(directoryrecord.getTotalNumberOfEntriesInCentralDirectoryOnThisDisk(),-2147483648)
        directoryrecord.setTotalNumberOfEntriesInCentralDirectoryOnThisDisk(2147483647)
        @Assert(directoryrecord.getTotalNumberOfEntriesInCentralDirectoryOnThisDisk(),2147483647)
    }

    @TestCase
    func EndOfCentralDirectoryRecord04(): Unit {
        var directoryrecord = EndOfCentralDirectoryRecord()
        @Assert(directoryrecord.getTotalNumberOfEntriesInCentralDirectory(),0)
        directoryrecord.setTotalNumberOfEntriesInCentralDirectory(0)
        @Assert(directoryrecord.getTotalNumberOfEntriesInCentralDirectory(),0)
        directoryrecord.setTotalNumberOfEntriesInCentralDirectory(-2147483648)
        @Assert(directoryrecord.getTotalNumberOfEntriesInCentralDirectory(),-2147483648)
        directoryrecord.setTotalNumberOfEntriesInCentralDirectory(2147483647)
        @Assert(directoryrecord.getTotalNumberOfEntriesInCentralDirectory(),2147483647)
    }

    @TestCase
    func EndOfCentralDirectoryRecord05(): Unit {
        var directoryrecord = EndOfCentralDirectoryRecord()
        @Assert(directoryrecord.getSizeOfCentralDirectory(),0)
        directoryrecord.setSizeOfCentralDirectory(0)
        @Assert(directoryrecord.getSizeOfCentralDirectory(),0)
        directoryrecord.setSizeOfCentralDirectory(-2147483648)
        @Assert(directoryrecord.getSizeOfCentralDirectory(),-2147483648)
        directoryrecord.setSizeOfCentralDirectory(2147483647)
        @Assert(directoryrecord.getSizeOfCentralDirectory(),2147483647)
    }

    @TestCase
    func EndOfCentralDirectoryRecord06(): Unit {
        var directoryrecord = EndOfCentralDirectoryRecord()
        @Assert(directoryrecord.getOffsetOfStartOfCentralDirectory(),0)
        directoryrecord.setOffsetOfStartOfCentralDirectory(0)
        @Assert(directoryrecord.getOffsetOfStartOfCentralDirectory(),0)
        directoryrecord.setOffsetOfStartOfCentralDirectory(-2147483648)
        @Assert(directoryrecord.getOffsetOfStartOfCentralDirectory(),-2147483648)
        directoryrecord.setOffsetOfStartOfCentralDirectory(2147483647)
        @Assert(directoryrecord.getOffsetOfStartOfCentralDirectory(),2147483647)
    }

    @TestCase
    func EndOfCentralDirectoryRecord07(): Unit {
        var directoryrecord = EndOfCentralDirectoryRecord()
        @Assert(directoryrecord.getOffsetOfEndOfCentralDirectory(),0)
        directoryrecord.setOffsetOfEndOfCentralDirectory(0)
        @Assert(directoryrecord.getOffsetOfEndOfCentralDirectory(),0)
        directoryrecord.setOffsetOfEndOfCentralDirectory(-2147483648)
        @Assert(directoryrecord.getOffsetOfEndOfCentralDirectory(),-2147483648)
        directoryrecord.setOffsetOfEndOfCentralDirectory(2147483647)
        @Assert(directoryrecord.getOffsetOfEndOfCentralDirectory(),2147483647)
    }

    @TestCase
    func EndOfCentralDirectoryRecord08(): Unit {
        var directoryrecord = EndOfCentralDirectoryRecord()
        @Assert(directoryrecord.getComment(),"")
        directoryrecord.setComment("")
        @Assert(directoryrecord.getComment(),"")
        directoryrecord.setComment("cangejie")
        @Assert(directoryrecord.getComment(),"cangejie")
        directoryrecord.setComment("仓颉123")
        @Assert(directoryrecord.getComment(),"仓颉123")
    }

    @TestCase
    func Zip64EndOfCentralDirectoryLocator01(): Unit {
        var directoryLocator = Zip64EndOfCentralDirectoryLocator()
        @Assert(directoryLocator.getNumberOfDiskStartOfZip64EndOfCentralDirectoryRecord(),0)
        directoryLocator.setNumberOfDiskStartOfZip64EndOfCentralDirectoryRecord(0)
        @Assert(directoryLocator.getNumberOfDiskStartOfZip64EndOfCentralDirectoryRecord(),0)
        directoryLocator.setNumberOfDiskStartOfZip64EndOfCentralDirectoryRecord(-2147483648)
        @Assert(directoryLocator.getNumberOfDiskStartOfZip64EndOfCentralDirectoryRecord(),-2147483648)
        directoryLocator.setNumberOfDiskStartOfZip64EndOfCentralDirectoryRecord(2147483647)
        @Assert(directoryLocator.getNumberOfDiskStartOfZip64EndOfCentralDirectoryRecord(),2147483647)
    }

    @TestCase
    func Zip64EndOfCentralDirectoryLocator02(): Unit {
        var directoryLocator = Zip64EndOfCentralDirectoryLocator()
        @Assert(directoryLocator.getOffsetZip64EndOfCentralDirectoryRecord(),0)
        directoryLocator.setOffsetZip64EndOfCentralDirectoryRecord(0)
        @Assert(directoryLocator.getOffsetZip64EndOfCentralDirectoryRecord(),0)
        directoryLocator.setOffsetZip64EndOfCentralDirectoryRecord(-2147483648)
        @Assert(directoryLocator.getOffsetZip64EndOfCentralDirectoryRecord(),-2147483648)
        directoryLocator.setOffsetZip64EndOfCentralDirectoryRecord(2147483647)
        @Assert(directoryLocator.getOffsetZip64EndOfCentralDirectoryRecord(),2147483647)
    }

    @TestCase
    func Zip64EndOfCentralDirectoryLocator03(): Unit {
        var directoryLocator = Zip64EndOfCentralDirectoryLocator()
        @Assert(directoryLocator.getTotalNumberOfDiscs(),0)
        directoryLocator.setTotalNumberOfDiscs(0)
        @Assert(directoryLocator.getTotalNumberOfDiscs(),0)
        directoryLocator.setTotalNumberOfDiscs(-2147483648)
        @Assert(directoryLocator.getTotalNumberOfDiscs(),-2147483648)
        directoryLocator.setTotalNumberOfDiscs(2147483647)
        @Assert(directoryLocator.getTotalNumberOfDiscs(),2147483647)
    }
}
