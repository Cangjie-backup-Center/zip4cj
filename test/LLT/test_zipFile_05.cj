
// RESOURCES: a.txt
// RESOURCES: temp2.zip
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zip4cj import  zip4cj.*
from std import os.posix.*
from std import fs.*
from std import sync.*
from std import time.*

// 删除zip中文件测试用例
main() { 
    let zipParameters = ZipParameters();
    zipParameters.setCompressionMethod(CompressionMethod.STORE);
    let zipFile = ZipFile("temp2.zip")

    // zipFile.addFile("123.txt")
    // zipFile.addFile("a.txt", zipParameters)
    zipFile.removeFile("a.txt");
    return 0
}