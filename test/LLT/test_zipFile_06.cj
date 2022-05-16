import zip4cj.*
from std import collection.*

main() { 
    var zipFile = ZipFile()
    zipFile.setOutPath("/home/gtt/cangjie/zip4cj/test/LLT/testZipFile06.zip")
    var files: HashSet<String> = HashSet<String>(["/home/gtt/cangjie/zip4cj/test/LLT/hello.cj"]) 
    try {
        zipFile.addFiles(files)
    } catch (e: RuntimeException) {
        println(e.toString()) // hello.txt file does not exist
    }
}