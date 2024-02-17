// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.*
from std import os.posix.*
from std import fs.*
from std import io.*
from std import sync.*
from std import random.*
from std import time.*
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
