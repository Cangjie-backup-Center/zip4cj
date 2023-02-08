// DEPENDENCE: testZipFile02.zip
// DEPENDENCE: test.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.zip.*
from std import os.posix.*
from std import collection.*

main() { 
    var path2: String = getcwd()
    var zipFile = ZipFile()
    zipFile.setOutPath("${path2}/testZipFile07.zipp")
    zipFile.addFile("${path2}/test.txt")
    try {
        zipFile.writeZip()
    } catch(e: Exception) {
        println(e.toString()) // Output file type should be zip!
        return 0
    }
    return 1
     
}