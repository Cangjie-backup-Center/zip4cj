// DEPENDENCE: test.txt
// DEPENDENCE: test.doc
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.gzip.*
from zip4cj import zip4cj.utils.*
from std import os.posix.*

main() { 
    var path2: String = getcwd()
    var gzCompress = GZUtils.compress("${path2}/test.txt", "testGzipUtilsCom01.gz")
    if(gzCompress < 0) {
        return -1
    }
    return 0
}