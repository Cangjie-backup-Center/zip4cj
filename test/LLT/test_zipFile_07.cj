import zip4cj.*
from std import collection.*

main() { 
    var zipFile = ZipFile()
    zipFile.setOutPath("/home/gtt/cangjie/zip4cj/test/LLT/testZipFile07.zipp")
    zipFile.addFile("/home/gtt/cangjie/zip4cj/test/LLT/test.txt")
    try {
        zipFile.writeZip()
    } catch(e: RuntimeException) {
        println(e.toString()) // Output file type should be zip!
    }
     
}