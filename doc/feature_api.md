# zip4cj 库

### 介绍

zip4cj 是基于仓颉语言实现的文件压缩和解压缩，目前基本实现了 zip 的压缩和解压缩。

### 1 zip 格式基础功能支持

前置条件：NA 

场景：
1. 提供 zip 文件的压缩功能
2. 提供 zip 文件的解压缩功能。
3. 支持获取 zip 文件的文件目录
4. 支持向 zip 文件中添加一个或多个文件 

约束：不支持文件夹的操作

性能：支持版本几何性能持平

可靠性：NA

#### 1.1 zip 压缩功能

提供 ZIP 压缩文件功能

##### 1.1.1 主要接口

class ZipFile

```
/**
 * 空参构造函数
 *
 * 返回值 ZipFile对象
 */
public init(): ZipFile

/**
 * 构造函数
 *
 * 参数 filePath - 文件路径
 * 返回值 ZipFile对象
 */
public init(filePath: String): ZipFile

/**
 * 设置输出路径
 *
 * 参数 outPath - 输出路径 压缩操作前设置为压缩结果文件的路径和名称
 *                        解压缩操作前设置为解压结果存放路径
 */
public func setOutPath(outPath: String): Unit

/**
 * 添加文件
 *
 * 参数 file - 文件路径
 * 异常 ZipException - 文件找不到时抛出
 */
public func addFile(file: String): Unit

/**
 * 进行压缩操作
 *
 * 异常 ZipException - 输出路径后缀名不是zip时抛出
 */
public func writeZip(): Unit
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
    zipFile.addFile("${path2}/test.doc")
    zipFile.writeZip()
}
```

#### 1.2 zip 解压功能

提供 ZIP 压缩文件解压功能

##### 1.2.1 主要接口

class ZipFile

```
/**
 * 解压操作
 *
 * 返回值 ArrayList<LocalFileHeader> 本地文件头集合
 * 异常 ZipException - 要解压的文件路径为空/无效时抛出
 *                     解压结果存放路径为空时抛出                    
 */
public func extractAll(): ArrayList<LocalFileHeader>
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
}
```

#### 1.3 zip 添加多个压缩文件

提供添加多个压缩文件的功能

##### 1.3.1 主要接口

class ZipFile

```
/**
 * 添加文件集合
 *
 * 参数 files - 文件路径集合
 * 异常 ZipException - 集合为空时抛出
 *                     任意文件找不到时抛出
 */
public func addFiles(files: HashSet<String>): Unit
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

class ZipFile

```
/**
 * 获取被压缩文件的名称列表
 *
 * 返回值 Array<String> 被压缩文件的名称列表
 * 异常 ZipException - 文件找不到时抛出
 */
public func nameList(): Array<String>
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
}
```

#### 1.5 其他接口
class FileUtils
```
/**
 * 获取文件完整路径
 *
 * 参数 outPath - 文件路径
 * 参数 fileName - 文件名
 * 返回值 String 返回字符串类型的文件路径
 */
public static  func getFilePath(outPath: String, fileName: String): String

/**
 * 获取文件名称
 *
 * 参数 path - 文件路径
 * 返回值 String 文件名称
 */
public static func getFileName(path: String): String

/**
 * 根据文件路径读取文件
 *
 * 参数 path - 文件路径
 * 返回值 Array<UInt8> 文件的内容
 */
public static  func readFile(path: String): Array<UInt8>

/**
 * 将数据写入文件
 *
 * 参数 outData - 文件内容
 * 参数 filePath - 接收写入内容的文件路径
 */
public static  func writeFile(outData: Array<UInt8>, filePath: String)
```
class ZipException
```
/**
 * 构造函数
 *
 * 参数 message - 异常信息
 */
public init(message: String)
```
struct LocalFileHeader
```
/**
 * 本地文件头信息
 *
 * 参数 signature - 签名
 * 参数 versionExtract - 版本
 * 参数 generalPurposeBitFlag - 标志位
 * 参数 compressionMethod - 压缩方法
 * 参数 lastModFileTime - 文件最后修改实际
 * 参数 lastModFileDate - 文件最后修改日期
 * 参数 crc32 - crc32校验
 * 参数 compressedSize - 压缩长度
 * 参数 uncompressedSize - 解压长度
 * 参数 fileNameLength - 文件名称长度
 * 参数 extraFieldLength - 额外字段长度
 * 参数 fileName - 文件名称
 * 参数 inflateData - 文件内容
 * 返回值 LocalFileHeader 对象
 */
public LocalFileHeader(
    signature:Int64,
    versionExtract: Int64,
    generalPurposeBitFlag: Int64,
    compressionMethod: Int64,
    lastModFileTime: Int64,
    lastModFileDate: Int64,
    crc32: Int64,
    compressedSize: Int64,
    uncompressedSize: Int64,
    fileNameLength: Int64,
    extraFieldLength: Int64,
    fileName: String,
    inflateData:Array<UInt8>
)
```
