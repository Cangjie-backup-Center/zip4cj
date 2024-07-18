/* EXEC: cjc %import-path %L %l %f
EXEC: ./main */

import  zip4cj.*
import std.os.posix.*
import std.fs.*
import std.io.*
import std.sync.*
import std.random.*
import std.time.*
// "/home/liyanqing/NEW_FILE_0"
// zip64 测试用例
main() { 
    let entrySize = 4294967296
    let zipParameters = ZipParameters();
    zipParameters.setCompressionMethod(CompressionMethod.STORE);
    zipParameters.setEntrySize(entrySize);
    createZip64FileWithEntries(1, entrySize, zipParameters);
    0
}

func createZip64FileWithEntries(numberOfEntries: Int64, eachEntrySize: Int64, zipParameters: ZipParameters): Unit {
    let readBuffer = Array<Byte>(8192, item: 0)
    var readLen = 0
    let generatedZipFile = File("output.zip", OpenOption.Create(true))
    
    try(zipOutputStream = ZipOutputStream(BufferedOutputStream<File>(generatedZipFile))) {
        for (i in 0..numberOfEntries) {
            zipParameters.setFileNameInZip("FILE_${i}");
            zipOutputStream.putNextEntry(zipParameters);
            let input = File("/home/liyanqing/FILE_TEST", Open(true, false))

            var count = input.read(readBuffer)
            while(count > 0) {
                zipOutputStream.write(readBuffer[0..count]);
                count = input.read(readBuffer)
            }
            zipOutputStream.closeEntry();
        }
    }
}

