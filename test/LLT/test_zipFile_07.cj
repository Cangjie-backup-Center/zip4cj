// DEPENDENCE: testZipFile02.zip
// DEPENDENCE: test.txt
// EXEC: cjc lib.o %f -o a.out
// EXEC: ./a.out

import zip4cj.*
from std import os.posix.*
from std import collection.*

main() { 
    var path2: String = getcwd()
    var zipFile = ZipFile()
    zipFile.setOutPath("${path2}/testZipFile07.zipp")
    zipFile.addFile("${path2}/test.txt")
    try {
        zipFile.writeZip()
    } catch(e: RuntimeException) {
        println(e.toString()) // Output file type should be zip!
        return 0
    }
    return 1
     
}