// EXEC: cjc lib.o %f -o a.out
// EXEC: ./a.out

import zip4cj.*
from std import os.posix.*

main() { 
    var path2: String = getcwd()
    var zipFile = ZipFile()
    zipFile.setOutPath("${path2}/testZipFile03.zip")
    try {
        zipFile.addFile("${path2}/hello.txt")
    } catch(e: RuntimeException) {
        println(e.toString()) // hello.txt file does not exist
        return 0
    }
    return 1
    
}