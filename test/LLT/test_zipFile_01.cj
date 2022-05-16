import zip4cj.*

main() { 
    var zipFile = ZipFile()
    zipFile.setOutPath("/home/gtt/cangjie/zip4cj/test/LLT/testZipFile01.zip")
    zipFile.addFile("/home/gtt/cangjie/zip4cj/test/LLT/test.txt")
    zipFile.addFile("/home/gtt/cangjie/zip4cj/test/LLT/test.doc")
    zipFile.writeZip() 
}