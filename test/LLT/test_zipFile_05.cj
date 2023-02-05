// EXEC: cjc lib.o %f -o a.out
// EXEC: ./a.out

import zip4cj.*
from std import os.posix.*
from std import collection.*

main() { 
    var path2: String = getcwd()
    var zipFile = ZipFile()
    zipFile.setOutPath("${path2}/testZipFile05.zip")
    var files: HashSet<String> = HashSet<String>() 
    try {
        zipFile.addFiles(files)
    } catch (e: RuntimeException) {
        println(e.toString()) // The number of added files cannot be empty!
        return 0
    }
    return 1
}