/* RESOURCES: output.zip
EXEC: cjc %import-path %L %l %f
EXEC: ./main */

from zip4cj import  zip4cj.*
from std import os.posix.*
from std import fs.*
from std import sync.*
from std import time.*

// TODO 使用密码解压用例
main() { 
    let zipFile = ZipFile("output.zip")
    zipFile.setPassword("123".toRuneArray())
    zipFile.setRunInThread(true);
    println(zipFile.isRunInThread())
    println(zipFile.toString())
    Directory.create("output")
    zipFile.extractAll("output");
    return 1
}