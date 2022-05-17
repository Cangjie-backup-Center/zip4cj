import zip4cj.*
main() { 
    var zipFile: ZipFile = ZipFile("/home/gtt/cangjie/zip4cj/test/LLT/testZipFile08.zip")
    zipFile.setOutPath("")
    try {     
        zipFile.extractAll()
        var nameList = zipFile.nameList()
    } catch (e: RuntimeException) {
        println(e.toString()) // out Path is null or invalid
    }
    
}