## zip4cj 库

### 介绍

zip4cj 是基于仓颉语言实现的文件压缩和解压缩，目前基本实现了zip、 gzip、tar.gz 的压缩和解压缩，以及 tar 文件创建和提取。

### 主要接口

#### class TarFile

此类是 tar 创建和解压。

```cangjie
public class TarFile {
    /*
     * 实现 tar 解压
     *
     * 参数 file - 要解压的 tar 包
     * 返回值 Unit
     */
    public func extractTar(file: Array<UInt8>): Unit

    /*
     * 将目标文件夹里的文件打包成 tar 文件
     *
     * 参数 targetFile - 目标文件
     */
    public func storeTar(targetFile: String)  
}
```

#### class GZUtils

GZIP 压缩和解压。

```cangjie
public class GZUtils { 
    /*
     * 实现 GZIP 压缩
     * 
     * 参数 filePath - 压缩文件路劲
     * 参数 outPath - 压缩后输出的文件位置
     * 返回值 Int64 - 返回压缩状态，小于等于 0 表示失败，大于 0 成功
     */
    public static func compress(filePath: String, outPath: String): Int64

    /*
     * 实现 GZIP 解压
     *
     * 参数 filePath - 需要解压的文件
     * 参数 outPath - 解压后输出的文件位置 
     * 返回值 Int64 - 返回解压缩状态，小于等于 0 表示失败，大于 0 成功
     */ 
    public static func decompress(filePath: String, outPath: String): Int64

```

#### class ZipFile

提供 ZIP 压缩文件功能

```
public class ZipFile { 
    /*
     * Zip 压缩初始化
     */
    public init() {}

    /*
     * Zip 压缩初始化
     *
     * 参数 filePath - 待解压的文件路径
     */
    public init(filePath: String)

    /*
     * Zip 添加压缩的文件
     *
     * 参数 file - 添加压缩的文件路径
     */
    public func addFile(file: String)

    /*
     * Zip 添加压缩的文件集合
     *
     * 参数 files - 文件集合
     */
    public func addFiles(files: HashSet<String>)

    /*
     * Zip 压缩
     */
    public func writeZip()

    /*
     * Zip 提取所有解压后的数据
     *
     * 返回值 ArrayList<LocalFileHeader> 
     */
    public func extractAll(): ArrayList<LocalFileHeader>


    /*
     * 获取压缩包中的目录
     *
     * 返回值 Array<String>
     */
    public func nameList(): Array<String>

    /*
     * Zip 设置文件压缩后的路径
     *
     * 参数 outPath - 压缩文件后的路径
     */
    public func setOutPath(outPath: String)
}
```
#### class FileUtils

该类提供了一些文件操作方法。

```
public open class FileUtils {

    /*
     * 获取文件路径
     *
     * 参数 outPath - 文件路径
     * 参数 fileName - 文件名
     * 返回值 String - 返回字符串类型的文件路径
     */
    public static func getFilePath(outPath: String, fileName: String): String

    /*
     * 获取文件名
     *
     * 参数 path -  文件路径
     * 返回值 String - 文件名
     */
    public static  func getFileName(path: String): String

    /*
     * 根据文件路径读取文件
     *
     * 参数 path - 文件路径
     * 返回值 Array<UInt8> - 文件内容
     */
    public static  func readFile(path: String): Array<UInt8>

    /*
     * 根据文件内容和路径写入文件
     *
     * 参数 outData - 文件内容
     * 参数 filePath - 文件路径
     */
    public static  func writeFile(outData: Array<UInt8>, filePath: String)
}

```

### 示例

#### zip 添加压缩

代码如下：

```cangjie
var zipFile= ZipFile()
zipFile.setOutPath("/mnt/c/Users/lizhenjie/Desktop/test.zip")
zipFile.addFile("/mnt/c/Users/lizhenjie/Desktop/test.txt")
zipFile.addFile("/mnt/c/Users/lizhenjie/Desktop/aaa.docx")
zipFile.writeZip()
```

#### zip 解压

代码如下：

```cangjie
var zipFile= ZipFile("/mnt/c/Users/lizhenjie/Desktop/MisLinks.zip")
zipFile.setOutPath("/mnt/c/Users/lizhenjie/Desktop/MisLinks")
zipFile.extractAll()
```

#### gzip 添加压缩

代码如下：

```cangjie
var gzCompress = GZUtils.compress("/mnt/c/Users/lizhenjie/Desktop/test.txt", LEVEL_DEFAULT_COMPRESSION,
        "test.gz")
var fileName = gzCompress[0]
var compressData = gzCompress[1]
var outPath="/mnt/c/Users/lizhenjie/Desktop/"+fileName
FileUtils.writeFile(compressData, outPath)
```

#### gzip 解压

代码如下：

```cangjie
var deCompress=GZUtils.deCompress("/mnt/c/Users/lizhenjie/Desktop/test.gz")
var fName=deCompress[0]
var deCompressData=deCompress[1]
var outPath="/mnt/c/Users/lizhenjie/Desktop/"+fName
FileUtils.writeFile(Array(deCompressData), outPath)
```

#### tar 解压

代码如下：

```cangjie
var tf = TarFile()
tf.outPath = "/mnt/c/Users/lizhenjie/Desktop/"
var file = FileUtils.readFile("/mnt/c/Users/lizhenjie/Desktop/water_analysis.tar")
tf.extractTar(file)
```