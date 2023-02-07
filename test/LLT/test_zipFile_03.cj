// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.zip.*
from std import os.posix.*

main() { 
    var path2: String = getcwd()
    var zipFile = ZipFile()
    zipFile.setOutPath("${path2}/testZipFile03.zip")
    try {
        zipFile.addFile("${path2}/hello.txt")
    } catch(e: Exception) {
        println(e.toString()) // hello.txt file does not exist
        return 0
    }
    return 1
    
}