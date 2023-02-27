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

zip4cj 是基于仓颉语言实现的文件压缩和解压缩，目前基本实现了zip 的压缩和解压缩。

### 特性

- 🚀 zip 压缩和解压缩。

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
│           ├── ZipException.cj
│           ├── ZipFile.cj
│           └── ZipSignatures.cj
└── test
    ├── HLT
    ├── LLT
    └── UT
```

- `doc` 存放库的设计文档、提案、库的使用文档、LLT 覆盖率报告
- `src` 是库源码目录
- `src/zip` 存放zip解压缩核心代码
- `test` 存放测试用例，包括 HLT 用例、LLT 用例和 UT 用例

### 类和接口说明：

详情见 [API](./doc/feature_api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 使用说明

### 项目依赖
`charset`包<br>
下载地址：https://gitee.com/HW-PLLab/charset

### 编译

#### 引入charset包

~~~powershell
git clone https://gitee.com/HW-PLLab/charset.git
~~~

   将charset包放在zip4cj目录下

#### 配置

在zip4cj目录下module.json中的requires属性中配置charset

~~~json
{
  "cjc_version": "0.36.4",
  "organization": "zip4cj",
  "name": "zip4cj",
  "description": "nothing here",
  "version": "0.0.2",
  "requires": {
    "charset":{
      "organization": "pllab",
      "version": "1.0.0",
      "path":"charset"
    }
  },
  "package_requires": {
    "path_option": [],
    "package_option": {}
  },
  "foreign_requires": {},
  "output_type": "dynamic",
  "command_option": "-O2",
  "condition_option": {},
  "link_option": "",
  "cross_compile_configuration": {},
  "package_configuration": {}
}
~~~

#### cpm编译

~~~powershell
cpm build
~~~

### 功能示例

zip 解压

```cangjie
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

zip 添加压缩

```cangjie
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

### 项目中使用zip4cj

##### 引入
在项目的module.json中配置
```json
  ....
  "package_requires": {
    "path_option": [
			"./lib/zip4cj"
		],
		"package_option": {}
  },
  ...
```
##### 编译

cpm build

##### 使用
```cangjie
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

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/> 参与贡献

欢迎给我们提交 PR，欢迎给我们提交 issue，欢迎参与任何形式的贡献。