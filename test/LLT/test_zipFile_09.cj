// DEPENDENCE: testZipFile02.zip
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from zip4cj import zip4cj.zip.*
from std import os.posix.*

main() {
    var path2: String = getcwd()
    var zipFile: ZipFile = ZipFile("")
    zipFile.setOutPath("${path2}/testZipFile09.zip")
    try {
        zipFile.extractAll()
        zipFile.nameList()
    } catch (e: Exception) {
        println(e.toString()) // file Path is null or invalid
        return 0
    }
    return 1
}
