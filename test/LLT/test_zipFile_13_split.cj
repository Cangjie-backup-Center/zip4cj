// RESOURCES: FILE_TEST_SPLIT
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import  zip4cj.*
import std.os.posix.*
import std.fs.*
import std.io.*
import std.sync.*
import std.random.*
import std.time.*
// "/home/liyanqing/NEW_FILE_0"
// zip64 重命名
main() { 
    let zipParameters = ZipParameters();
    zipParameters.setCompressionMethod(CompressionMethod.STORE);
    let zipFile = ZipFile("test.zip")
    zipFile.createSplitZipFile([Path("FILE_TEST_SPLIT")], zipParameters, true, 65536);
    return 0
}
