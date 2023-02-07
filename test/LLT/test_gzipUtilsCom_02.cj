// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.gzip.*
from zip4cj import zip4cj.utils.*
from std import os.posix.*

main() {
    var path2: String = getcwd()
    try {
        var gzCompress = GZUtils.compress("${path2}/hello.txt", "hello.gz")
    } catch (e: Exception) {
        if(!e.toString().contains("Exception: file not exist!")) {
            return -1
        }
        return 0
    }
    return 1
}