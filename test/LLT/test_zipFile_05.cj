
// RESOURCES: a.txt
// RESOURCES: temp2.zip
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import  zip4cj.*
import std.os.posix.*
import std.fs.*
import std.sync.*
import std.time.*

// 删除zip中文件测试用例
main() { 
    let zipParameters = ZipParameters();
    zipParameters.setCompressionMethod(CompressionMethod.STORE);
    let zipFile = ZipFile("temp2.zip")

    // zipFile.addFile("123.txt")
    // zipFile.addFile("a.txt", zipParameters)
    zipFile.removeFile("a.txt");
    return 0
}