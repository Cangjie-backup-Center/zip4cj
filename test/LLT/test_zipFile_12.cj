// DEPENDENCE: testZipFile12.zip
// DEPENDENCE: test.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.zip.*
from std import os.posix.*

main() { 
    var path2: String = getcwd()
    var zipFile = ZipFile()
    zipFile.setOutPath("${path2}/testZipFile12.zip")
    zipFile.addFile("${path2}/test.txt")
    zipFile.writeZip()
}