// DEPENDENCE: testGzipUtilsDecom01.gz
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.gzip.*
from std import os.posix.*

main() { 
    var path2: String = getcwd()
    var deCompress = GZUtils.decompress("${path2}/testGzipUtilsDecom01.gz", "testGzipUtilsDecom01.txt")
    if(deCompress < 0) {
        return -1
    }
    return 0
}