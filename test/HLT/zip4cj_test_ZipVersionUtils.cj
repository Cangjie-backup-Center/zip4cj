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

//sources_file:sample.pdf:after_deflate_remaining_bytes.bin:sample_text_large.txt:가나다.abc:jar-dir-lfh-and-fh-entry-size-2.jar:MobaXterm.2024-01-03_11.24.ini
//sources_file:libssl.so.3:picture.webp:öüäöäö.rar:1COMM_v24tagswithalbumimage1.mp3



@When[os == "Windows"]
func CrcUtil06_Int64(): UInt32 {
    1528207236
}

@When[os != "Windows"]
func CrcUtil06_Int64(): UInt32 {
    2315563306
}

@When[os == "Windows"]
func ZipVersionUtils01_Int64(): Int32 {
    51
}

@When[os != "Windows"]
func ZipVersionUtils01_Int64(): Int32 {
    819
}

@Test
public class ZipVersionUtilsTest {
    @TestCase
    func ZipVersionUtils01(): Unit {
        var zipparameters = ZipParameters()
        var rawio = RawIO()
        var versionmadeby: Int32 = ZipVersionUtils.determineVersionMadeBy(zipparameters, rawio)
        @Assert(versionmadeby,ZipVersionUtils01_Int64())
    }

    @TestCase
    func ZipVersionUtils02(): Unit {
        var zipparameters = ZipParameters()
        var versionneededtoextract = ZipVersionUtils.determineVersionNeededToExtract(zipparameters)
        @Assert(versionneededtoextract.getCode(),20)
    }

    @TestCase
    func CRC3201(): Unit {
        var byte = Array<Byte>([99, 97, 110, 103, 106, 105, 101])
        var crc = CRC32()
        crc.update(byte)
        @Assert(crc.getValue(),2832095392)
    }

    @TestCase
    func CRC3202(): Unit {
        var byte = Array<Byte>([])
        var crc = CRC32()
        crc.update(byte)
        @Assert(crc.getValue(),0)
    }

    @TestCase
    func CRC3203(): Unit {
        var byte = Array<Byte>(1024, item: 0)
        var crc = CRC32()
        crc.update(byte)
        @Assert(crc.getValue(),4021661486)
    }

    @TestCase
    func CRC3204(): Unit {
        var byte = Array<Byte>(1024, item: 0)
        var crc = CRC32()
        crc.update(byte)
        crc.reset()
        @Assert(crc.getValue(),0)
    }

    @TestCase
    func CRC3205(): Unit {
        var byte = Array<Byte>([])
        var crc = CRC32()
        crc.update(byte)
        crc.reset()
        @Assert(crc.getValue(),0)
    }

    @TestCase
    func CrcUtil01(): Unit {
        var filecrc = CrcUtil.computeFileCrc(Path("sample.pdf"), ProgressMonitor())
        @Assert(filecrc,2730662664)
    }

    @TestCase
    func CrcUtil02(): Unit {
        var filecrc = CrcUtil.computeFileCrc(Path("after_deflate_remaining_bytes.bin"), ProgressMonitor())
        @Assert(filecrc,2477444883)
    }

    @TestCase
    func CrcUtil03(): Unit {
        var filecrc = CrcUtil.computeFileCrc(Path("sample_text_large.txt"), ProgressMonitor())
        @Assert(filecrc,1032427199)
    }

    @TestCase
    func CrcUtil04(): Unit {
        var filecrc = CrcUtil.computeFileCrc(Path("가나다.abc"), ProgressMonitor())
        @Assert(filecrc,3172388044)
    }

    @TestCase
    func CrcUtil05(): Unit {
        var filecrc = CrcUtil.computeFileCrc(Path("jar-dir-lfh-and-fh-entry-size-2.jar"), ProgressMonitor())
        @Assert(filecrc,3090601727)
    }

    @TestCase
    func CrcUtil06(): Unit {
        var filecrc: UInt32 = CrcUtil.computeFileCrc(Path("MobaXterm.2024-01-03_11.24.ini"), ProgressMonitor())
        @Assert(filecrc,CrcUtil06_Int64())
    }

    @TestCase
    func CrcUtil07(): Unit {
        var filecrc = CrcUtil.computeFileCrc(Path("libssl.so.3"), ProgressMonitor())
        @Assert(filecrc,3040978623)
    }

    @TestCase
    func CrcUtil08(): Unit {
        var filecrc = CrcUtil.computeFileCrc(Path("picture.webp"), ProgressMonitor())
        @Assert(filecrc,112309244)
    }

    @TestCase
    func CrcUtil09(): Unit {
        var filecrc = CrcUtil.computeFileCrc(Path("öüäöäö.rar"), ProgressMonitor())
        @Assert(filecrc,2838815434)
    }

    @TestCase
    func CrcUtil10(): Unit {
        var filecrc = CrcUtil.computeFileCrc(Path("1COMM_v24tagswithalbumimage1.mp3"), ProgressMonitor())
        @Assert(filecrc,3292982260)
    }

    @TestCase
    func VersionMadeBy1(): Unit {
        var madeby = VersionMadeBy.SPECIFICATION_VERSION.getCode()
        var madeby1 = VersionMadeBy.WINDOWS.getCode()
        var madeby2 = VersionMadeBy.UNIX.getCode()
        @Assert(madeby,51)
        @Assert(madeby1,0)
        @Assert(madeby2,3)
    }

    @TestCase
    func VersionNeededToExtract1(): Unit {
        var toextract = VersionNeededToExtract.DEFAULT.getCode()
        var toextract1 = VersionNeededToExtract.DEFLATE_COMPRESSED.getCode()
        var toextract2 = VersionNeededToExtract.ZIP_64_FORMAT.getCode()
        var toextract3 = VersionNeededToExtract.AES_ENCRYPTED.getCode()
        @Assert(toextract,10)
        @Assert(toextract1,20)
        @Assert(toextract2,45)
        @Assert(toextract3,51)
    }
}
