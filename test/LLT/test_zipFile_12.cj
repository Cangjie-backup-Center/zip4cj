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
// zip64 重命名
main() { 
    let zipParameters = ZipParameters();
    zipParameters.setCompressionMethod(CompressionMethod.STORE);
    let zipFile = ZipFile("/home/liyanqing/zip64test.zip")

    zipFile.renameFile("NEW_FILE_0", "123123123");
    return 0
}
