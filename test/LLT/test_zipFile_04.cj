// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import  zip4cj.*
import std.os.posix.*
import std.fs.*
import std.sync.*
import std.time.*

// 创建zip文件测试用例
main() { 
    let zipParameters = ZipParameters();
    zipParameters.setCompressionMethod(CompressionMethod.STORE);
    let zipFile = ZipFile("output.zip")
    zipFile.setRunInThread(false);
    let files = [
        Path("123.txt")
    ]
    println("123123")
    zipFile.createSplitZipFile(files, zipParameters, false, InternalZipConstants.MIN_SPLIT_LENGTH)
    println("end")
    return 0
}