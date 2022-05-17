import zip4cj.*

main() { 
    var zipFile = ZipFile()
    zipFile.setOutPath("/home/gtt/cangjie/zip4cj/test/LLT/testZipFile12.zip")
    zipFile.addFile("/home/gtt/cangjie/zip4cj/test/LLT/test.txt")
    var zipParams: ZipParams = ZipParams(9)
    zipFile.setZipParams(zipParams)
    zipFile.writeZip()
}