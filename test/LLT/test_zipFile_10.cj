// DEPENDENCE: testZipFile02.zip
// EXEC: cjc lib.o %f -o a.out
// EXEC: ./a.out

import zip4cj.*
from std import os.posix.*
main() { 
    var path2: String = getcwd()
    var zipFile: ZipFile = ZipFile("${path2}/testZipFile10.zip")
    zipFile.setOutPath("${path2}/testZipFile10")
    try {     
        zipFile.extractAll()
        var nameList = zipFile.nameList()
    } catch (e: RuntimeException) {
        println(e.toString()) // file not exist!
        return 0
    }
    return 1
}