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
public class ZipEntryOutputStreamTest { 

    @TestCase
    func ZipEntryOutputStream01(): Unit {
        var zipEntryOutputStream = ZipEntryOutputStream(ByteArrayStream())
        zipEntryOutputStream.write(6)
        @Assert(zipEntryOutputStream.getNumberOfBytesWrittenForThisEntry() , 1)
    }

    @TestCase
    func ZipEntryOutputStream02(): Unit {
        var zipEntryOutputStream = ZipEntryOutputStream(ByteArrayStream())
        zipEntryOutputStream.write(15)
        @Assert(zipEntryOutputStream.getNumberOfBytesWrittenForThisEntry() , 1)
    }

    @TestCase
    func ZipEntryOutputStream03(): Unit {
        var zipEntryOutputStream = ZipEntryOutputStream(ByteArrayStream())
        zipEntryOutputStream.write(7)
        @Assert(zipEntryOutputStream.getNumberOfBytesWrittenForThisEntry() , 1)
    }

    @TestCase
    func ZipEntryOutputStream04(): Unit {
        var zipEntryOutputStream = ZipEntryOutputStream(ByteArrayStream())
        zipEntryOutputStream.closeEntry()
        @Assert(zipEntryOutputStream.getNumberOfBytesWrittenForThisEntry() , 0)
    }

    @TestCase
    func ZipEntryOutputStream05(): Unit {
        var zipEntryOutputStream = ZipEntryOutputStream(ByteArrayStream())
        zipEntryOutputStream.closeEntry()
        @Assert(zipEntryOutputStream.getNumberOfBytesWrittenForThisEntry() , 0)
    }

    @TestCase
    func ZipEntryOutputStream06(): Unit {
        var zipEntryOutputStream = ZipEntryOutputStream(ByteArrayStream())
        zipEntryOutputStream.closeEntry()
        @Assert(zipEntryOutputStream.getNumberOfBytesWrittenForThisEntry() , 0)
    }

    @TestCase
    func ZipEntryOutputStream07(): Unit {
        var zipEntryOutputStream = ZipEntryOutputStream(File("archive_with_invalid_zip64_headers.zip", OpenOption.Open(true, false)))
        zipEntryOutputStream.flush()
        @Assert(zipEntryOutputStream.getNumberOfBytesWrittenForThisEntry() , 0)
    }

    @TestCase
    func ZipEntryOutputStream08(): Unit {
        var zipEntryOutputStream = ZipEntryOutputStream(File("a.txt", OpenOption.Open(true, false)))
        zipEntryOutputStream.flush()
        @Assert(zipEntryOutputStream.getNumberOfBytesWrittenForThisEntry() , 0)
    }

    @TestCase
    func ZipEntryOutputStream09(): Unit {
        var zipEntryOutputStream = ZipEntryOutputStream(File("jar-dir-lfh-and-fh-entry-size-2.jar", OpenOption.Open(true, false)))
        zipEntryOutputStream.flush()
        @Assert(zipEntryOutputStream.getNumberOfBytesWrittenForThisEntry() , 0)
    }
}


