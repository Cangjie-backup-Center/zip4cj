// DEPENDENCE: testZipFile11.zip
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.zip.*
from std import os.posix.*
main() { 
    var path2: String = getcwd()
    var zipFile: ZipFile = ZipFile("${path2}/testZipFile11.zip")
    zipFile.setOutPath("${path2}/testZipFile11/")
    zipFile.extractAll()
    var nameList = zipFile.nameList()
    for(name in nameList) {
        println(name.toString())
    }
}