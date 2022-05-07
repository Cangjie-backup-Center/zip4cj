# zip4cj
## 介绍
   
zip4cj是基于仓颉（0.28.4）语言实现的文件压缩和解压缩，目前基本实现了zip和gzip的压缩和解压缩。

## 引入charset包
 
 地址：https://gitee.com/HW-PLLab/charset

 ### 使用说明
 > 1、git clone https://gitee.com/HW-PLLab/charset.git<br>
 > 2、cd charset<br>
 > 3、cpm build<br>
 > 4、将build下的charset复制到仓颉环境cangjie/lib/linux_x86_64_llvm下

 ## 未来规划
 > 1、丰富接口<br>
 > 2、实现压缩解密和加密<br>
 > 3、其他有啥想法了再添加^_^
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

## 编译时候指定library-path

    如：cjc -m . --library-path /home/lzj/cangjie/lib/linux_x86_64_llvm/charset -l charsetcharset -l charsetcharset.encoding -l charsetcharset.traditionchinese -l charsetcharset.simplechinese -l charsetcharset.korean -l charsetcharset.singlebyte -l charsetcharset.unicode