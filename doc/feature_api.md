# zip4cj 库

### 介绍

zip4cj 是基于仓颉语言实现的文件压缩和解压缩，目前基本实现了zip、 gzip、tar.gz 的压缩和解压缩，以及 tar 文件创建和提取。

### 1 zip 格式基础功能支持

前置条件：NA 
场景：
1. 提供 zip 文件的压缩功能
2. 提供 zip 文件的解压缩功能。
3  支持获取 zip 文件的文件目录
4  支持向 zip 文件中添加一个或多个文件 
约束：
性能： 支持版本几何性能持平
可靠性： NA

#### 1.1 zip 压缩功能

提供 ZIP 压缩文件功能

##### 1.1.1 主要接口

```
public class ZipFile { 
    /*
     * Zip 压缩初始化
     */
    public init() {}

    /*
     * Zip 添加压缩的文件
     *
     * 参数 file - 添加压缩的文件路径
     */
    public func addFile(file: String)

    /*
     * Zip 压缩
     */
    public func writeZip()

    /*
     * Zip 设置文件压缩后的路径
     *
     * 参数 outPath - 压缩文件后的路径
     */
    public func setOutPath(outPath: String)
}

/**
 * 该类提供了一些文件操作方法。
 */
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

##### 1.1.2 示例

```
from zip4cj import zip4cj.zip.*
from zip4cj import zip4cj.utils.*
from std import os.posix.*

main() { 
    var path2: String = getcwd()
    var zipFile = ZipFile()
    zipFile.setOutPath(path2 + "/testZipFile01.zip")
    zipFile.addFile("${path2}/test.txt")
    zipFile.writeZip()
}
```

#### 1.2 zip 解压功能

提供 ZIP 压缩文件解压功能

##### 1.2.1 主要接口

```
public class ZipFile {
    /*
     * Zip 初始化
     *
     * 参数 filePath - 待解压的文件路径
     */
    public init(filePath: String)

    /*
     * Zip 提取所有解压后的数据
     *
     * 返回值 ArrayList<LocalFileHeader> 
     */
    public func extractAll(): ArrayList<LocalFileHeader>
}
```

##### 1.2.2 示例

```
from zip4cj import zip4cj.zip.*
from std import os.posix.*
main() { 
    var path2: String = getcwd()
    var zipFile: ZipFile = ZipFile("${path2}/testZipFile02.zip")
    zipFile.setOutPath("${path2}/testZipFile02/")
    zipFile.extractAll()
    return 0
}
```

#### 1.3 zip 添加压缩文件

提供 ZIP 压缩文件功能

##### 1.3.1 主要接口

```
public class ZipFile { 
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
}
```

##### 1.3.2 示例

```
from zip4cj import zip4cj.zip.*
from zip4cj import zip4cj.utils.*
from std import os.posix.*
from std import collection.*

main() { 
    var path2: String = getcwd()
    var zipFile = ZipFile()
    zipFile.setOutPath(path2 + "/testZipFile01.zip")
    var set = HashSet<String>()
    set.put("${path2}/test.txt")
    set.put("${path2}/test.doc")
    zipFile.addFiles(set)
    zipFile.writeZip()
}
```

#### 1.4 zip 获取zip的文件目录

提供获取 zip 内部文件目录的功能

##### 1.4.1 主要接口

```
public class ZipFile { 
    /*
     * 获取压缩包中的目录
     *
     * 返回值 Array<String>
     */
    public func nameList(): Array<String>
}
```

##### 1.4.2 示例

```
from zip4cj import zip4cj.zip.*
from std import os.posix.*
main() { 
    var path2: String = getcwd()
    var zipFile: ZipFile = ZipFile("${path2}/testZipFile02.zip")
    zipFile.setOutPath("${path2}/testZipFile02/")
    zipFile.extractAll()
    var nameList = zipFile.nameList()
    for(name in nameList) {
        println(name.toString())
    }
    return 0
}
```