// EXEC: mkdir testDoc
// EXEC: echo 'fjwaekgapewflserogkroegoerkgpre' > ./testDoc/test.doc
// EXEC: cjc lib.o %f -o a.out
// EXEC: ./a.out

import zip4cj.*
from std import os.posix.*
from std import io.*

main() {
    var path2: String = getcwd()
    var gzCompress = GZUtils.compress("${path2}/testDoc/test.doc", 6, "testGzipUtilsCom04.gz")
    var fileName = gzCompress[0]
    var compressData = gzCompress[1]
    var outPath = "${path2}/testDoc/" + fileName
    FileUtils.writeFile(compressData, outPath)
}