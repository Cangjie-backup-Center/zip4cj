// DEPENDENCE: testZipFile02.zip
// DEPENDENCE: test.txt
// DEPENDENCE: test.doc
// EXEC: cjc lib.o %f -o a.out
// EXEC: ./a.out

import zip4cj.*
from std import os.posix.*

main() { 
    var path2: String = getcwd()
    var gzCompress = GZUtils.compress("${path2}/test.txt", 6, "testGzipUtilsCom05")
    var fileName = gzCompress[0]
    var compressData = gzCompress[1]
    var outPath = "${path2}/" + fileName
    FileUtils.writeFile(compressData, outPath)
}