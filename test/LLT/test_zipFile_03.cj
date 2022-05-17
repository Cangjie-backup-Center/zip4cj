import zip4cj.*

main() { 
    var zipFile = ZipFile()
    zipFile.setOutPath("/home/gtt/cangjie/zip4cj/test/LLT/testZipFile03.zip")
    try {
        zipFile.addFile("/home/gtt/cangjie/zip4cj/test/LLT/hello.txt")
    } catch(e: RuntimeException) {
        println(e.toString()) // hello.txt file does not exist
    }
    
}