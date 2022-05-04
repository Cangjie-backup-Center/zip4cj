# zip4cj
## 介绍
   
zip4cj是仓颉语言实现的文件压缩和解压缩，目前基本实现了zip和gzip的压缩和解压缩。

>zip待解决的问题:<br>
 1、大文件压缩和解压缩，即还未实现zip64
 2、文件加密和解密为实现
 3、zip解压中文文件名称乱码

 ## 使用说明
 ### **zip**
 ### zip解压
    var zipFile= ZipFile("/mnt/c/Users/lizhenjie/Desktop/MisLinks.zip")
    zipFile.setOutPath("/mnt/c/Users/lizhenjie/Desktop/MisLinks")
    zipFile.extractAll()

 ### zip添加压缩

    var zipFile= ZipFile()
    zipFile.setOutPath("/mnt/c/Users/lizhenjie/Desktop/test.zip")
    zipFile.addFile("/mnt/c/Users/lizhenjie/Desktop/test.txt")
    zipFile.addFile("/mnt/c/Users/lizhenjie/Desktop/aaa.docx")
    zipFile.writeZip()
 ### **gzip**
 ### gzip添加压缩

    var gzCompress = GZUtils.compress("/mnt/c/Users/lizhenjie/Desktop/test.txt", LEVEL_DEFAULT_COMPRESSION,
        "test.gz")
    var fileName = gzCompress[0]
    var compressData = gzCompress[1]
    var outPath="/mnt/c/Users/lizhenjie/Desktop/"+fileName
    FileUtils.writeFile(compressData, outPath)

 ### gzip解压缩
    var deCompress=GZUtils.deCompress("/mnt/c/Users/lizhenjie/Desktop/test.gz")
    var fName=deCompress[0]
    var deCompressData=deCompress[1]
    var outPath="/mnt/c/Users/lizhenjie/Desktop/"+fName
    FileUtils.writeFile(Array(deCompressData), outPath)