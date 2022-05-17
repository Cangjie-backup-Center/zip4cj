import zip4cj.*
main() { 
    var zipFile: ZipFile = ZipFile("/home/gtt/cangjie/zip4cj/test/LLT/testZipFile10.zip")
    zipFile.setOutPath("/home/gtt/cangjie/zip4cj/test/LLT/testZipFile10")
    try {     
        zipFile.extractAll()
        var nameList = zipFile.nameList()
    } catch (e: RuntimeException) {
        println(e.toString()) // file not exist!
    }
}