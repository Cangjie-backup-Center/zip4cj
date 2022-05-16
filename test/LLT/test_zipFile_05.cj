import zip4cj.*
from std import collection.*

main() { 
    var zipFile = ZipFile()
    zipFile.setOutPath("/home/gtt/cangjie/zip4cj/test/LLT/testZipFile05.zip")
    var files: HashSet<String> = HashSet<String>() 
    try {
        zipFile.addFiles(files)
    } catch (e: RuntimeException) {
        println(e.toString()) // The number of added files cannot be empty!
    }
}