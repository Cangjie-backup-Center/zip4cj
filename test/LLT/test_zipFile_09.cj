// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.*
from std import os.posix.*
from std import fs.*
from std import io.*
from std import sync.*
from std import random.*
from std import time.*
// "/home/liyanqing/NEW_FILE_0"
// zip64 测试重命名文件
main() { 
    let entrySize = 4294967296
    let zipParameters = ZipParameters();
    zipParameters.setCompressionMethod(CompressionMethod.STORE);
    zipParameters.setEntrySize(entrySize);
    createZip64FileWithEntries(1, entrySize, zipParameters);
    let zipFile = ZipFile("output.zip")
    zipFile.renameFile("FILE_0", "NEW_FILE_0");
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
            let input = RandomInputStream(eachEntrySize)

            var count = input.read(readBuffer)
            while(count > 0) {
                zipOutputStream.write(readBuffer[0..count]);
                count = input.read(readBuffer)
            }
            zipOutputStream.closeEntry();
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
        if (count <= 0 ) {
            return 0
        } else if (count <= b.size) {
            for(j in 0..count) {
                b[j] = ran.nextUInt8()
            }
            let cc = count
            count = 0
            return cc
        } else {
            for(j in 0..b.size) {
                b[j] = ran.nextUInt8()
            }
            count -= b.size
            return b.size
        }
    }
}