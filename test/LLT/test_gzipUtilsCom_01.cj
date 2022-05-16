import zip4cj.*

main() { 
    var gzCompress = GZUtils.compress("/home/gtt/cangjie/zip4cj/test/LLT/test.txt", 6, "testGzipUtilsCom01.gz")
    var fileName = gzCompress[0]
    var compressData = gzCompress[1]
    var outPath = "/home/gtt/cangjie/zip4cj/test/LLT/" + fileName
    FileUtils.writeFile(compressData, outPath)
}