import zip4cj.*

main() { 
    var gzCompress = GZUtils.compress("/home/gtt/cangjie/zip4cj/test/LLT/test.doc", 6, "testGzipUtilsCom03.gz")
    var fileName = gzCompress[0]
    var compressData = gzCompress[1]
    var outPath = "/home/gtt/cangjie/zip4cj/test/LLT/" + fileName
    FileUtils.writeFile(compressData, outPath)
}