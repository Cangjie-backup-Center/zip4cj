//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*
import std.os.*
import std.os.posix.*
import  charset.*
import  charset.encoding.*
import  zip4cj.*

//sources_file:123.txt:MP4.mp4:archive-with-no-dir-entries1.zip:a.txt:1COMM_v24tagswithalbumimage1.mp3:missing_exended_local_file_header.zip
//sources_file:end_of_cen_dir_not_at_expected_position.zip:video.zip

import  zip4cj.*
import std.os.posix.*
import std.fs.*
import std.io.*
import std.sync.*
import std.random.*
import std.time.*

@Test
public class ZipParametersTest {
    init() {
        let entrySize = 4294967296
        let zipParameters = ZipParameters()
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        zipParameters.setEntrySize(entrySize)
        createZip64FileWithEntries(1, entrySize, zipParameters)
        let zipFile = ZipFile("outputa64.zip")
    }

    @TestCase
    func ZipParameters01(): Unit {
        let zipFile1 = ZipFile("outputa64.zip")
        Directory.create("contrast/r", recursive: true)
        zipFile1.extractAll("./contrast/r")

        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        Directory.create("contrast/rr", recursive: true)
        let zipFile = ZipFile("contrast/rr/outputa64.zip")
        let files = Path("./contrast/r/FILE_0")
        zipFile.createSplitZipFile([files], zipParameters, false, 65536)

        let zipFile2 = ZipFile("contrast/rr/outputa64.zip")
        Directory.create("contrast/rrr", recursive: true)
        zipFile2.extractAll("./contrast/rrr")

        let input: File = File("contrast/rrr/FILE_0", Open(true, true))
        let input1: File = File("contrast/r/FILE_0", Open(true, true))
        let buf_old = Array<Byte>(8192, item: 0)
        let buf_new = Array<Byte>(8192, item: 0)
        var len1 = input.read(buf_new)
        var len2 = input1.read(buf_old)
        while (len1 > 0 && len2 > 0) {
            @Assert(len1, len2)
            @Assert(buf_new, buf_old)
            len1 = input.read(buf_new)
            len2 = input1.read(buf_old)
        }
    }

    @TestCase
    func ZipParameters02(): Unit {
        let zipFile1 = ZipFile("outputa64.zip")
        Directory.create("contrast/t", recursive: true)
        zipFile1.extractAll("./contrast/t")

        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        Directory.create("contrast/tt", recursive: true)
        let zipFile = ZipFile("contrast/tt/outputa64.zip")
        let files = Path("./contrast/t/FILE_0")
        zipFile.createSplitZipFile([files], zipParameters, false, 65536)

        let zipFile2 = ZipFile("contrast/tt/outputa64.zip")
        Directory.create("contrast/ttt", recursive: true)
        zipFile2.extractAll("./contrast/ttt")

        let input: File = File("contrast/t/FILE_0", Open(true, true))
        let input1: File = File("contrast/ttt/FILE_0", Open(true, true))
        let buf_old = Array<Byte>(8192, item: 0)
        let buf_new = Array<Byte>(8192, item: 0)
        var len1 = input.read(buf_new)
        var len2 = input1.read(buf_old)
        while (len1 > 0 && len2 > 0) {
            @Assert(len1, len2)
            @Assert(buf_new, buf_old)
            len1 = input.read(buf_new)
            len2 = input1.read(buf_old)
        }
    }

    @TestCase
    func ZipParameters03(): Unit {
        let zipFile1 = ZipFile("outputa64.zip")
        Directory.create("contrast/o", recursive: true)
        zipFile1.extractAll("./contrast/o")

        let zipParameters = ZipParameters();
        zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)
        Directory.create("contrast/oo", recursive: true)
        let zipFile = ZipFile("contrast/oo/outputa64.zip")
        let files = Path("./contrast/o/FILE_0")
        zipFile.createSplitZipFile([files], zipParameters, true, 1073741824)

        let zipFile2 = ZipFile("contrast/oo/outputa64.zip")
        Directory.create("contrast/ooo", recursive: true)
        zipFile2.extractAll("./contrast/ooo")

        let input: File = File("contrast/o/FILE_0", Open(true, true))
        let input1: File = File("contrast/ooo/FILE_0", Open(true, true))
        let buf_old = Array<Byte>(8192, item: 0)
        let buf_new = Array<Byte>(8192, item: 0)
        var len1 = input.read(buf_new)
        var len2 = input1.read(buf_old)
        while (len1 > 0 && len2 > 0) {
            @Assert(len1, len2)
            @Assert(buf_new, buf_old)
            len1 = input.read(buf_new)
            len2 = input1.read(buf_old)
        }
    }
}

class RandomInputStream <: InputStream {
    var count: Int64 = 0
    let ran = Random()
    public init(c: Int64) {
        this.count = c
    }
    public func read(b: Array<Byte>): Int64 {
        if (count <= 0) {
            return 0
        } else if (count <= b.size) {
            for (j in 0..count) {
                b[j] = ran.nextUInt8()
            }
            let cc = count
            count = 0
            return cc
        } else {
            for (j in 0..b.size) {
                b[j] = ran.nextUInt8()
            }
            count -= b.size
            return b.size
        }
    }
}

func createZip64FileWithEntries(numberOfEntries: Int64, eachEntrySize: Int64, zipParameters: ZipParameters): Unit {
    let readBuffer = Array<Byte>(8192, item: 0)
    var readLen = 0
    let generatedZipFile = File("outputa64.zip", OpenOption.Create(true))

    try (zipOutputStream = ZipOutputStream(BufferedOutputStream<File>(generatedZipFile))) {
        for (i in 0..numberOfEntries) {
            zipParameters.setFileNameInZip("FILE_${i}");
            zipOutputStream.putNextEntry(zipParameters);
            let input = RandomInputStream(eachEntrySize)

            var count = input.read(readBuffer)
            while (count > 0) {
                zipOutputStream.write(readBuffer[0..count]);
                count = input.read(readBuffer)
            }
            zipOutputStream.closeEntry();
        }
    }
}
