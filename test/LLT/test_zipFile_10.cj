
/* EXEC: cjc %import-path %L %l %f
EXEC: ./main
 */
from zip4cj import  zip4cj.*
from std import os.posix.*
from std import fs.*
from std import sync.*
from std import time.*

// zip64 测试用例
main() { 
    let zipFile = ZipFile("/home/liyanqing/zip64test.zip")
    zipFile.renameFile("FILE_0", "NEW_FILE_0");
    // zipFile.renameFile("NEW_FILE_0", "FILE_0");
}