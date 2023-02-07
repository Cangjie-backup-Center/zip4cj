// DEPENDENCE: test.txt
// DEPENDENCE: test.doc
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import zip4cj.zip.*
from zip4cj import zip4cj.utils.*
from std import os.posix.*

main() { 
    var path2: String = getcwd()
    var zipFile = ZipFile()
    zipFile.setOutPath(path2 + "/testZipFile01.zip")
    zipFile.addFile("${path2}/test.txt")
    zipFile.addFile("${path2}/test.doc")
    zipFile.writeZip()
}