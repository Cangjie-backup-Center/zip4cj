/* EXEC: cjc %import-path %L %l %f
EXEC: ./main */

from zip4cj import zip4cj.*
from std import os.posix.*
from std import fs.*
from std import io.*
from std import sync.*
from std import random.*
from std import time.*
// "/home/liyanqing/NEW_FILE_0"
// zip64 重命名
main() { 
    let zipParameters = ZipParameters();
    zipParameters.setCompressionMethod(CompressionMethod.STORE);
    let zipFile = ZipFile("/home/liyanqing/zip64test.zip")

    zipFile.renameFile("NEW_FILE_0", "123123123");
    return 0
}
