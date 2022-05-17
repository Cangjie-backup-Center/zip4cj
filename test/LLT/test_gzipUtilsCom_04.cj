import zip4cj.*

main() { 
    var gzCompress = GZUtils.compress("/home/gtt/cangjie/zip4cj/test/LLT/testDoc/test.doc", 6, "testGzipUtilsCom04.gz")
    var fileName = gzCompress[0]
    var compressData = gzCompress[1]
    var outPath = "/home/gtt/cangjie/zip4cj/test/LLT/testDoc/" + fileName
    FileUtils.writeFile(compressData, outPath)
}