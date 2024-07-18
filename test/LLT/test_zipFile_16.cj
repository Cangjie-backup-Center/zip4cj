
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
    zipFile.removeFile("root.txt")
    // Directory.create("contrast/12", recursive: true)
    // zipFile.extractAll("./contrast/12")   
    // let zipFile1 = ZipFile("archive-with-no-dir-entries.zip")
    //Directory.create("contrast/13", recursive: true)
    zipFile.extractAll("./")
}

