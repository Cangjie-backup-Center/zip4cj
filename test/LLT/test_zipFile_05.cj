// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.zip.*
from std import os.posix.*
from std import collection.*

main() { 
    var path2: String = getcwd()
    var zipFile = ZipFile()
    zipFile.setOutPath("${path2}/testZipFile05.zip")
    var files: HashSet<String> = HashSet<String>() 
    try {
        zipFile.addFiles(files)
    } catch (e: Exception) {
        println(e.toString()) // The number of added files cannot be empty!
        return 0
    }
    return 1
}