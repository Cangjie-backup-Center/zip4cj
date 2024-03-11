
// RESOURCES: archive-with-no-dir-entries.zip
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import  zip4cj.*
from std import os.posix.*
from std import fs.*
from std import sync.*
from std import time.*

// zip 多层级 测试用例
main() { 
    let zipParameters = ZipParameters()
    zipParameters.setCompressionMethod(CompressionMethod.STORE)
    let zipFile = ZipFile("archive-with-no-dir-entries.zip")
    let arr = zipFile.getFileHeaders()
    if(arr.size != 3) {
        return 1
    }
    return 0
}

