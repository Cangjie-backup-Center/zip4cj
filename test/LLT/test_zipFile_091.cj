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
    let file = BufferedOutputStream<File>(File("FILE_TEST_SPLIT", OpenOption.Create(true)), 8192)
    let entrySize = 70000
    for ( i in 0..entrySize) {
        file.write(48)
    }
    file.close()
    0
}
