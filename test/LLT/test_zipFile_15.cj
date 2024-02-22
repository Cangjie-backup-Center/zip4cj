
/* RESOURCES: unexpected-eof-when-reading-stream
EXEC: cjc %import-path %L %l %f
EXEC: ./main */

from zip4cj import  zip4cj.*
from std import os.posix.*
from std import fs.*
from std import sync.*
from std import time.*

// zip 多层级 测试用例
main() { 
    let zipParameters = ZipParameters();
    zipParameters.setCompressionMethod(CompressionMethod.STORE)
    let zipFile = ZipFile("ppt1.zip")
    let path = Path("/home/liyanqing/ppt")
    zipFile.addFolder(path, zipParameters)
    let zipFile1 = ZipFile("ppt1.zip")
    zipFile1.extractAll("contrast")   
}

