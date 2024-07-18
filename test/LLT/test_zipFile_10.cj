
// RESOURCES: unexpected-eof-when-reading-stream
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import  zip4cj.*
import std.os.posix.*
import std.fs.*
import std.sync.*
import std.time.*

// zip 流式 测试用例
main() { 
    try {
            let zipParameters = ZipParameters();
        zipParameters.setFileNameInZip("123");
        zipParameters.setCompressionMethod(CompressionMethod.STORE)
        let zipFile = ZipFile("unexpected-eof-when-reading-stream.zip")
        let files = File("unexpected-eof-when-reading-stream", Open(true, true))
        zipFile.createSplitZipFile(files, zipParameters, false, 20)
        return 0
    } catch (e: Exception) {
        return 1
    }
}

