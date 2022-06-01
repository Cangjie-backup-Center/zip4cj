<p align="center">
<img src="./doc/assets/logo.png" width="60%" >
</p>

<p align="center">
<img alt="" src="https://badg.now.sh/badge/release/v0.0.1?color=green" style="display: inline-block;" />
<img alt="" src="https://badg.now.sh/badge/build/pass?color=green" style="display: inline-block;" />
<img alt="" src="https://badg.now.sh/badge/cjc/v0.29.3?color=green" style="display: inline-block;" />
<img alt="" src="https://badg.now.sh/badge/cjcov/92%25?color=green" style="display: inline-block;" />
<img alt="" src="https://badg.now.sh/badge/project/open?color=green" style="display: inline-block;" />
</p>



## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>介绍

zip4cj 是基于仓颉（0.29.3）语言实现的文件压缩和解压缩，目前基本实现了zip 和 gzip 的压缩和解压缩。

### 特性

- 🚀 zip 压缩和解压缩。

- 🚀 gzip 的压缩和解压缩。

### 未来规划

- 丰富接口

- 实现压缩解密和加密

- 其他有啥想法了再添加^_^

##    <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 架构

### 源码目录

```shell
.
├── LICENSE  
├── README.md
├── doc
│   ├── assets
│   └── cjcov
├── module.json
├── src
│   └── zip4cj
│       ├── gzip
│       │   └── GZUtils.cj
│       ├── utils
│       │   └── FileUtils.cj
│       └── zip
│           ├── CentralDirectoryRecord.cj
│           ├── CompressionMethod.cj
│           ├── EndCDR.cj
│           ├── HeaderParser.cj
│           ├── LocalFileHeader.cj
│           ├── MsDosUtils.cj
│           ├── ZipConstants.cj
│           ├── ZipFile.cj
│           ├── ZipParams.cj
│           └── ZipSignatures.cj
└── test
    ├── HLT
    ├── LLT
    └── UT
```

- `doc` 是库的设计文档、提案、库的使用文档、LLT 覆盖率报告
- `src` 是库源码目录
- `src/zip` 是zip解压缩核心代码
- `src/gzip` 是gzip解压缩核心代码
- `test` 是存放测试用例，包括 HLT 用例、LLT 用例和 UT 用例

### 接口说明

主要是核心类和成员函数说明

#### class GZUtils

##### func compress

实现 GZIP 压缩

```cangjie
/**
 * 实现 GZIP 压缩
 *
 * @param filePath 压缩文件路劲
 * @param level 压缩登等级 （0-9）
 *        LEVEL_NO_COMPRESSION      = 0
 *        LEVEL_BEST_SPEED          = 1
 *        LEVEL_DEFAULT_COMPRESSION = 6
 *        LEVEL_BEST_COMPRESSION    = 9
 * @param outFileName 压缩后的文件名
 *
 * @return 返回压缩后的文件名和数据
 * @since 0.28.4
*/
public static func compress(filePath: String, level: UInt32, outFileName: String): String * Array<UInt8>
```

##### func deCompress

实现 GZIP 解压

```cangjie
/**
 * 实现 GZIP 解压
 *
 * @param filePath 待解压的文件路劲
 *
 * @return 返回解压后的文件名和数据
 * @since 0.28.4
 */
public static func deCompress(filePath: String): String * ArrayList<UInt8>

/**
 * 实现 GZIP 解压
 *
 * @param input 待解压数据
 *
 * @return 返回解压后的文件名和数据
 * @since 0.28.4
 */
public static  func  deCompress(input: Array<UInt8>): String * ArrayList<UInt8> 
```

#### class ZipFile

##### func init

ZipFile 初始化

```cangjie
/**
 * Zip 压缩初始化
 *
 * @since 0.28.4
 */
public init()

/**
 * Zip 解压初始化
 *
 * @param filePath 待解压的文件路径
 *
 * @since 0.28.4
 */
public init(filePath: String)
```

##### func addFile

Zip 添加压缩的文件

```cangjie
/**
 * 添加压缩的文件
 *
 * @param file 添加压缩的文件路径
 *
 * @since 0.28.4
 */
public func addFile(file: String)
```

##### func addFiles

Zip 添加压缩的文件集合

```cangjie
/**
 * 添加压缩的文件集合
 *
 * @param files 问价集合，类型为 HashSet<String>
 *
 * @since 0.28.4
 */
public func addFiles(files: HashSet<String>)
```

##### func writeZip

Zip 压缩

```cangjie
public func writeZip()
```

##### func nameList

获取压缩包中的目录

```cangjie
public func nameList(): Array<String>
```

##### func extractAll

Zip 提取所有解压后的数据

```cangjie
public func extractAll()
```

##### func setOutPath

Zip 设置文件压缩后的路径

```cangjie
/**
 * 设置文件压缩后的路径
 *
 * @param outPath 压缩文件后的路径
 *
 * @since 0.28.4
 */
public func setOutPath(outPath: String)
```

#### class FileUtils

##### func writeFile

FileUtils 根据文件内容和路径写入文件

```cangjie
func writeFile(outData: Array<UInt8>, filePath: String)
```

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/>编译执行

### 项目依赖
`charset`包<br>
下载地址：https://gitee.com/HW-PLLab/charset

### 编译

#### 第一种方式

#### 引入charset包

~~~powershell
git clone https://gitee.com/HW-PLLab/charset.git
~~~

   将charset包放在zip4cj目录下

#### 使用说明

1、在zip4cj目录下module.json中的requires属性中配置charset

~~~json
{
  "cjc_version": "0.29.3",
  "organization": "lzj",
  "name": "zip4cj",
  "description": "zip is a compression/decompression library that can be used for zip, gzip, and other compressed files",
  "version": "0.0.2",
  "requires": {
    "charset":{
      "organization": "zft",
      "version": "1.0.0",
      "path":"charset"
    }
  },
  "package_requires": {},
  "foreign_requires": {},
  "output_type": "dynamic",
  "command_option": ""
}
~~~

2、编译

~~~powershell
cpm build
~~~

3、测试

~~~powershell
cpm test test/UT
unittest/bin/main
~~~



#### 第二种方式

#### 引入 testJekins 包

地址：https://gitee.com/HW-PLLab/testJekins 将 src 下 ci_test 放入 zip4cj 根目录下

#### 使用说明

```
git clone https://gitee.com/HW-PLLab/testJekins
apt-get install python3
python3 ci_test/main.py build
python3 ci_test/main.py test
```

### zip 示例

zip 解压

```cangjie
var zipFile= ZipFile("/mnt/c/Users/lizhenjie/Desktop/MisLinks.zip")
zipFile.setOutPath("/mnt/c/Users/lizhenjie/Desktop/MisLinks")
zipFile.extractAll()
```

zip 添加压缩

```cangjie
var zipFile= ZipFile()
    zipFile.setOutPath("/mnt/c/Users/lizhenjie/Desktop/test.zip")
    zipFile.addFile("/mnt/c/Users/lizhenjie/Desktop/test.txt")
    zipFile.addFile("/mnt/c/Users/lizhenjie/Desktop/aaa.docx")
    zipFile.writeZip()
```

gzip 添加压缩

```cangjie
var gzCompress = GZUtils.compress("/mnt/c/Users/lizhenjie/Desktop/test.txt", LEVEL_DEFAULT_COMPRESSION,
        "test.gz")
var fileName = gzCompress[0]
var compressData = gzCompress[1]
var outPath="/mnt/c/Users/lizhenjie/Desktop/"+fileName
FileUtils.writeFile(compressData, outPath)
```

gzip 解压

```cangjie
var deCompress=GZUtils.deCompress("/mnt/c/Users/lizhenjie/Desktop/test.gz")
var fName=deCompress[0]
var deCompressData=deCompress[1]
var outPath="/mnt/c/Users/lizhenjie/Desktop/"+fName
FileUtils.writeFile(Array(deCompressData), outPath)
```

## 项目中使用zip4cj

### 源码引入

下载charset和zip4cj放入你的项目目录

zip_test(`Your project directory`)
├── charset
├── zip4cj
├── src

├── test

└── module.json

编辑zip_test/zip4cj/module.json，在requires下添加charset包,如：

~~~json
 "requires": {
    "charset":{
      "organization": "zft",
      "version": "1.0.0",
      "path":"../charset"
    }
  },
~~~



编辑zip_test/module.json，在requires下添加zip4cj包,如：

```json
 "requires": {
    "zip4cj":{
      "organization": "zip",
      "version": "0.0.2",
      "path":"zip4cj"
    }
  }
```

使用：

```cangjie
from zip4cj import zip4cj.zip.ZipFile
from zip4cj import zip4cj.zip.ZipParams
```

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/>参与贡献

主要写参与贡献的人以及个人主页链接

[@chinesebear](https://gitee.com/chinesebear)[@ahri_xiao](https://gitee.com/ahri_xiao)