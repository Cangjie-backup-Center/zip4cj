// DEPENDENCE: testZipFile12.zip
// DEPENDENCE: test.txt
// EXEC: cjc lib.o %f -o a.out
// EXEC: ./a.out

import zip4cj.*
from std import os.posix.*

main() { 
    var path2: String = getcwd()
var zipFile = ZipFile()
    zipFile.setOutPath("${path2}/testZipFile12.zip")
    zipFile.addFile("${path2}/test.txt")
    var zipParams: ZipParams = ZipParams(9)
    zipFile.setZipParams(zipParams)
    zipFile.writeZip()
}