// DEPENDENCE: test.txt
// DEPENDENCE: test.doc
// EXEC: cjc lib.o %f -o a.out
// EXEC: ./a.out

import zip4cj.*
from std import os.posix.*
from std import collection.*

main() { 
    var path2: String = getcwd()
    var zipFile = ZipFile()
    zipFile.setOutPath("${path2}/testZipFile04.zip")
    var files: HashSet<String> = HashSet<String>(["${path2}/test.txt", "${path2}/test.doc"])
    zipFile.addFiles(files)
    zipFile.writeZip()
}