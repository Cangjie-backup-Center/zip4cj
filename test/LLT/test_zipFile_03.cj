/* RESOURCES: output.zip
EXEC: cjc %import-path %L %l %f
EXEC: ./main */

import  zip4cj.*
import std.os.posix.*
import std.fs.*
import std.sync.*
import std.time.*

// TODO 使用密码解压用例
main() { 
    let zipFile = ZipFile("output.zip")
    zipFile.setPassword("123".toRuneArray())
    zipFile.setRunInThread(true);
    println(zipFile.isRunInThread())
    println(zipFile.toString())
    Directory.create("output")
    zipFile.extractAll("output");
    return 1
}