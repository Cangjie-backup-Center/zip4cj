<div align="center">
<h1>zip4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.53.4-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-92%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>



## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>介绍

zip4cj 是基于仓颉语言实现的文件压缩和解压缩，目前基本实现了zip 的压缩和解压缩。

### 特性

- 🚀 zip 压缩和解压缩。

### 未来规划

- 实现压缩解密和加密

- 支持压缩和解压进度监控

##    <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 架构

### 源码目录

```shell
.
├── LICENSE  
├── README.md
├── doc
│   ├── assets
│   └── cjcov
├── src                             // 源码
│   ├── crypto                  // 加解密功能包
│   │   ├── engine              
│   │   └── PBKDF2
│   ├── exception               // 异常类包
│   ├── headers                 // zip文件头包
│   ├── io                      // zip IO流包
│   │   ├── inputstream
│   │   └── outputstream
│   ├── model                   // zip 配置和参数模式包
│   │   └── enums
│   ├── progress                // 进度监控包
│   ├── tasks                   // 支持多种压缩和解压缩方式包
│   ├── util                    // 工具包
│   └── zip_file.cj             // 主程序入口类
└── test
    ├── HLT
    ├── LLT
    └── UT
```

- `doc` 存放库的设计文档、提案、库的使用文档、LLT 覆盖率报告
- `src` 是库源码目录
- `test` 存放测试用例，包括 HLT 用例、LLT 用例和 UT 用例

### 类和接口说明：

详情见 [API](./doc/feature_api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 使用说明

### 编译

```sh
cjpm update
cjpm build
```

### 功能示例

#### zip 解压

```cangjie
import zip4cj.*                       // 引入zip4cj包 
import std.os.posix.*
import std.fs.*
import std.sync.*
import std.time.*
main() { 
    let zipFile = ZipFile("MobaXtermbackup.zip")  // 创建ZipFile类
    zipFile.setRunInThread(false)                 // 设置是否用子线程运行任务
    zipFile.extractAll("./output")                // 解压到 output 文件夹, 文件夹不存在则创建
    0
}
```

#### zip 创建zip文件

```cangjie
import zip4cj.*                      // 引入zip4cj包 
import std.os.posix.*
import std.fs.*
import std.sync.*
import std.time.*
main() { 
    let zipParameters = ZipParameters()         // 创建 zip 参数配置 类
    zipParameters.setCompressionMethod(CompressionMethod.STORE)  // 设置压缩方式为存储
    let zipFile = ZipFile("output.zip")         // 创建ZipFile类, 并指定文件为 output.zip
    let files = [                               // 创建 文件集合
        Path("123.txt")
    ]
    zipFile.createSplitZipFile(files, zipParameters, false, InternalZipConstants.MIN_SPLIT_LENGTH)                           // 创建文件
    return 0
}
```
#### 压缩文件夹
```cangjie
import zip4cj.*                      // 引入zip4cj包 
import std.os.posix.*
import std.fs.*
import std.sync.*
import std.time.*
main() { 
    let zipParameters = ZipParameters()         // 创建 zip 参数配置 类
    zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)  // 设置压缩方式为DEFLATE压缩
    let zipFile = ZipFile("output.zip")         // 创建ZipFile类, 并指定文件为 output.zip
    zipFile.addFolder("test")                   // 添加文件夹压缩
    return 0
}
```

#### 在zip文件中重命名/删除/添加文件
```cangjie
import zip4cj.*                      // 引入zip4cj包 
import std.os.posix.*
import std.fs.*
import std.sync.*
import std.time.*
main() { 
    let zipParameters = ZipParameters()         // 创建 zip 参数配置 类
    zipParameters.setCompressionMethod(CompressionMethod.DEFLATE)  // 设置压缩方式为DEFLATE压缩
    let zipFile = ZipFile("output.zip")         // 创建ZipFile类, 并指定文件为 output.zip
    zipFile.removeFile("a.txt")                               // 删除文件
    zipFile.renameFile("old_file", "new_file")                // 重命名文件
    zipFile.addFile(Path("a.txt"), parameters: zipParameters) // 添加文件
    var paths=[
        Path("1.mp3")
        Path("12.mp3")
        Path("123.mp3")
        Path("1234.mp3")
    ]
    zipFile.addFiles(paths, parameters: zipParameters)        // 添加文件集合
    return 0
}
```

## 开源协议

本项目基于 [Apache License 2.0](/LICENSE) ，请自由的享受和参与开源。

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/> 参与贡献

欢迎给我们提交 PR，欢迎给我们提交 issue，欢迎参与任何形式的贡献。