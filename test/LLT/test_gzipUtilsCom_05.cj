// DEPENDENCE: test.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.gzip.*
from std import os.posix.*

main() { 
    var path2: String = getcwd()
    var gzCompress = GZUtils.compress("${path2}/test.txt", "testGzipUtilsCom05")
    if(gzCompress < 0) {
        return -1
    }
    return 0
}