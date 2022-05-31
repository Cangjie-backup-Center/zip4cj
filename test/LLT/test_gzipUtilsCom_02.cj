// EXEC: cjc lib.o %f -o a.out
// EXEC: ./a.out

import zip4cj.*
from std import os.posix.*

main() {
    var path2: String = getcwd()
    try {
        var gzCompress = GZUtils.compress("${path2}/hello.txt", 6, "hello.gz")
    } catch (e: RuntimeException) {
        println(e.toString()) // file not exist!
        return 0
    }
    return 1
}