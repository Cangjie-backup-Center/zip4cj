import zip4cj.*
from std import collection.*

main() { 
    var zipFile = ZipFile()
    zipFile.setOutPath("/home/gtt/cangjie/zip4cj/test/LLT/testZipFile04.zip")
    var files: HashSet<String> = HashSet<String>(["/home/gtt/cangjie/zip4cj/test/LLT/test.txt", "/home/gtt/cangjie/zip4cj/test/LLT/test.doc"]) 
    zipFile.addFiles(files)
    zipFile.writeZip()
}