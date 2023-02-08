<div align="center">
<h1>zip4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.2-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.36.4-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-92%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>



## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>介绍

zip4cj 是基于仓颉语言实现的文件压缩和解压缩，目前基本实现了zip 和 gzip 的压缩和解压缩，以及tar文件提取。

### 特性

- 🚀 zip 压缩和解压缩。

- 🚀 gzip 的压缩和解压缩。

- 🚀 tar 的创建和提取。

- 🚀 tar.gz 的压缩和解压缩。

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
│       ├── tar
│       │   └── TarFile.cj
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
- `src/tar` 是tar提取的核心代码
- `test` 是存放测试用例，包括 HLT 用例、LLT 用例和 UT 用例

### 类和接口说明：

详情见 [API](./doc/api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 使用说明

### 项目依赖
`charset`包<br>
下载地址：https://gitee.com/HW-PLLab/charset

### 编译

#### 第一种方式

##### 引入charset包

~~~powershell
git clone https://gitee.com/HW-PLLab/charset.git
~~~

   将charset包放在zip4cj目录下

##### 使用

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

##### 引入 testJekins 包

地址：https://gitee.com/HW-PLLab/testJekins 将 src 下 ci_test 放入 zip4cj 根目录下

##### 使用

```
git clone https://gitee.com/HW-PLLab/testJekins
apt-get install python3
python3 ci_test/main.py build
python3 ci_test/main.py test
```

### 功能示例

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

tar 解压

```cangjie
var tf = TarFile()
tf.outPath = "/mnt/c/Users/lizhenjie/Desktop/"
var file = FileUtils.readFile("/mnt/c/Users/lizhenjie/Desktop/water_analysis.tar")
tf.extractTar(file)
```

## 项目中使用zip4cj

1、编译

cpm build

2、引入

```json
  "package_requires": {
    "path_option": [
			"./lib/zip4cj"
		],
		"package_option": {}
  },
```
3、使用
```cangjie
from zip4cj import zip4cj.tar.*
from std import fs.*

main() {
    var tf = TarFile()
    tf.outPath = "/mnt/c/Users/lizhenjie/Desktop/test/01/论文.tar"
    tf.storeTar("/mnt/c/Users/lizhenjie/Desktop/test/论文/")
}
```

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/> 参与贡献

欢迎给我们提交 PR，欢迎给我们提交 issue，欢迎参与任何形式的贡献。