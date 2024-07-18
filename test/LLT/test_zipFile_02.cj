// RESOURCES: MobaXtermbackup.zip
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import  zip4cj.*
import std.os.posix.*
import std.fs.*
import std.sync.*
import std.time.*

main() { 
    let zipFile = ZipFile("MobaXtermbackup.zip")
    zipFile.setRunInThread(false);
    println(zipFile.isRunInThread())
    println(zipFile.toString())
    Directory.create("output")
    zipFile.extractAll("./output");

    let path = Path("output").join("123").join("123.txt")
    if (FileInfo(path).length != 1) {
        return 1
    }
    if (File.openRead(path).readToEnd() != [97]) {
        return 1
    }

    return 0
}