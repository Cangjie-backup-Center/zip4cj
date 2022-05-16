import zip4cj.*
main() { 
    var zipFile: ZipFile = ZipFile("")
    zipFile.setOutPath("/home/gtt/cangjie/zip4cj/test/LLT/testZipFile09")
    try {     
        zipFile.extractAll()
        var nameList = zipFile.nameList()
    } catch (e: RuntimeException) {
        println(e.toString()) // file Path is null or invalid
    }
}