import zip4cj.*
main() { 
    var zipFile: ZipFile = ZipFile("/home/gtt/cangjie/zip4cj/test/LLT/testZipFile11.zip")
    zipFile.setOutPath("/home/gtt/cangjie/zip4cj/test/LLT/testZipFile11/")     
    zipFile.extractAll()
    var nameList = zipFile.nameList()
    for(name in nameList) {
        println(name.toString())
    }
}