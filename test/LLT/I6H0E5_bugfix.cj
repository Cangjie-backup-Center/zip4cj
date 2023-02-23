

// DEPENDENCE: test_01
// DEPENDENCE: test_02.md
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main



from std import unittest.*
from std import unittest.testmacro.*

from zip4cj import zip4cj.zip.*
from zip4cj import zip4cj.utils.*
from std import os.posix.*
from std import collection.*
from std import fs.*
from std import time.*

main() {
    var test = ZIPTest01()
    return test.zip_test_01()
}


public class ZIPTest01 {
    var path: String = getcwd()
    var flag = false

    public func zip_test_01():Int64{  

        println("=====第一步=====")
        var zipFile = ZipFile()
        zipFile.setOutPath("${path}/zip_test_file_30.zip")
        zipFile.addFile("${path}/test_01")
        zipFile.addFile("${path}/test_02.md")
        zipFile.writeZip()

        println("=====第二步=====")
        var srcSize_test_01: Array<Byte> = File.readFrom("${path}/test_01")
        var srcSize_test_02: Array<Byte> = File.readFrom("${path}/test_02.md")

        println("=====第三步=====")
        var zipFileUnpack = ZipFile("${path}/zip_test_file_30.zip")
        zipFileUnpack.setOutPath("${path}/")
        var unpackFiles = zipFileUnpack.extractAll()

        println("=====第四步=====")
        var unzipSize_test_01: Array<Byte> = File.readFrom("${path}/test_01")
       var unzipSize_test_02: Array<Byte> = File.readFrom("${path}/test_02.md")
        
        println("=====第五步=====")
        if (srcSize_test_01.size == unzipSize_test_01.size ) {
            if (srcSize_test_02.size == unzipSize_test_02.size) {
                return 0
            }
        }
        return 1
    }

    
}