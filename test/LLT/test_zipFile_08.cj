
// RESOURCES: output1.zip
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import  zip4cj.*
import std.os.posix.*
import std.fs.*
import std.sync.*
import std.time.*

// 添加文件夹测试用例
main() { 
    before()
    let zipParameters = ZipParameters();
    zipParameters.setCompressionMethod(CompressionMethod.DEFLATE);
    let zipFile = ZipFile("output123.zip")
    zipFile.setRunInThread(true);
    zipFile.addFolder(Path("output"), parameters: zipParameters);
    let path = Path("output").join("123").join("123.txt")
    if (FileInfo(path).length != 1) {
        return 1
    }
    if (File.openRead(path).readToEnd() != [49]) {
        return 1
    }
    return 0
}

func before() {
    let zipFile = ZipFile("output1.zip")
    zipFile.setRunInThread(true);
    // zipFile.setRunInThread(false);
    Directory.create("output")
    zipFile.extractAll(".");
}