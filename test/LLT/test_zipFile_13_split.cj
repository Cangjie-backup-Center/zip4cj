// RESOURCES: FILE_TEST_SPLIT
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

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
    let zipFile = ZipFile("test.zip")
    zipFile.createSplitZipFile([Path("FILE_TEST_SPLIT")], zipParameters, true, 65536);
    return 0
}
