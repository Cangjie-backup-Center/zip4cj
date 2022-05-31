// DEPENDENCE: testZipFile02.zip
// EXEC: cjc lib.o %f -o a.out
// EXEC: ./a.out

import zip4cj.*
from std import os.posix.*
main() { 
    var path2: String = getcwd()
    var zipFile: ZipFile = ZipFile("")
    zipFile.setOutPath("${path2}/testZipFile09")
    try {     
        zipFile.extractAll()
        var nameList = zipFile.nameList()
    } catch (e: RuntimeException) {
        println(e.toString()) // file Path is null or invalid
        return 0
    }
    return 1
}