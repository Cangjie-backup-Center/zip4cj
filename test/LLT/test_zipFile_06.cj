// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.zip.*
from std import os.posix.*
from std import collection.*

main() { 
    var path2: String = getcwd()
    var zipFile = ZipFile()
    zipFile.setOutPath("${path2}/testZipFile06.zip")
    var files: HashSet<String> = HashSet<String>(["${path2}/hello.cj"])
    try {
        zipFile.addFiles(files)
    } catch (e: Exception) {
        println(e.toString()) // hello.txt file does not exist
        return 0
    }
    return 1
}