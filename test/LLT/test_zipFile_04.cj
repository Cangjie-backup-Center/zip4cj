// RESOURCES: 123.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import  zip4cj.*
from std import os.posix.*
from std import fs.*
from std import sync.*
from std import time.*

// 创建zip文件测试用例
main() { 
    let zipParameters = ZipParameters();
    zipParameters.setCompressionMethod(CompressionMethod.STORE);
    let zipFile = ZipFile("output.zip")
    zipFile.setRunInThread(false);
    let files = [
        Path("123.txt")
    ]
    println("123123")
    zipFile.createSplitZipFile(files, zipParameters, false, InternalZipConstants.MIN_SPLIT_LENGTH)
        println("end")
    return 0
}