import zip4cj.*

main() { 
    try {
        var gzCompress = GZUtils.compress("/home/gtt/cangjie/zip4cj/test/LLT/hello.txt", 6, "hello.gz")
    } catch (e: RuntimeException) {
        println(e.toString()) // file not exist!
    }
}