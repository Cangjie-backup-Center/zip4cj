// DEPENDENCE: testZipFile08.zip
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.zip.*
from std import os.posix.*
main() {
    var path2: String = getcwd()
    var zipFile: ZipFile = ZipFile("${path2}/testZipFile08.zip")
    zipFile.setOutPath("")
    try {     
        zipFile.extractAll()
        var nameList = zipFile.nameList()
    } catch (e: Exception) {
        println(e.toString()) // out Path is null or invalid
        return 0
    }
    return 1
    
}