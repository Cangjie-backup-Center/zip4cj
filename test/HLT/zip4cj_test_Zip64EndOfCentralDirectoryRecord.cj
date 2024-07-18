//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*
import  charset.*
import  charset.encoding.*
import  zip4cj.*
import std.math.*

@Test
public class Zip64EndOfCentralDirectoryRecordTest {
    @TestCase
    func Zip64EndOfCentralDirectoryRecord01(): Unit {
        var record = Zip64EndOfCentralDirectoryRecord()
        @Assert(record.getSizeOfZip64EndCentralDirectoryRecord(),0)
        record.setSizeOfZip64EndCentralDirectoryRecord(0)
        @Assert(record.getSizeOfZip64EndCentralDirectoryRecord(),0)
        record.setSizeOfZip64EndCentralDirectoryRecord(-9223372036854775808)
        @Assert(record.getSizeOfZip64EndCentralDirectoryRecord(),-9223372036854775808)
        record.setSizeOfZip64EndCentralDirectoryRecord(9223372036854775807)
        @Assert(record.getSizeOfZip64EndCentralDirectoryRecord(),9223372036854775807)
    }

    @TestCase
    func Zip64EndOfCentralDirectoryRecord02(): Unit {
        var record = Zip64EndOfCentralDirectoryRecord()
        @Assert(record.getVersionMadeBy(),0)
        record.setVersionMadeBy(0)
        @Assert(record.getVersionMadeBy(),0)
        record.setVersionMadeBy(-2147483648)
        @Assert(record.getVersionMadeBy(),-2147483648)
        record.setVersionMadeBy(2147483647)
        @Assert(record.getVersionMadeBy(),2147483647)
    }

    @TestCase
    func Zip64EndOfCentralDirectoryRecord03(): Unit {
        var record = Zip64EndOfCentralDirectoryRecord()
        @Assert(record.getVersionNeededToExtract(),0)
        record.setVersionNeededToExtract(0)
        @Assert(record.getVersionNeededToExtract(),0)
        record.setVersionNeededToExtract(-2147483648)
        @Assert(record.getVersionNeededToExtract(),-2147483648)
        record.setVersionNeededToExtract(2147483647)
        @Assert(record.getVersionNeededToExtract(),2147483647)
    }

    @TestCase
    func Zip64EndOfCentralDirectoryRecord04(): Unit {
        var record = Zip64EndOfCentralDirectoryRecord()
        @Assert(record.getNumberOfThisDisk(),0)
        record.setNumberOfThisDisk(0)
        @Assert(record.getNumberOfThisDisk(),0)
        record.setNumberOfThisDisk(-2147483648)
        @Assert(record.getNumberOfThisDisk(),-2147483648)
        record.setNumberOfThisDisk(2147483647)
        @Assert(record.getNumberOfThisDisk(),2147483647)
    }

    @TestCase
    func Zip64EndOfCentralDirectoryRecord05(): Unit {
        var record = Zip64EndOfCentralDirectoryRecord()
        @Assert(record.getNumberOfThisDiskStartOfCentralDirectory(),0)
        record.setNumberOfThisDiskStartOfCentralDirectory(0)
        @Assert(record.getNumberOfThisDiskStartOfCentralDirectory(),0)
        record.setNumberOfThisDiskStartOfCentralDirectory(-2147483648)
        @Assert(record.getNumberOfThisDiskStartOfCentralDirectory(),-2147483648)
        record.setNumberOfThisDiskStartOfCentralDirectory(2147483647)
        @Assert(record.getNumberOfThisDiskStartOfCentralDirectory(),2147483647)
    }

    @TestCase
    func Zip64EndOfCentralDirectoryRecord06(): Unit {
        var record = Zip64EndOfCentralDirectoryRecord()
        @Assert(record.getTotalNumberOfEntriesInCentralDirectoryOnThisDisk(),0)
        record.setTotalNumberOfEntriesInCentralDirectoryOnThisDisk(0)
        @Assert(record.getTotalNumberOfEntriesInCentralDirectoryOnThisDisk(),0)
        record.setTotalNumberOfEntriesInCentralDirectoryOnThisDisk(-9223372036854775808)
        @Assert(record.getTotalNumberOfEntriesInCentralDirectoryOnThisDisk(),-9223372036854775808)
        record.setTotalNumberOfEntriesInCentralDirectoryOnThisDisk(9223372036854775807)
        @Assert(record.getTotalNumberOfEntriesInCentralDirectoryOnThisDisk(),9223372036854775807)
    }

    @TestCase
    func Zip64EndOfCentralDirectoryRecord07(): Unit {
        var record = Zip64EndOfCentralDirectoryRecord()
        @Assert(record.getTotalNumberOfEntriesInCentralDirectory(),0)
        record.setTotalNumberOfEntriesInCentralDirectory(0)
        @Assert(record.getTotalNumberOfEntriesInCentralDirectory(),0)
        record.setTotalNumberOfEntriesInCentralDirectory(-9223372036854775808)
        @Assert(record.getTotalNumberOfEntriesInCentralDirectory(),-9223372036854775808)
        record.setTotalNumberOfEntriesInCentralDirectory(9223372036854775807)
        @Assert(record.getTotalNumberOfEntriesInCentralDirectory(),9223372036854775807)
    }

    @TestCase
    func Zip64EndOfCentralDirectoryRecord08(): Unit {
        var record = Zip64EndOfCentralDirectoryRecord()
        @Assert(record.getSizeOfCentralDirectory(),0)
        record.setSizeOfCentralDirectory(0)
        @Assert(record.getSizeOfCentralDirectory(),0)
        record.setSizeOfCentralDirectory(-9223372036854775808)
        @Assert(record.getSizeOfCentralDirectory(),-9223372036854775808)
        record.setSizeOfCentralDirectory(9223372036854775807)
        @Assert(record.getSizeOfCentralDirectory(),9223372036854775807)
    }

    @TestCase
    func Zip64EndOfCentralDirectoryRecord09(): Unit {
        var record = Zip64EndOfCentralDirectoryRecord()
        @Assert(record.getOffsetStartCentralDirectoryWRTStartDiskNumber(),-1)
        record.setOffsetStartCentralDirectoryWRTStartDiskNumber(0)
        @Assert(record.getOffsetStartCentralDirectoryWRTStartDiskNumber(),0)
        record.setOffsetStartCentralDirectoryWRTStartDiskNumber(-9223372036854775808)
        @Assert(record.getOffsetStartCentralDirectoryWRTStartDiskNumber(),-9223372036854775808)
        record.setOffsetStartCentralDirectoryWRTStartDiskNumber(9223372036854775807)
        @Assert(record.getOffsetStartCentralDirectoryWRTStartDiskNumber(),9223372036854775807)
    }

    @TestCase
    func Zip64EndOfCentralDirectoryRecord10(): Unit {
        var buf = Array<Byte>([1, 2, 3, 6, 5, 47, 8, 98, 7, 8, 9, 45])
        var buf1 = Array<Byte>([])
        var record = Zip64EndOfCentralDirectoryRecord()
        @Assert(record.getExtensibleDataSector(),None)
        record.setExtensibleDataSector(buf)
        @Assert(record.getExtensibleDataSector(),buf)
        record.setExtensibleDataSector(buf1)
        @Assert(record.getExtensibleDataSector(),buf1)
    }
}
