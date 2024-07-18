
// RESOURCES: archive-with-no-dir-entries.zip
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import  zip4cj.*
import std.os.posix.*
import std.fs.*
import std.sync.*
import std.time.*

// zip 多层级 测试用例
main() { 
    let zipParameters = ZipParameters()
    zipParameters.setCompressionMethod(CompressionMethod.STORE)
    let zipFile = ZipFile("archive-with-no-dir-entries.zip")
    let arr = zipFile.getFileHeaders()
    if(arr.size != 3) {
        return 1
    }
    return 0
}

