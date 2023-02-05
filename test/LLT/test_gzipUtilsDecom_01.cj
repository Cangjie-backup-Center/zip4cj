// DEPENDENCE: testGzipUtilsDecom01.gz
// EXEC: cjc lib.o %f -o a.out
// EXEC: ./a.out

import zip4cj.*
from std import os.posix.*

main() { 
    var path2: String = getcwd()
    var deCompress = GZUtils.deCompress("${path2}/testGzipUtilsDecom01.gz")
    var fName = deCompress[0]
    var deCompressData = deCompress[1]
    var outPath = "${path2}/" + fName
    FileUtils.writeFile(Array(deCompressData), outPath)
}