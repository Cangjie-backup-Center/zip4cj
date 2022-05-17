import zip4cj.*

main() { 
    var deCompress = GZUtils.deCompress("/home/gtt/cangjie/zip4cj/test/LLT/testGzipUtilsDecom01.gz")
    var fName = deCompress[0]
    var deCompressData = deCompress[1]
    var outPath = "/home/gtt/cangjie/zip4cj/test/LLT/" + fName
    FileUtils.writeFile(Array(deCompressData), outPath)
}