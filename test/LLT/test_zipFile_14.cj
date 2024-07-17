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
// zip64 测试用例
main() { 
    println(HeaderSignature.EXTRA_DATA_RECORD==(HeaderSignature.EXTRA_DATA_RECORD))
    0
}
