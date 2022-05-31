// DEPENDENCE: test.txt
// DEPENDENCE: test.doc
// EXEC: cjc lib.o %f -o a.out
// EXEC: ./a.out

import zip4cj.*
from std import os.posix.*

main() { 
    var path2: String = getcwd()
    var zipFile = ZipFile()
    zipFile.setOutPath(path2 + "/testZipFile01.zip")
    zipFile.addFile("${path2}/test.txt")
    zipFile.addFile("${path2}/test.doc")
    zipFile.writeZip()
}