# cryptocj 库

## 介绍

cryptocj 是一个安全的密码库，包括常用的密码算法、常用的密钥生成和签名验证。 该库是对 C 语言的 openSSL 封装的仓颉加密算法 地址：https://www.openssl.org/

## 1 提供SHA、MD5、HMAC摘要算法。

前置条件：NA 

场景：
1. OHOS， Linux， windows平台下可解析和生成 YAML 数据，支持 YAML1.1和1.2中对锚点，标签，地图合并的支持

约束：
1. MD5输出16字节
2. SHA1输出20字节
3. SHA224输出28字节
4. SHA256输出32字节
5. SHA384输出48字节
6. SHA512输出64字节
7. HMAC提供MD5和SHA的摘要

性能：支持版本几何性能持平

可靠性：NA

### 1.1 MD5

支持 MD5 多数据和单数据摘要

#### 1.1.1 主要接口

```
// 加密后数据长度
public let MD5_DIGEST_LENGTH: Int64 = 16
```

##### class MD5CTX

MD5 初始化

```cangjie
public class MD5CTX {
    /*
     * 初始化 md5 
     */
    public init()
}
```
#### 1.1.2 全局函数

```cangjie
/*
 * 循环调用此函数,可以将不同的数据加在一起计算 MD5
 * 
 * 参数 c - 初始化 MD5CTX
 * 参数 data - 需要加密的数据
 * 返回值 Unit
 */
public func md5Update(c: MD5CTX, data: String): Unit 

/*
 * 输出 MD5 加密结果数据
 * 
 * 参数 md - 加密后的数据，若转 string 该字符限制为 32 位
 * 参数 c - 初始化 MD5CTX
 * 返回值 Unit
 */
public func md5Final(md: Array<UInt8>, c: MD5CTX): Unit

/*
 * 总的加密算法，可直接使用
 * 
 * 参数 data - 需要加密的数据
 * 参数 md - 加密后的数据，最终结果需要调用 toHexString 转为字符输出，该字符限制为 32 位
 * 返回值 Unit
 */
public func md5(data: Array<UInt8>, md: Array<UInt8>): Unit

/*
 * 总的加密算法，可直接使用
 * 
 * 参数 md - 需要转换的数组
 * 返回值 String - 转换后的32位字符串
 */
public func md5HexToString(md: Array<UInt8>): String
```

#### 1.1.3 示例

##### md5使用

代码如下：

```cangjie
from cryptocj import md5cj.*
from encoding import hex.*

main() {    
    //存储md5的hex结果
    var md: Array<UInt8> = Array<UInt8>(16, item: 0)
    //存储hex对应的字符串结果
    var result: String = String(Array<Char>(33, item: '0'))
    var arr: Array<UInt8> = "helloworld".toUtf8Array()
    var ret = md5(arr, md)
    result = md5HexToString(md)
    if(result != "fc5e038d38a57032085441e7fe7010b0") {
        return -1
    }
    return 0
}
```

运行结果如下：

```cangjie
0
```
##### MD5CTX、md5Update、md5Final 结合使用

代码如下：

```cangjie
from cryptocj import md5cj.*
from std import convert.*
from encoding import hex.*

main() {   
    var ret: Int32 = -1
    var md: Array<UInt8> = Array<UInt8>(MD5_DIGEST_LENGTH, item: 0)
    var buf: String = String(Array<Char>((MD5_DIGEST_LENGTH * 2 + 1), item: '0'))
    var data1: String = "微信运动"
    var data2: String = "helloworld2"
    // 初始化 
    var c = MD5CTX() 
    // 添加数据
    md5Update(c, data1)
    md5Update(c, data2)

    // 计算结果
    md5Final(md, c)
    buf = md5HexToString(md)
    if(buf != "39064f955169198ebe6d1aec5949d45f") {
        return -1
    }
    return 0
}

```

运行结果如下：

```cangjie
0
```

### 1.2 SHA

支持 SHA1、SHA224、SHA256、SHA384、SHA512 多数据和单数据摘要

#### 1.2.1 SHA1

##### 1.2.1.1 主要接口

```
// 加密后数据的长度
public let SHA_DIGEST_LENGTH: Int64 = 20
```

###### class SHACTX

```
/*
 * 初始化 SHACTX 
 */
public init()
```

##### 1.2.1.2 全局函数

```
/*
 * 内部进行加密运算
 * 
 * 参数 c - 初始化 SHACTX
 * 参数 data - 加密的数据
 * 返回值 Unit
 */
public func sha1Update(c: SHACTX, data: String): Unit

/*
 * 输出加密后的数据
 * 
 * 参数 md - 加密后数据
 * 参数 c - 初始化 SHACTX
 * 返回值 Unit
 */
public func sha1Final(md: Array<UInt8>, c: SHACTX): Unit

/*
 * 加密数据
 * 
 * 参数 data - 加密的数据
 * 参数 md - 加密后的数据
 * 返回值 Unit
 */
public func sha1(data: Array<UInt8>, md: Array<UInt8>): Unit
```
##### 1.2.1.3 示例

```
from cryptocj import sha1cj.*
from encoding import hex.*

main() {    
    var md: Array<UInt8> = Array<UInt8>(SHA_DIGEST_LENGTH, item: 0)
    var result: String = String(Array<Char>(SHA_DIGEST_LENGTH * 2 + 1, item: '0'))
    var arr: Array<UInt8> = "helloworld".toUtf8Array()
    sha1(arr, md)
    result = toHexString(md)
    if(result != "6adfb183a4a2c94a2f92dab5ade762a47889a5a1") {
        return -1
    }
    return 0
}


```

运行结果如下：

```cangjie
0
```

#### 1.2.2 SHA224

##### 1.2.2.1 主要接口

```
// 加密后数据的长度
public let SHA224_DIGEST_LENGTH: Int64 = 28
```

###### class SHA224CTX

```
/*
 * 初始化 SHA224CTX 
 */
public init()
```

##### 1.2.2.2 全局函数

```
/*
 * 内部进行加密运算
 * 
 * 参数 c - 初始化 SHA224CTX
 * 参数 data - 加密的数据
 * 返回值 Unit
 */
public func sha224Update(c: SHA224CTX, data: String): Unit

/*
 * 输出加密后的数据
 * 
 * 参数 md - 加密后数据
 * 参数 c - 初始化 SHA224CTX
 * 返回值 Unit
 */
public func sha224Final(md: Array<UInt8>, c: SHA224CTX): Unit

/*
 * 加密数据
 * 
 * 参数 data - 加密的数据
 * 参数 md - 加密后的数据
 * 返回值 Unit
 */
public func sha224(data: Array<UInt8>, md: Array<UInt8>): Unit
```
##### 1.2.2.3 内部接口 

SHA256 和 SHA224 公用，但是该接口对用户不感知

```
public struct SHA256_CTX
```


##### 1.2.2.4 示例

```
from cryptocj import sha224cj.*
from encoding import hex.*

main() {    
    var md: Array<UInt8> = Array<UInt8>(SHA224_DIGEST_LENGTH, item: 0)
    var result: String = String(Array<Char>(SHA224_DIGEST_LENGTH * 2 + 1, item: '0'))
    var arr: Array<UInt8> = "helloworld".toUtf8Array()
    sha224(arr, md)
    result = toHexString(md)
    if(result != "b033d770602994efa135c5248af300d81567ad5b59cec4bccbf15bcc") {
        return -1
    }
    return 0
}


```
运行结果如下：

```cangjie
0
```

#### 1.2.3 SHA256

##### 1.2.3.1 主要接口

```
// 加密后数据的长度
public let SHA256_DIGEST_LENGTH: Int64 = 32
```

###### class SHA256CTX

```
/*
 * 初始化 SHA256CTX 
 */
public init()
```

##### 1.2.3.2 全局函数

```
/*
 * 内部进行加密运算
 * 
 * 参数 c - 初始化 SHA256CTX
 * 参数 data - 加密的数据
 * 返回值 Unit
 */
public func sha256Update(c: SHA256CTX, data: String): Unit

/*
 * 输出加密后的数据
 * 
 * 参数 md - 加密后数据
 * 参数 c - 初始化 SHA256CTX
 * 返回值 Unit
 */
public func sha256Final(md: Array<UInt8>, c: SHA256CTX): Unit

/*
 * 加密数据
 * 
 * 参数 data - 加密的数据
 * 参数 md - 加密后的数据
 * 返回值 Unit
 */
public func sha256(data: Array<UInt8>, md: Array<UInt8>): Unit
```

##### 1.2.3.3 示例

```
from cryptocj import sha256cj.*
from encoding import hex.*

main() {    
    var md: Array<UInt8> = Array<UInt8>(SHA256_DIGEST_LENGTH, item: 0)
    var result: String = String(Array<Char>(SHA256_DIGEST_LENGTH * 2 + 1, item: '0'))  
    var arr: Array<UInt8> = "helloworld".toUtf8Array()
    sha256(arr, md)
    result = toHexString(md)
    if(result != "936a185caaa266bb9cbe981e9e05cb78cd732b0b3280eb944412bb6f8f8f07af") {
        return -1
    }
    return 0
}
```
运行结果如下：

```cangjie
0
```

#### 1.2.4 SHA384

##### 1.2.4.1 主要接口

```
// 加密后数据的长度
public let SHA384_DIGEST_LENGTH: Int64 = 48
```

###### class SHA384CTX

```
/*
 * 初始化 SHA384CTX 
 */
public init()
```

##### 1.2.4.2 全局函数


```
/*
 * 内部进行加密运算
 * 
 * 参数 c - 初始化 SHA384CTX
 * 参数 data - 加密的数据
 * 返回值 Unit
 */
public func sha384Update(c: SHA384CTX, data: String): Unit

/*
 * 输出加密后的数据
 * 
 * 参数 md - 加密后数据
 * 参数 c - 初始化 SHA384CTX
 * 返回值 Unit
 */
public func sha384Final(md: Array<UInt8>, c: SHA384CTX): Unit

/*
 * 加密数据
 * 
 * 参数 data - 加密的数据
 * 参数 md - 加密后的数据
 * 返回值 Unit
 */
public func sha384(data: Array<UInt8>, md: Array<UInt8>): Unit
```
##### 1.2.4.3 内部接口

SHA384 和 SHA512 公用，但是该接口对用户不感知

```
public struct SHA512_CTX
```

##### 1.2.4.4 示例

```
from cryptocj import sha384cj.*
from encoding import hex.*

main() {    
    var md: Array<UInt8> = Array<UInt8>(SHA384_DIGEST_LENGTH, item: 0)
    var result: String = String(Array<Char>(SHA384_DIGEST_LENGTH * 2 + 1, item: '0'))
    var arr: Array<UInt8> = "helloworld".toUtf8Array()
    sha384(arr, md)
    result = toHexString(md)
    if(result != "97982a5b1414b9078103a1c008c4e3526c27b41cdbcf80790560a40f2a9bf2ed4427ab1428789915ed4b3dc07c454bd9") {
        return -1
    }
    return 0
}
```
运行结果如下：

```cangjie
0
```

#### 1.2.5 SHA512

##### 1.2.5.1 主要接口

```
// 加密后数据的长度
public let SHA512_DIGEST_LENGTH: Int64 = 64
```

###### class SHA512CTX

```
/*
 * 初始化 SHA512CTX 
 */
public init()
```

##### 1.2.5.2 全局函数

```
/*
 * 内部进行加密运算
 * 
 * 参数 c - 初始化 SHA512CTX
 * 参数 data - 加密的数据
 * 返回值 Unit
 */
public func sha512Update(c: SHA512CTX, data: String): Unit 

/*
 * 输出加密后的数据
 * 
 * 参数 md - 加密后数据
 * 参数 c - 初始化 SHA512CTX
 * 返回值 Unit
 */
public func sha512Final(md: Array<UInt8>, c: SHA512CTX): Unit

/*
 * 加密数据
 * 
 * 参数 data - 加密的数据
 * 参数 md - 加密后的数据
 * 返回值 Unit
 */
public func sha512(data: Array<UInt8>, md: Array<UInt8>): Unit
```

##### 1.2.5.3 示例

```
from cryptocj import sha512cj.*
from encoding import hex.*

main() {    
    var md: Array<UInt8> = Array<UInt8>(SHA512_DIGEST_LENGTH, item: 0)
    var result: String = String(Array<Char>(SHA512_DIGEST_LENGTH * 2 + 1, item: '0'))
    var arr: Array<UInt8> = "helloworld".toUtf8Array()
    sha512(arr, md)
    result = toHexString(md)
    if(result != "1594244d52f2d8c12b142bb61f47bc2eaf503d6d9ca8480cae9fcf112f66e4967dc5e8fa98285e36db8af1b8ffa8b84cb15e0fbcf836c3deb803c13f37659a60") {
        return -1
    }
    return 0
}
```
运行结果如下：

```cangjie
0
```

### 1.3 HMAC

HMAC 是密钥相关的 哈希运算消息认证码（Hash-based Message Authentication Code），HMAC 运算利用 哈希算法 (SHA1、SHA224、SHA256、SHA384、SHA512、MD5)，以 一个密钥 和 一个消息 为输入，生成一个 消息摘要 作为 输出。

支持多数据和单数据对SHA1、 SHA224 、SHA2567、 SHA384、 SHA512、 MD5的摘要类型进行摘要

#### 1.3.1 主要接口

##### enum AlgorithmType

HMAC 摘要类型

```cangjie
public enum AlgorithmType <: ToString{
    | SHA1		
    | SHA224		
    | SHA256		
    | SHA384		
    | SHA512	
    | MD5

    /*
     * 获取各类型摘要计算后值
     *
     * 返回值 Int32 - 返回各个类型的摘要计算值
     */
    public func getBits(): Int32
}
```
##### class HMACCJ

```
public class HMACCJ {

    /*
     * 初始化 HMACCJ
     */
    public init()

    /*
     * hmac 摘要计算初始化
     * 
     * 参数 key - 密钥
     * 参数 algorithm - 摘要类型
     * 返回值 Unit 
     */
    public func hmacInit(key: Array<UInt8>, algorithm: AlgorithmType): Unit

    /*
     * 进行摘要计算，该函数可运行多次，对多个数据摘要
     * 
     * 参数 data - 需要做 HMAC 运算的数据
     * 返回值 Unit 
     */
    public func hmacUpdate(data: Array<UInt8>): Unit

    /*
     * 进行摘要计算，配合 hmacInit、 hmacUpdate 一起使用
     * 
     * 参数 md - 存放 HMAC 值
     * 返回值 Unit 
     */
    public func hmacFinal(md: Array<UInt8>): Unit

}
```

#### 1.3.2 全局函数

```cangjie
    /*
     * 总的摘要算法
     * 
     * 参数 algorithm - 摘要类型
     * 参数 key - 密钥
     * 参数 data - 需要做 HMAC 运算的数据
     * 参数 md - 存放 HMAC 值
     * 返回值 Unit
     */
    public func hmac(algorithm: AlgorithmType, key: Array<UInt8>, data: Array<UInt8>, md: Array<UInt8>): Unit
```

#### 1.3.3 示例

##### hmac 使用

代码如下：

```cangjie
from cryptocj import hmaccj.*
from encoding import hex.*

main() { 
    var algorithm: AlgorithmType = AlgorithmType.MD5
    var key: Array<UInt8> = "test1280".toUtf8Array()
    var data: Array<UInt8> = "0123456789ABCDEF".toUtf8Array()
    var md: Array<UInt8> = Array<UInt8>(16, item: 0)

    hmac(algorithm, key, data, md)

    if(toHexString(md) != "5539dccd74dffdb0c671cc88c930bc25") {
        return -1
    }
    return 0
}
```

运行结果如下：

```cangjie
0
```
##### HMACCJ 使用

代码如下：

```cangjie
from cryptocj import hmaccj.*
from encoding import hex.*
from std import collection.*

main() { 
    var algorithm: AlgorithmType = AlgorithmType.MD5
    var key: Array<UInt8> = "test1280".toUtf8Array()
    var data: Array<UInt8> = "0123456789ABCDEF".toUtf8Array()
    var resArr: ArrayList<String> = ArrayList<String>()
    let arr: Array<AlgorithmType> = [AlgorithmType.SHA1, AlgorithmType.SHA224, AlgorithmType.SHA256, AlgorithmType.SHA384, AlgorithmType.SHA512, AlgorithmType.MD5]
    for(i in 0..arr.size) {
       var res = hmacFunc(arr[i], key, data, arr[i].getBits()) 
       resArr.append(res)
    }
    
    let ret: Array<String> = ["e665c280cf27dacd1f1b6b053cb307f32ee32fd0", "e72c400c02606686be2a8f7b75dd30234944ba55d7ac60953e848609", "b75ddc670bb8c75296d3207bfa8549df81ba3ef33500593c9d644a03dbcc1e0d", "809f4653a5cc87ac82eaf3b95d7351406034198c13353b6c6cab8878c3ea2f1c607d5593b635e2d9718e95ba900f2939", "44f986af4ca102bfa133e7135994173e120399078e4fdbf2363c4ac975cc3ff67cbe235c7e3667a6120827118dc3ac8e54c949d7f6fdacc704cdf86b1c13a530", "5539dccd74dffdb0c671cc88c930bc25"]
    if(resArr.toArray() != ret) {
        return -1
    }
    return 0
}

func hmacFunc(algorithm: AlgorithmType, key: Array<UInt8>, data: Array<UInt8>, len: Int32): String {
    var md: Array<UInt8> = Array<UInt8>(Int64(len), item: 0)
    let hmac = HMACCJ()
    hmac.hmacInit(key, algorithm)
    hmac.hmacUpdate(data)
    hmac.hmacFinal(md)
    return toHexString(md)
}

```

运行结果如下：

```cangjie
0
```

## 2 提供RC2、 RC4 、AES对称加密算法

前置条件：NA 

场景：
1. 支持对称加密算法。

约束：RC2密钥长度一般16字节，加密块长度8字节；AES加密块长度16字节

性能： 支持版本几何性能持平

可靠性： NA

### 2.1 RC2

RC2 是一种对称加密算法，所见到的安全解决方案中，使用 RC2 的算法不多，从资料上看，RC2 算法可以替代 DES 算法，而且计算速度快，能在 16 位计算机上实现，密钥长度从 1 到 128 字节都可以。一般采用 16 字节，计算的数据块为 8 字节。

支持 ecb、cbc、cfb64、ofb64 加解密

#### 2.1.1 主要接口

**<font color='red'> 注意： </font>**
- RC2 一般采用 16 字节，计算的数据块为 8 字节，不足位补 `\0`，输出缓存区为一个块长 8 字节
- 偏移量每次加解密操作需要重新赋值
- 密钥长度从 1 到 128 字节都可以，一般采用 16 字节。
- 加解密必须设置密钥

```
// 加密标识 1
public let RC2_ENCRYPT: Int32 = 1
// 解密标识 0
public let RC2_DECRYPT: Int32 = 0
// 加密块长
public let RC2_BLOCK: Int32 = 8
// 密钥长度
public let RC2_KEY_LENGTH: Int32 = 16
```

##### class RC2KEY

RC2KEY 类

```cangjie
public class RC2KEY {
    /*
     * 初始化 RC2KEY
     */
    public init()
}
```

#### 2.1.2 全局函数

```cangjie
/*
 * 设置密钥
 * 
 * 参数 key - RC2 的密钥类
 * 参数 data - 密钥数据，不能为空
 * 参数 bits - 密钥数据的位数
 * 返回值 Unit
 */
public func rc2SetKey(key: RC2KEY, data: Array<UInt8>, bits: Int32): Unit 

/*
 * RC2 ecb 加解密计算
 * 
 * 参数 inside - 输入数据，一个块的长度 8
 * 参数 out - 输出缓存区，一个块的长度 8
 * 参数 key - RC2 的密钥类
 * 参数 enc - 加密/解密模式, 加密：RC2_ENCRYPT， 解密：RC2_DECRYPT
 * 返回值 Unit
 */
public func rc2EcbEncrypt(inside: Array<UInt8>, out: Array<UInt8>, key: RC2KEY, enc: Int32): Unit

/*
 * RC2 cbc加密/解密计算；
 * 
 * 参数 inside - 输入数据，一个块的长度 8
 * 参数 out - 输出缓存区，一个块的长度 8
 * 参数 ks - RC2 的密钥类
 * 参数 iv - 初始化向量
 * 参数 enc - 加密/解密模式, 加密：RC2_ENCRYPT， 解密：RC2_DECRYPT
 * 返回值 Unit
 */
public func rc2CbcEncrypt(inside: Array<UInt8>, out: Array<UInt8>, ks: RC2KEY, iv: Array<UInt8>, enc: Int32): Unit

/*
 * RC2的cfb64 加密/解密计算
 * 
 * 参数 inside - 输入数据，一个块的长度 8
 * 参数 out - 输出缓存区，一个块的长度 8
 * 参数 schedule - RC2 的密钥类
 * 参数 ivec - 初始化向量
 * 参数 num - ivec 索引
 * 参数 enc - 加密/解密模式, 加密：RC2_ENCRYPT， 解密：RC2_DECRYPT
 * 返回值 Unit
 */
public func rc2Cfb64Encrypt(inside: Array<UInt8>, out: Array<UInt8>, schedule: RC2KEY, ivec: Array<UInt8>, num: Int32, enc: Int32): Unit

/*
 * RC2的ofb64 加密
 * 
 * 参数 inside - 输入数据，一个块的长度 8
 * 参数 out - 输出缓存区，一个块的长度 8
 * 参数 schedule - RC2 的密钥类
 * 参数 ivec - 初始化向量
 * 返回值 Unit
 */
public func rc2Ofb64Encrypt(inside: Array<UInt8>, out: Array<UInt8>, schedule: RC2KEY, ivec: Array<UInt8>): Unit
```

#### 2.1.3 示例

```
from cryptocj import rc2cj.*
from cryptocj import utils.*
from encoding import base64.*
from encoding import hex.*
from std import collection.*
from std import math.*

main() {    
    var rc2key = RC2KEY()
    var keys: String = "1234567896465451"
    var datas: String = "helloword"
    var res: Array<UInt8> = Array<UInt8>(8, item: 0)
    rc2SetKey(rc2key, keys.toUtf8Array(), 0)

    // 编码
    var inside: Array<UInt8> = datas.toUtf8Array()
    var insides2: ArrayList<Array<UInt8>> = arrayTo2Array(inside, 8)
    var a: ArrayList<UInt8> = ArrayList<UInt8>()
    for(i in 0..insides2.size) { 
        rc2EcbEncrypt(insides2[i], res, rc2key, RC2_ENCRYPT)
        var b = res
        a.appendAll(b)
    }
    var resultE = toHexString(a.toArray())
    if(resultE != "97d61c569253660da654fb13588f9c84") {
        return -1
    }

    // 解码
    var deRes: Array<UInt8> = Array<UInt8>(8, item: 0)
    var deData = fromHexString(resultE).getOrThrow()
    var insides3: ArrayList<Array<UInt8>> = arrayTo2Array(deData, 8)
    var c: ArrayList<UInt8> = ArrayList<UInt8>() 
    for(i in 0..insides3.size) { 
        rc2EcbEncrypt(insides3[i], deRes, rc2key, RC2_DECRYPT)
        var b = deRes
        c.appendAll(b)
    }

    var decryptRes = String.fromUtf8(c.toArray())
    if(!decryptRes.contains(datas)) {
        return -1
    }
    return 0
}

```
运行结果如下：

```cangjie
0
```

### 2.2 RC4 

RC4（Ron Rivest Cipher 4）是一种流加密算法，密钥长度可变。它加解密使用相同的密钥，属于对称加密算法，是使用最广泛的序列密码。RC4 是一种基于非线性数据表变换的序列密码。它以一个足够大的数据表（S盒）为基础，对表进行非线性变换，产生非线性的密钥流序列。它是一个可变密钥长度、面向字节操作的序列密码，该算法以随机置换作为基础。

支持 rc4 加解密

#### 2.2.1 主要接口

##### class RC4KEY

RC4KEY 类

```cangjie
public class RC4KEY {
    /*
     * 初始化 RC4KEY
     */
    public init()
```

#### 2.2.2 全局函数

```cangjie
/*
 * 设置密钥
 * 
 * 参数 key - RC4 的密钥类
 * 参数 data - 密钥数据
 * 返回值 Unit
 */
public func rc4SetKey(key: RC4KEY, data: Array<UInt8>): Unit 

/*
 * RC4 加解密计算
 * 
 * 参数 key - key 值
 * 参数 indata - 加密的数据
 * 参数 outdata - 加解密后的数据
 * 返回值 Unit
 */
public func rc4(key: RC4KEY, indata: Array<UInt8>, outdata: Array<UInt8>): Unit
```

#### 2.1.3 示例

```
from cryptocj import rc4cj.*
from encoding import base64.*
from std import collection.*
from std import math.*

main() {    
    var keys: Array<UInt8> = "1234567891111111".toUtf8Array()
    var indata: Array<UInt8> = "helloword".toUtf8Array()
    var encodeRes = rc4Encode(indata, keys)
    var decodeRes = rc4Decode(encodeRes, keys)
    if(toBase64String(encodeRes) != "Dqd7cGrLT0a7" || String.fromUtf8(decodeRes) != "helloword") {
        return -1
    }
    return 0
}

func rc4Encode(indata: Array<UInt8>, keys: Array<UInt8>): Array<UInt8> {
    var indataLen: Int32 = Int32(indata.size)
    var keysLen: Int32 = Int32(keys.size)
    var outdata: Array<UInt8> = Array<UInt8>(Int64(indataLen) , item: 0)

    if(indataLen == 0 || keysLen == 0) {
        return outdata
    }

    var key = RC4KEY()
    rc4SetKey(key, keys)
    rc4(key, indata, outdata)
    return outdata
}

func rc4Decode(indata: Array<UInt8>, keys: Array<UInt8>): Array<UInt8> {
    var indataLen: Int32 = Int32(indata.size)
    var keysLen: Int32 = Int32(keys.size)
    var outdata: Array<UInt8> = Array<UInt8>(Int64(indataLen) , item: 0)

    if(indataLen == 0 || keysLen == 0) {
        return outdata
    }

    var key = RC4KEY()
    rc4SetKey(key, keys)
    rc4(key, indata, outdata)
    return outdata
}
```
运行结果如下：

```cangjie
0
```


### 2.3 AES

密码学中的高级加密标准（Advanced Encryption Standard，AES），又称 Rijndael加密法，是美国联邦政府采用的一种区块加密标准。这个标准用来替代原先的DES，已经被多方分析且广为全世界所使用。经过五年的甄选流程，高级加密标准由美国国家标准与技术研究院（NIST）于2001年11月26日发布于FIPS PUB 197，并在2002年5月26日成为有效的标准。2006年，高级加密标准已然成为对称密钥加密中最流行的算法之一。

支持 aes、ecb、cbc、cfb128、cfb1、cfb8、ofb128、Ige、bilge、wrap、unwrap 加解密

**<font color='red'> 注意： </font>**
- AES 计算的数据块一般为 16 字节(或16字节的倍数)，不足位补`\0`
- 调用加密函数之前，必须先设置加密key:aesSetEncryptKey
- 调用解密函数之前，必须先设置解密key:aesSetDecryptKey
- 对于 aesCbcEncrypt 加密解密，每次调用前必须先初始化 ivec 向量, ivec 一般为 16 字节
- 密码长度支持 128/192/256 bits

#### 2.3.1 主要接口

```
// 加密标识 1 
public let AES_ENCRYPT: Int32 = 1
// 解密标识 0
public let AES_DECRYPT: Int32 = 0
// 加密块长
public let AES_BLOCK_SIZE: Int32 = 16
```

##### class AESKEY

```
/*
 * 初始化 AESKEY 
 */
public init()
```

#### 2.3.2 全局函数

**<font color='red'> 注意： </font>**
- userKey 长度 16、24、32
- bits 长度 对应为 128、192、256
- 加解密密钥需相同

##### func aesSetEncryptKey

```
/*
 * 设置加密密钥
 * 
 * 参数 userKey - 密钥，必须为 16、24、32
 * 参数 bits - 密钥位数，与 userKey ，对应为 128、192、256
 * 参数 key - AESKEY
 * 返回值 Unit
 */
public func aesSetEncryptKey(userKey: Array<UInt8>, bits: Int32, key: AESKEY): Unit
```

##### func aesSetDecryptKey

```
/*
 * 设置解密密钥（加解密的参数需一致）
 * 
 * 参数 userKey - 密钥，必须为 16、24、32
 * 参数 bits - 密钥位数，与 userKey ，对应为 128、192、256
 * 参数 key - AESKEY
 * 返回值 Unit
 */
public func aesSetDecryptKey(userKey: Array<UInt8>, bits: Int32, key: AESKEY): Unit
```

##### func aesEncrypt

**<font color='red'> 注意： </font>**
- AES 计算的数据块一般为 16 字节(或16字节的倍数)，不足位补`\0`, 输出缓存区为一个数据块长 16 字节

```
/*
 * 加密数据
 * 
 * 参数 inside - 加密数据,一个数据块长 16 字节
 * 参数 outside - 输出缓存区,一个数据块长 16 字节
 * 参数 key - AESKEY
 * 返回值 Unit 
 */
public func aesEncrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY): Unit
```
##### func aesDecrypt

**<font color='red'> 注意： </font>**
- AES 计算的数据块一般为 16 字节(或16字节的倍数)，不足位补`\0`,输出缓存区为一个数据块长 16 字节

```
/*
 * 解密数据
 * 
 * 参数 inside - 解密数据,一个数据块长 16 字节
 * 参数 outside - 输出缓存区,一个数据块长 16 字节
 * 参数 key - AESKEY
 * 返回值 Unit 
 */
public func aesDecrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY): Unit
```

##### func aesEcbEncrypt

**<font color='red'> 注意： </font>**
- AES 计算的数据块一般为 16 字节(或16字节的倍数)，不足位补`\0`,输出缓存区为一个数据块长 16 字节

```
/*
 * 加解密数据
 * 
 * 参数 inside - 输入数据,一个数据块长 16 字节
 * 参数 outside - 输出缓存区,一个数据块长 16 字节
 * 参数 key - AESKEY
 * 参数 enc - 加解密参数，加密： AES_ENCRYPT = 1，解密：AES_DECRYPT = 0
 * 返回值 Unit 
 */
public func aesEcbEncrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, enc: Int32): Unit
```

##### func aesCbcEncrypt

**<font color='red'> 注意： </font>**
- AES 计算的数据块一般为 16 字节(或16字节的倍数)，不足位补`\0`,输出缓存区为一个数据块长 16 字节
- 对于加密解密，每次调用前必须先初始化 ivec 向量, ivec 必须是 16 字节

```
/*
 * 加解密数据
 * 
 * 参数 inside - 输入数据,一个数据块长 16 字节
 * 参数 outside - 输出缓存区,一个数据块长 16 字节
 * 参数 key - AESKEY
 * 参数 ivec - 初始向量
 * 参数 enc - 加解密参数，加密： AES_ENCRYPT = 1，解密：AES_DECRYPT = 0
 * 返回值 Unit 
 */
public func aesCbcEncrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>, enc: Int32): Unit
```
##### func aesCfb128Encrypt

**<font color='red'> 注意： </font>**
- CFB128 模式加密和解密均使用 <b>aesSetEncryptKey</b>，这一点比较反常，务必记住。
- CFB128 模式可一次性加解密。
- 对于加密解密，每次调用前必须先初始化 ivec 向量, ivec 必须是 16 字节

```
/*
 * 加解密数据
 * 
 * 参数 inside - 输入数据，长度任意
 * 参数 outside - 输出数据，长度与输入数据相等
 * 参数 key - AESKEY
 * 参数 ivec - 可读写的一块内存。长度必须是16字节。
 * 参数 enc - 加解密参数，加密： AES_ENCRYPT = 1，解密：AES_DECRYPT = 0
 * 返回值 Unit 
 */
public func aesCfb128Encrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>, enc: Int32): Unit
```

##### func aesCfb1Encrypt

**<font color='red'> 注意： </font>**
- CFB1 模式加密和解密均使用 <b>aesSetEncryptKey</b>，这一点比较反常，务必记住。
- CFB1 模式可一次性加解密。
- 对于加密解密，每次调用前必须先初始化 ivec 向量, ivec 必须是 16 字节

```
/*
 * 加解密数据
 * 
 * 参数 inside - 输入数据，长度任意
 * 参数 outside - 输出数据，长度与输入数据相等
 * 参数 key - AESKEY
 * 参数 ivec - 可读写的一块内存。长度必须是16字节。
 * 参数 enc - 加解密参数，加密： AES_ENCRYPT = 1，解密：AES_DECRYPT = 0
 * 返回值 Unit 
 */
public func aesCfb1Encrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>, enc: Int32): Unit
```

##### func aesCfb8Encrypt

**<font color='red'> 注意： </font>**
- CFB8 模式加密和解密均使用 <b>aesSetEncryptKey</b>，这一点比较反常，务必记住。
- CFB8 模式可一次性加解密。
- 对于加密解密，每次调用前必须先初始化 ivec 向量, ivec 必须是 16 字节

```
/*
 * 加解密数据
 * 
 * 参数 inside - 输入数据，长度任意
 * 参数 outside - 输出数据，长度与输入数据相等
 * 参数 key - AESKEY
 * 参数 ivec - 可读写的一块内存。长度必须是16字节。
 * 参数 enc - 加解密参数，加密： AES_ENCRYPT = 1，解密：AES_DECRYPT = 0
 * 返回值 Unit 
 */
public func aesCfb8Encrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>, enc: Int32): Unit
```

##### func aesOfb128Encrypt

**<font color='red'> 注意： </font>**
- OFB128 模式加密和解密均使用 <b>aesSetEncryptKey</b>，这一点比较反常，务必记住。
- OFB128 模式可一次性加解密。
- 对于加密解密，每次调用前必须先初始化 ivec 向量, ivec 必须是 16 字节。
- aesOfb128Encrypt函数既是加密，又是解密。当 inside 为明文时，执行的是加密操作；当 inside 为密文时，执行的是解密操作。

```
/*
 * 加解密数据
 * 
 * 参数 inside - 输入数据，长度任意
 * 参数 outside - 输出数据，长度与输入数据相等
 * 参数 key - AESKEY
 * 参数 ivec - 可读写的一块内存。长度必须是16字节。
 * 返回值 Unit 
 */
public func aesOfb128Encrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>): Unit
```

##### func aesIgeEncrypt

**<font color='red'> 注意： </font>**
- 可一次性加解密。
- 对于加密解密，每次调用前必须先初始化 ivec 向量, ivec 必须是 32(加密数据块的 2 倍) 字节。
- 输入数据长度必须是 16 的整数倍

```
/*
 * 加解密数据
 * 
 * 参数 inside - 输入数据，长度必须是 16 的整数倍
 * 参数 outside - 输出数据，长度与输入数据相等
 * 参数 key - AESKEY
 * 参数 ivec - 可读写的一块内存。长度必须是 32 字节（加密数据块的 2 倍）。
 * 参数 enc - 加解密参数，加密： AES_ENCRYPT = 1，解密：AES_DECRYPT = 0
 * 返回值 Unit 
 */
public func aesIgeEncrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>, enc: Int32): Unit
```

##### func aesBiIgeEncrypt

**<font color='red'> 注意： </font>**
- 可一次性加解密。
- 对于加密解密，每次调用前必须先初始化 ivec 向量, ivec 必须是 64(加密数据块的 4 倍) 字节。
- 输入数据长度必须是 16 的整数倍

```
/*
 * 加解密数据
 * 
 * 参数 inside - 输入数据，长度必须是 16 的整数倍
 * 参数 outside - 输出数据，长度与输入数据相等
 * 参数 key - AESKEY
 * 参数 ivec - 可读写的一块内存。长度必须是 64 字节（加密数据块的 4 倍）。
 * 参数 enc - 加解密参数，加密： AES_ENCRYPT = 1，解密：AES_DECRYPT = 0
 * 返回值 Unit 
 */
public func aesBiIgeEncrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>, enc: Int32): Unit
```

##### func aesWrapEncrypt

**<font color='red'> 注意： </font>**
- 需设置加密密钥
- ivec 偏移量必须为 8 字节
- 输入数据长度必须是 8 的整数倍，且 大于等于 16 位
- 最小输出缓存区长度 = 输入数据长度 + 8

```
/*
 * 加解密数据
 * 
 * 参数 key - AESKEY
 * 参数 ivec - 长度必须是 8 字节
 * 参数 outside - 输出数据，等于 输入数据长度 + 8
 * 参数 inside - 输入数据，长度必须是 8 的整数倍，且 大于等于 16 位
 * 返回值 Unit 
 */
public func aesWrapEncrypt(key: AESKEY, ivec: Array<UInt8>, outside: Array<UInt8>, inside: Array<UInt8>): Unit
```

##### func aesUnWrapEncrypt

**<font color='red'> 注意： </font>**
- 需设置解密密钥
- ivec 偏移量必须为 8 字节
- 输入数据长度必须是 8 的整数倍，且 大于等于 24 位
- 最小输出缓存区长度 = 输入数据长度 - 8

```
/*
 * 加解密数据
 * 
 * 参数 key - AESKEY
 * 参数 ivec - 长度必须是 8 字节
 * 参数 outside - 输出数据，等于 输入数据长度 + 8
 * 参数 inside - 输入数据，长度必须是 8 的整数倍，且 大于等于 24 位
 * 返回值 Unit 
 */
public func aesUnWrapEncrypt(key: AESKEY, ivec: Array<UInt8>, outside: Array<UInt8>, inside: Array<UInt8>): Unit
```

#### 2.3.3 示例

```
from cryptocj import aescj.*
from cryptocj import utils.*
from encoding import hex.*
from std import collection.*
from std import unicode.*

main() {    
    var keys: Array<UInt8> = "1234567812345678".toUtf8Array()
    var inside: Array<UInt8> = "skfhafahglkahglahglkahgalg".toUtf8Array()
    var encodeRes = aesEncode(inside, keys)
    if(toHexString(encodeRes) != "7da4e06948c190ecf633625517c1e7cbd40afb1fbe2dd55438c8f806c1c549d5") {
        return -1
    }

    var decodeRes = aesDecode(encodeRes, keys)
    if(!String.fromUtf8(decodeRes).contains("skfhafahglkahglahglkahgalg")) {
        return -1
    }
    return 0
}

func aesEncode(inside: Array<UInt8>, keys: Array<UInt8>): Array<UInt8> {
    var key = AESKEY()
    var outside: Array<UInt8> = Array<UInt8>(Int64(AES_BLOCK_SIZE), item: 0)

    var keyRet = aesSetEncryptKey(keys, 128, key)

    var data: ArrayList<Array<UInt8>> = arrayTo2Array(inside, Int64(AES_BLOCK_SIZE))
    var res: ArrayList<UInt8> = ArrayList<UInt8>()
    for( i in 0..data.size ) {
        aesEncrypt(data[i], outside, key)
        res.appendAll(outside)
    }   
    return res.toArray()
}

func aesDecode(inside: Array<UInt8>, keys: Array<UInt8>): Array<UInt8> {
    var key = AESKEY()
    var outside: Array<UInt8> = Array<UInt8>(Int64(AES_BLOCK_SIZE), item: 0)

    var keyRet = aesSetDecryptKey(keys, 128, key)

    var data: ArrayList<Array<UInt8>> = arrayTo2Array(inside, Int64(AES_BLOCK_SIZE))
    var res: ArrayList<UInt8> = ArrayList<UInt8>()
    for( i in 0..data.size ) {
        aesDecrypt(data[i], outside, key)
        res.appendAll(outside)
    }   
    return res.toArray()
}

```
运行结果如下：

```cangjie
0
```

## 3 提供大数相关功能，用于非对称加密算法

前置条件：NA 

场景：
1. 可支持大数基本的运算。

约束：主要用于非对称算法

性能： 支持版本几何性能持平

可靠性： NA

### 3.1 RC2BIGNUM

大数一般指的是位数很多的数。计算机表示的数的大小是有限的，精度也是有限的，它不能支持大数运算。密码学中采用了很多大数计算，主要用于非对称算法。

支持大数初始化函数、计算类函数、随机函数、与字符/位相关的函数、上下文结构的功能

#### 3.1.1 全局函数

##### 初始化函数

```
/*
 * 创建一个空的大数对象。
 *
 * 返回值 CPointer<BIGNUM>
 */
public func bnNew(): CPointer<BIGNUM>

/*
 * 将 a 中所有项均赋值为 0，但是内存并没有释放。
 *
 * 参数 a 
 * 返回值 Unit
 */
public func bnClear(a: CPointer<BIGNUM>): Unit

/*
 * 释放大数对象，每个创建的大数对象都需要释放。
 * 不能对同一个大数进行连续内存释放操作
 * 
 * 参数 a - 大数对象
 * 返回值 Unit
 */
public func bnFree(a: CPointer<BIGNUM>): Unit

/*
 * 相当与将 bnFree 和 bnClear 综合，要不就赋值 0，要不就释放空间。
 * 不能对同一个大数进行连续内存释放操作
 * 
 * 参数 a - 大数
 *
 * 返回值 Unit
 */
public func bnClearFree(a: CPointer<BIGNUM>): Unit
```

##### 计算类函数

```
/*
 * 将整数设置给大数对象。
 * 
 * 参数 a - 大数对象
 * 参数 w - 整数
 * 返回值 Unit
 */
public func bnSetWord(a: CPointer<BIGNUM>, w: UInt64): Unit

/*
 * 从大数中提取整数。
 * 
 * 参数 a - 大数
 * 返回值 UInt64 - 结果
 */
public func bnGetWord(a: CPointer<BIGNUM>): UInt64

/*
 * 比较两个大数
 * 
 * 参数 a - 大数
 * 参数 b - 大数
 * 返回值 Int32 -  a < b return -1 
 *                a == b return 0 
 *                a > b return 1
 */
public func bnCmp(a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Int32

/*
 * 从大数提取 10 进制字符串。
 * 
 * 参数 a - 大数
 * 返回值 String
 */
public func bnBn2dec(a: CPointer<BIGNUM>): String

/*
 * 将 b 复制给 a ,正确返回值 a。
 * 
 * 参数 a - 大数
 * 参数 b - 大数
 * 返回值 CPointer<BIGNUM> - success a , error null
 */
public func bnCopy(a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): CPointer<BIGNUM>

/*
 * 新建一个 BIGNUM 结构，将 a 复制给新建结构返回。
 * 
 * 参数 a - 大数
 * 返回值 CPointer<BIGNUM>
 */
public func bnDup(a: CPointer<BIGNUM>): CPointer<BIGNUM>

/*
 * 交换 a,b。
 * 
 * 参数 a - 大数
 * 参数 b - 大数
 * 返回值 Unit
 */
public func bnSwap(a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Unit

/*
 * 返回值 a 占用的比特数。
 * 
 * 参数 a - 大数
 * 返回值 Int32
 */
public func bnNumBits(a: CPointer<BIGNUM>): Int32

/*
 * 他返回有意义比特的位数，例如 0x00000111 为 9。
 * 
 * 参数 a
 * 返回值 Int32
 */
public func bnNumBitsWord(a: UInt64): Int32

/*
 * 返回一个为 1 的大数。
 *
 * 返回值 CPointer<BIGNUM>
 */
public func bnValueOne(): CPointer<BIGNUM>

/*
 * 判断 a 与 b 的绝对值是否相等。
 * 
 * 参数 a - 大数
 * 参数 b - 大数
 * 返回值 Int32 - |a| < |b| return -1 
 *                 |a| == |b| return 0 
 *                 |a| > |b| return 1
 */
public func bnUcmp(a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Int32

/*
 * 判断 a 是不是为 0。
 * 
 * 参数 a - 大数
 * 返回值 Bool
 */
public func bnIsZero(a: CPointer<BIGNUM>): Bool

/*
 * 判断 a 是不是 1。
 * 
 * 参数 a - 大数
 * 返回值 Bool
 */
public func bnIsOne(a: CPointer<BIGNUM>): Bool

/*
 * 判断 a 是不是值 w。
 * 
 * 参数 a - 大数
 * 参数 w
 * 返回值 Bool
 */
public func bnIsWord(a: CPointer<BIGNUM>, w: UInt64): Bool

/*
 * 对大数执行整数加法操作。
 * 
 * 参数 r  - 和
 * 参数 a - 加数
 * 参数 b - 加数
 * 返回值 Unit
 */
public func bnAdd(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Unit

/*
 * 判断a是不是一个奇数
 * 
 * 参数 a - large numbers
 * 返回值 Bool
 */
public func bnIsOdd(a: CPointer<BIGNUM>): Bool

/*
 * 计算a与b的差，值储存在r中, r = a - b
 * 
 * 参数 r  - difference
 * 参数 a - large numbers
 * 参数 b - large numbers
 * 返回值 Unit
 */
public func bnSub(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Unit

/*
 * 大数 a 加上 w，值储存在 a 中，a = a + w
 * 
 * 参数 a - large numbers
 * 参数 w       
 * 返回值 Unit 
 */
public func bnAddWord(a: CPointer<BIGNUM>, w: UInt64): Unit

/*
 * 大数 a 减去 w，值储存在 a 中，a = a - w
 * 
 * 参数 a - large numbers
 * 参数 w          
 * 返回值 Unit
 */
public func bnSubWord(a: CPointer<BIGNUM>, w: UInt64): Unit

/*
 * 大数 a 乘以 w，值储存在 a 中，a = a * w 
 * 
 * 参数 a: CPointer<BIGNUM> - large numbers
 * 参数 w: UInt64          
 * 返回值 Unit
 */
public func bnMulWord(a: CPointer<BIGNUM>, w: UInt64): Unit

/*
 * 大数 a 除以 w，值储存在 a 中，返回余数 a = a / w
 * 
 * 参数 a - large numbers
 * 参数 w
 * 返回值 Unit
 */
public func bnDivWord(a: CPointer<BIGNUM>, w: UInt64): Unit

/*
 * 大数 a 模 w，返回余数 a = a % w 
 * 
 * 参数 a - large numbers
 * 参数 w          
 * 返回值 Unit
 */
public func bnModWord(a: CPointer<BIGNUM>, w: UInt64): UInt64

/*
 * 计算a与b的积，值储存在r中 r = a * b;
 * 
 * 参数 r  - product
 * 参数 a - bignum
 * 参数 b - bignum
 * 参数 ctx - BN_CTX
 * 返回值 Unit
 */
public func bnMul(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit

/*
 * 计算a的平方，值储存在r中,r = a * a;
 * 
 * 参数 r  - square
 * 参数 a - bignum
 * 参数 ctx - BN_CTX
 * 返回值 Unit
 */
public func bnSqr(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit

/*
 * 计算m与d的商，值储存在dv中，余数储存在rem中, dv = m / d , rem = m % d
 * 
 * 参数 dv - merchant
 * 参数 rem - remainder
 * 参数 m - bignum
 * 参数 d - bignum
 * 参数 ctx - BN_CTX
 * 返回值 Unit
 */
public func bnDiv(dv: CPointer<BIGNUM>, rem: CPointer<BIGNUM>, m: CPointer<BIGNUM>, d: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit

/*
 * 计算a与m的模，并且结果如果小于0，就加上m，值储存在r中, r = ( (a % m) + m) % m
 * 
 * 参数 r  - value
 * 参数 a - bignum
 * 参数 m - bignum
 * 参数 ctx - BN_CTX
 * 返回值 Unit
 */
public func bnNnmod(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit

/*
 * 计算a与b的和，再模m，值储存在r中, r = (a + b) % m
 * 
 * 参数 r  - value
 * 参数 a  - bignum
 * 参数 b - bignum
 * 参数 m - bignum
 * 参数 ctx - BN_CTX
 * 返回值 Unit
 */
public func bnModAdd(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit

/*
 * 计算a与b的差，再模m，值储存在r中, r = (a - b) % m
 * 
 * 参数 r - value
 * 参数 a - bignum
 * 参数 b - bignum
 * 参数 m - bignum
 * 参数 ctx - BN_CTX
 * 返回值 Unit
 */
public func bnModSub(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit

/*
 * 计算a与b的积，再模m，值储存在r中,  r =(a * b) % m
 * 
 * 参数 r - value
 * 参数 a - bignum
 * 参数 b - bignum
 * 参数 m - bignum
 * 参数 ctx - BN_CTX
 * 返回值 Unit
 */
public func bnModMul(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit

/*
 * 计算a的平方，再模m，值储存在r中, r = (a * a) % m
 * 
 * 参数 r - value
 * 参数 a - bignum
 * 参数 m - bignum
 * 参数 ctx - BN_CTX
 * 返回值 Unit
 */
public func bnModSqr(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit

/*
 * 计算a的p次方，值储存在r中, r = a^p
 * 
 * 参数 r - value
 * 参数 a - bignum
 * 参数 p - bignum
 * 参数 ctx - BN_CTX
 * 返回值 Unit
 */
public func bnExp(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, p: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit

/*
 * 计算a的p次方，再模m，值储存在r中, r = (a ^ p) % m
 * 
 * 参数 r - value
 * 参数 a - bignum
 * 参数 p - bignum
 * 参数 m - bignum
 * 参数 ctx - BN_CTX
 * 返回值 Unit
 */
public func bnModExp(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, p: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit

/*
 * 计算a与b的最大公约数，值储存在r中, r = gcd(a,b)
 * 
 * 参数 r - value
 * 参数 a - bignum
 * 参数 b - bignum
 * 参数 ctx - BN_CTX
 * 返回值 Unit
 */
public func bnGcd(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit

```

##### 随机函数

```
/*
 * 生成指定位的强随机大数。
 * 
 * 参数 rnd - 随机大数
 * 参数 bits - 指定位数 ( > 0 )
 * 参数 top - 头部
 *      BN_RAND_TOP_ANY = -1  最高位为0 
 *      BN_RAND_TOP_ONE  = 0  最高位为1 
 *      BN_RAND_TOP_TWO  = 1  最高位和次高位为1
 * 参数 bottom - 尾部
 *      BN_RAND_BOTTOM_ANY = 0 尾部位随机
 *      BN_RAND_BOTTOM_ODD  = 1 尾部位置1，表示奇数
 * 返回值 Unit
 */
public func bnRand(rnd: CPointer<BIGNUM>, bits: Int32, top: Int32, bottom: Int32): Unit

/*
 * 生成0 ~ range范围的大数
 * 
 * 参数 rnd - 生成的随机大数
 * 参数 range - 范围( 0 ~ range)
 * 返回值 Unit
 */
public func bnRandRange(rnd: CPointer<BIGNUM>, range: CPointer<BIGNUM>): Unit

/*
 * 产生一个伪随机数。
 * 
 * 参数 rnd - 随机大数
 * 参数 bits - 指定位数 ( > 0 )
 * 参数 top - 头部
 *      BN_RAND_TOP_ANY = -1  最高位为0 
 *      BN_RAND_TOP_ONE  = 0  最高位为1 
 *      BN_RAND_TOP_TWO  = 1  最高位和次高位为1
 * 参数 bottom - 尾部
 *      BN_RAND_BOTTOM_ANY = 0 尾部位随机
 *      BN_RAND_BOTTOM_ODD  = 1 尾部位置1，表示奇数
 * 返回值 Unit
 */
public func bnPseudoRand(rnd: CPointer<BIGNUM>, bits: Int32, top: Int32, bottom: Int32): Unit

/*
 * 生成0 ~ range范围的大数
 * 
 * 参数 rnd - 生成的随机大数
 * 参数 range - 范围( 0 ~ range)
 * 返回值 Unit
 */
public func bnPseudoRandRange(rnd: CPointer<BIGNUM>, range: CPointer<BIGNUM>): Unit
```

##### 与 字符/位 相关的函数

```
/*
 * 将 |a| 转化为 ASCLL 返回,并返回它的长度
 * 
 * 参数 a - large number
 * 返回值 String - ASCLL
 * 返回值 Int32 - length
 */
public func bnBn2bin(a: CPointer<BIGNUM>): (String, Int32)

/*
 * 将 s 中前 len 位的正整数转化为大数存在 ret
 * 
 * 参数 s
 * 参数 len
 * 参数 ret
 * 返回值 Unit
 */
public func bnBin2bin(s: String, len: Int32, ret: CPointer<BIGNUM>): Unit

/*
 * 将大数转化为十六进制的字符串返回
 * 
 * 参数 a
 * 返回值 String
 */
public func bnBn2hex(a: CPointer<BIGNUM>): String

/*
 * 将十六进制字符串转换为大数
 * 
 * 参数 a
 * 参数 str
 * 返回值 Unit
 */
public func bnHex2bn(a: CPointer<BIGNUM>, str: String): Unit

/*
 * 将十进制字符串转换为大数
 * 
 * 参数 a
 * 参数 str
 * 返回值 Unit
 */
public func bnDec2bn(a: CPointer<BIGNUM>, str: String): Unit

/*
 * 将a中的第n位设置为1，假如a小于n位将扩展
 * 
 * 参数 a
 * 参数 n
 * 返回值 Unit
 */
public func bnSetBit(a: CPointer<BIGNUM>, n: Int32): Unit

/*
 * 将 a 中的第 n 为设置为 0，假如 a 小于 n 位，a 保持不变
 * 
 * 参数 a
 * 参数 n
 * 返回值 Unit
 */
public func bnClearBit(a: CPointer<BIGNUM>, n: Int32): Unit

/*
 * 测试a中的第n位是否已经设置
 * 
 * 参数 a
 * 参数 n
 * 返回值 Bool - true: 设置
 *             false: 未设置
 */
public func bnIsBit(a: CPointer<BIGNUM>, n: Int32): Bool

/*
 * 将a截断至n位，假如a小于n位将出错
 * 
 * 参数 a
 * 参数 n
 * 返回值 Unit
 */
public func bnMaskBit(a: CPointer<BIGNUM>, n: Int32): Unit

/*
 * a左移1位，结果存于r
 * 
 * 参数 r
 * 参数 a
 * 返回值 Unit
 */
public func bnLshift1(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>): Unit

/*
 * a右移1位，结果存于r
 * 
 * 参数 r
 * 参数 a
 * 返回值 Unit
 */
public func bnRshift1(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>): Unit

/*
 * a左移n位，结果存于r
 * 
 * 参数 r
 * 参数 a: CPointer<BIGNUM>
 * 返回值 Unit
 */
public func bnLshift(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, n: Int32): Unit

/*
 * a右移n位，结果存于r
 * 
 * 参数 r
 * 参数 a
 * 返回值 Unit
 */
public func bnRshift(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, n: Int32): Unit
```
##### 上下文结构

```
/*
 * 申请一个新的上下文结构
 *
 * 返回值 CPointer<BN_CTX>
 */
public func bnCtxNew(): CPointer<BN_CTX>

/*
 * 释放上下文结构
 * 
 * 参数 c - CPointer<BN_CTX>
 *
 * 返回值 Unit
 */
public func bnCtxFree(c: CPointer<BN_CTX>): Unit
```

#### 3.1.2 其他接口

与 c 互操作的结构体，使用方式为 CPointer&lt;BN_CTX&gt; CPointer&lt;BIGNUM&gt;

```
public struct BIGNUM
public struct BN_CTX
```

#### 3.1.3 示例

```
from cryptocj import bignumcj.*
from std import collection.*

main() {    
    var pBNa: CPointer<BIGNUM> = bnNew()
    var pBNb: CPointer<BIGNUM> = bnNew()
    var pBNr: CPointer<BIGNUM> = bnNew()
    bnSetWord(pBNa, 1)
    bnSetWord(pBNb, 2)
    bnAdd(pBNr, pBNa, pBNb)
    var res = bnGetWord(pBNr)
    var ret = bnBn2dec(pBNr)
    bnFree(pBNa)
    bnFree(pBNb)
    bnFree(pBNr)
    if(res != 3) {
        return -1
    }
    return 0
}
```
运行结果如下：

```cangjie
0
```

## 4 提供RC2、 RC4 、AES对称加密算法

前置条件：NA 

场景：
1. 支持非对称加密算法。

约束：RSA：RSA_X931_PADDING加密解密填充模型模式无法公钥加密；

性能： 支持版本几何性能持平

可靠性： NA

### 4.1 DSA

DSA使用公开密钥，为接受者验证数据的完整性，也可用于由第三方去确定签名和所签数据的真实性。

支持 dsa 签名验证

#### 4.1.1 主要接口

##### enum DsaTypeId

DSA 签名验证类型

```cangjie
public enum AlgorithmType <: ToString{
    | NID_md5
    | NID_sha1
    | NID_sha256
    | NID_sha384
    | NID_sha512
    | NID_md5_sha1
    | NULL

    /*
     * 获取各类型值
     *
     * 返回值 Int32 - 返回各个类型的值
     */
    public func getNum(): Int32
}
```
##### class DSASIG

签名结构

```
public class DSASIG {

    /*
     * 初始化 DSASIG
     */
    public init()

    /*
     * 初始化 DSASIG
     * 
     * 参数 r - DSASIG 值
     */
    public init(r: UInt64)

    /*
     * 获取 DSASIG 值
     *
     * 返回值 UInt64 
     */
    public func getDsaSign(): UInt64
}
```

##### class DSA

DSA 数据结构

```
public class DSA {

    /*
     * 初始化 DSA
     */
    public init()

    /*
     * 初始化 DSA
     * 
     * 参数 d - DSA 值
     */
    public init(d: UInt64)

    /*
     * 获取 DSA 值
     *
     * 返回值 UInt64 
     */
    public func getDsa(): UInt64
}
```

##### class SINCALLOC

给签名值分配地址

```
public class SINCALLOC {

    /*
     * 初始化 SINCALLOC
     */
    public init(dsa: DSA)
}
```

##### class SINSTR

签名后的值

```
public class SINSTR {

    /*
     * 初始化 SINSTR
     */
    public init(s: Array<UInt8>, l: Int32)

}
```

#### 4.1.2 全局函数

```cangjie
/*
 * 生成一个DSA数据结构
 *
 * 返回值 DSA
 */
public func dsaNew(): DSA

/*
 * 释放DSA数据结构
 * 
 * 参数 dsa - DSA
 * 返回值 Unit
 */
public func dsaFree(dsa: DSA): Unit

/*
 * 生成密钥参数。
 * 
 * 参数 dsa - DSA
 * 参数 bits - bits 位于 512 到 1024 之间，且为 64 的倍数
 * 返回值 Unit
 */
public func dsaGenerateParameters(dsa: DSA, bits: Int32): Unit

/*
 * 根据密钥参数生成公私钥
 * 
 * 参数 dsa - DSA
 * 返回值 Unit
 */
public func dsaGenerateKey(dsa: DSA): Unit

/*
 * DSA 签名
 * 
 * 参数 types - dsa 签名类型
 * 参数 dgst - 签名数据
 * 参数 sig - 签名值缓存区
 * 参数 dsa - DSA
 * 返回值 Array<UInt8> - 签名后实际值，用于验证参数
 *        UInt32 - 签名后长度，用于验证参数
 */
public func dsaSign(types: DsaTypeId, dgst: Array<UInt8>, sig: Array<UInt8>, dsa: DSA): (Array<UInt8>, UInt32)

/*
 * DSA 验证
 * 
 * 参数 types - dsa验证类型，同签名类型一致
 * 参数 dgst - 签名数据
 * 参数 sigbuf - 签名后值（dsaSign 返回值）
 * 参数 siglen - 签名值长度（dsaSign 返回值）
 * 参数 dsa - DSA
 * 返回值 Int32 - 1 验证成功
 *             -  其他失败
 */
public func dsaVerify(types: DsaTypeId, dgst: Array<UInt8>, sigbuf: Array<UInt8>, siglen: Int32, dsa: DSA): Int32

/*
 * 获取DSA密钥长度的字节数
 * 
 * 参数 dsa - DSA
 * 返回值 Int32
 */
public func dsaSize(dsa: DSA): Int32

/*
 * 将 DSA 密钥及相关参数输出
 * 
 * 参数 dsa - DSA
 * 返回值 Int32 - 成功 1，失败 0
 */
public func dsaPrint(dsa: DSA): Int32

/*
 * 生成 DSA 公钥 pem 文件
 * 
 * 参数 pub_key_fn - 文件路径
 * 参数 dsa - DSA
 * 参数 isPrint - 是否打印密钥信息
 * 返回值 Unit
 */
public func pemWriteDsaPub(pub_key_fn: String, dsa: DSA, isPrint: Bool): Unit

/*
 * 生成 DSA 私钥 pem 文件
 * 
 * 参数 pub_key_fn - 文件路径
 * 参数 dsa - DSA
 * 参数 isPrint - 是否打印密钥信息
 * 返回值 Unit
 */
public func pemWriteDsaPri(pub_key_fn: String, dsa: DSA, isPrint: Bool): Unit

/*
 * 生成 DSA 密钥参数 pem 文件
 * 
 * 参数 pub_key_fn - 文件路径
 * 参数 dsa - DSA
 * 参数 isPrint - 是否打印密钥信息
 * 返回值 Unit
 */
public func pemWriteDsaPara(pub_key_fn: String, dsa: DSA, isPrint: Bool): Unit

/*
 * 从私钥文件读取 DSA 私钥
 * 
 * 参数 pri_key_fn - 文件路径
 * 参数 isPrint - 是否打印密钥信息
 * 返回值 DSA
 */
public func pemReadDsaPri(pri_key_fn: String, isPrint: Bool): DSA

/*
 * 从公钥文件读取 DSA 公钥
 * 
 * 参数 pub_key_fn - 文件路径
 * 参数 isPrint - 是否打印密钥信息
 * 返回值 DSA
 */
public func pemReadDsaPub(pub_key_fn: String, isPrint: Bool): DSA

/*
 * DSA 数字签名
 * 
 * 参数 dgst - 签名数据
 * 参数 pri_key_fn - 文件路径
 * 参数 isPrint - 是否打印密钥信息
 * 返回值 DSA
 */
public func dsaDoSign(dgst: Array<UInt8>, pri_key_fn: String, isPrint: Bool): DSASIG

/*
 * DSA 数字签名验证
 * 
 * 参数 dgst - 签名数据
 * 参数 sig - 签名结构（取自 dsaDoSign 返回值）
 * 参数 pub_key_fn - 文件路径
 * 参数 isPrint - 是否打印密钥信息
 * 返回值 DSA - 1 验证成功，其他失败
 */
public func dsaDoVerify(dgst: Array<UInt8>, sig: DSASIG, pub_key_fn: String, isPrint: Bool): Int32
```

#### 4.1.3 示例

代码如下：

```cangjie
from cryptocj import dsacj.*
from cryptocj import structcj.*
from encoding import hex.*
from std import collection.*
from std import os.posix.*

main() {  
    var path: String = getcwd()
    var ret: Int32 = 0
    var input_string: Array<UInt8> = [49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,48,78,89,90]
    let dsa = dsaNew()
    dsaGenerateParameters(dsa, 1024)
    dsaGenerateKey(dsa)
    pemWriteDsaPara("${path}/dsaParams.pem", dsa, false)
    pemWriteDsaPri("${path}/dsaPri.pem", dsa, true)
    pemWriteDsaPub("${path}/dsaPub.pem", dsa, false)
    var len = dsaSize(dsa)

    var sign_string: Array<UInt8> = Array<UInt8>(Int64(len), item: 0)
    var sig_len: UInt32 = 0
    var (data, dataSize) = dsaSign(DsaTypeId.NID_sha1, input_string, sign_string, dsa)
    ret = dsaVerify(DsaTypeId.NID_sha1, input_string, data, Int32(dataSize), dsa)
    dsaFree(dsa)
    if(ret != 1) {
        return -1
    }
    return 0 
}

```

运行结果如下：

```cangjie
0
```

### 4.2 DH

DH算法是W.Diffie和M.Hellman提出的。此算法是最早的公钥算法。它实质是一个通信双方进行密钥协商的协议：两个实体中的任何一个使用自己的私钥和另一实体的公钥，得到一个对称密钥，这一对称密钥其它实体都计算不出来。DH算法的安全性基于有限域上计算离散对数的困难性。离散对数的研究现状表明：所使用的DH密钥至少需要1024位，才能保证有足够的中、长期安全。

支持 dh 共享密钥生成功能

#### 4.2.1 主要接口

##### enum DHGENERATOR

密钥参数生成安全素数的生成器，通常选择 2 或 5.

```cangjie
public enum AlgorithmType <: ToString{
    | DH_GENERATOR_2		
    | DH_GENERATOR_3		
    | DH_GENERATOR_5		

    /*
     * 获取生成器的值
     * 返回值 Int32 
     */
    public func getNum(): Int32
}
```
##### class SHAREMALLOC

给共享密钥分配内存

```
public class SHAREMALLOC {
    /*
     * 初始化 SHAREMALLOC
     */
    public init(dh: DH)

    /*
     * 获得共享密钥内存
     *
     * 返回值 UInt64 
     */
    public func getShareMalloc(): CString

}
```
##### class DH

DH 结构

```
public class DH {

    /*
     * 初始化
     */
    public init()

    /*
     * 初始化
     *
     * 参数 d 
     */
    public init(d: UInt64)

    /*
     * 获取 DH 值
     *
     * 返回值 UInt64 
     */
    public func getDh(): UInt64
}
```

#### 4.2.2 全局函数

```
/*
 * 生成 DH 数据结构
 *
 * 返回值 DH 
 */
public func dhNew(): DH

/*
 * 获取 DH 密钥长度的字节数。
 *
 * 参数 dh 
 * 返回值 Int32 - 字节数
 */
public func dhSize(dh: DH): Int32 

/*
 * 生成 DH 密钥参数。
 * 生成的密钥长度为 安全素数长度/8, 小数部分直接进位，如 513 计算的密钥长度为 65
 *
 * 参数 dh 
 * 参数 prime_len - 生成的安全素数的长度,512-10000 间的任意整数
 * 参数 generator - 生成器
 * 返回值 Unit
 */
public func dhGenerateParameters(dh: DH, prime_len: Int32, generator: DHGENERATOR): Unit 

/*
 * 检查 DH 密钥。
 *
 * 参数 dh
 * 返回值 Unit
 */
public func dhCheck(dh: DH): Unit

/*
 * 生成 DH 公私钥。
 *
 * 参数 dh
 * 返回值 Unit
 */
public func dhGenerateKey(dh: DH): Unit

/*
 * 检查公钥。
 *
 * 参数 dh
 * 参数 pub_key
 * 返回值 Unit
 */
public func dhCheckPubKey(dh: DH, pub_key: CPointer<BIGNUM>): Unit 

/*
 * 计算共享密钥，用于数据交换。去除前导零字节。
 *
 * 参数 key - SHAREMALLOC 类型
 * 参数 pub_key - 共享公钥
 * 参数 dh
 * 返回值 Int32 - 生成共享密钥长度，可用于测试生成共享密钥是否成功
 * 返回值 Array<UInt8> - 生成的共享密钥，可用于测试生成共享密钥是否成功
 */
public func dhComputeKey(key: Array<UInt8>, pub_key: CPointer<BIGNUM>, dh: DH): (Int32, Array<UInt8>)

/*
 * 计算共享密钥，用于数据交换。保留前导零字节。
 *
 * 参数 key - SHAREMALLOC 类型
 * 参数 pub_key - 共享公钥
 * 参数 dh
 * 返回值 Int32 - 生成共享密钥长度，可用于测试生成共享密钥是否成功
 * 返回值 Array<UInt8> - 生成的共享密钥，可用于测试生成共享密钥是否成功
 */
public func dhComputePaddeKey(key: Array<UInt8>, pub_key: CPointer<BIGNUM>, dh: UInt64): (Int32, Array<UInt8>)

/*
 * 打印 DH 密钥参数。
 *
 * 参数 dh
 * 返回值 Unit
 */
public func dhParamsPrint(x: DH): Unit

/*
 * 获取 DH 密钥参数素数。
 *
 * 参数 dh
 * 返回值 CPointer<BIGNUM>
 */
public func dhGetP(dh: DH): CPointer<BIGNUM>

/*
 * 获取 DH 密钥参数素数。
 *
 * 参数 dh
 * 返回值 CPointer<BIGNUM>
 */
public func dhGetQ(dh: DH): CPointer<BIGNUM>

/*
 * 获取 DH 密钥参数生成器。
 *
 * 参数 dh
 * 返回值 CPointer<BIGNUM>
 */
public func dhGetG(dh: DH): CPointer<BIGNUM>

/*
 * 获取 DH 私钥。
 *
 * 参数 dh
 * 返回值 CPointer<BIGNUM>
 */
public func dhGetPrivKey(dh: DH): CPointer<BIGNUM>

/*
 * 获取 DH 公钥。
 *
 * 参数 dh
 * 返回值 CPointer<BIGNUM>
 */
public func dhGetPubKey(dh: DH): CPointer<BIGNUM>

/*
 * 设置 DH 密钥参数。
 *
 * 参数 dh
 * 参数 p - 密钥参数素数
 * 参数 q - 密钥参数素数
 * 参数 g - 密钥参数生成器
 * 返回值 CPointer<BIGNUM>
 */
public func dnSetPQG(dh: DH, p: CPointer<BIGNUM>, q: CPointer<BIGNUM>, g: CPointer<BIGNUM>): Unit

/*
 * 设置 DH 公私钥。
 *
 * 参数 dh
 * 参数 pubKey - 公钥
 * 参数 privKey - 私钥
 * 返回值 CPointer<BIGNUM>
 */
public func dhSetKey(dh: DH, pubKey: CPointer<BIGNUM>, privKey: CPointer<BIGNUM>): Unit

/*
 * 将密钥参数输出到 pem 文件。
 *
 * 参数 params_fn - 文件路径
 * 参数 x - dh
 * 返回值 CPointer<BIGNUM>
 */
public func pemWriteDHparams(params_fn: String, x: DH): Unit 

/*
 * 从文件读取密钥参数。
 *
 * 参数 params_fn - 文件路径
 * 返回值 DH
 */
public func pemReadDHparams(params_fn: String): DH 
```

#### 4.2.3 示例

代码如下：

```cangjie
from cryptocj import dhcj.*
from cryptocj import bignumcj.*
from encoding import base64.*
main() {  
    let d1: DH = dhNew()
    let d2: DH = dhNew()
    var ret: Int32 = 0
    var size1: Int32 = 0
    var size2: Int32 = 0
    var p: CPointer<BIGNUM> = CPointer<BIGNUM>()
    var g: CPointer<BIGNUM> = CPointer<BIGNUM>()
    var q: CPointer<BIGNUM> = CPointer<BIGNUM>()
    var d1Pub: CPointer<BIGNUM> = CPointer<BIGNUM>()
    var d2Pub: CPointer<BIGNUM> = CPointer<BIGNUM>()
    /* 生成d1 的密钥参数*/
    dhGenerateParameters(d1, 512, DHGENERATOR.DH_GENERATOR_2)
    /* 检查密钥参数 */
    dhCheck(d1)
    /* d1 生成公私钥 */
    dhGenerateKey(d1)
    /* p和g为公开的密钥参数,因此可以拷贝 */
    p = dhGetP(d1)
    g = dhGetG(d1)
    d1Pub = dhGetPubKey(d1)
    /* d1 检查公钥 */
    dhCheckPubKey(d1, d1Pub)
    dnSetPQG(d2, p, q, g)
    /* d2 生成公私钥,用于测试生成共享密钥 */
    dhGenerateKey(d2)
    d2Pub = dhGetPubKey(d2)
    /* 密钥大小 */
    size1 = dhSize(d1)
    size2 = dhSize(d2)
    /* 计算共享密钥 */
    var sharekey1: SHAREMALLOC = SHAREMALLOC(d1)
    var sharekey2: SHAREMALLOC = SHAREMALLOC(d2)
    var (len1, sharekey11) = dhComputeKey(sharekey1, d2Pub, d1)
    var (len2, sharekey22) = dhComputeKey(sharekey2, d1Pub, d2)
    dhParamsPrint(d1)

    var (len3, sharekey33) = dhComputePaddeKey(sharekey1, d2Pub, d1)
    var (len4, sharekey44) = dhComputePaddeKey(sharekey2, d1Pub, d2)

    if(len1 != len2 || sharekey11 != sharekey22) {
       return -1
    }
    return 0 
}
```

运行结果如下：

```cangjie
0
```

### 4.3 RC2RSA

RSA算法是一个广泛使用的公钥算法。其密钥包括公钥和私钥。它能用于数字签名、身份认证以及密钥交换。RSA密钥长度一般使用1024位或者更高。

支持 rsa 加解密和签名验证功能

#### 4.3.1 主要接口

##### enum PADDING

RSA 加密解密填充模型
注意：RSA_X931_PADDING 模式无法公钥加密

```cangjie
public enum PADDING <: ToString{
    | RSA_PKCS1_PADDING 
    | RSA_NO_PADDING 
    | RSA_X931_PADDING

    /*
     * 获取单次加密数据的最大长度
     *
     * 参数 flen - RSA秘钥模长
     * 返回值 Int32 - 返回最大长度
     */
    public func getFlen(flen: Int32): Int32

    /*
     * 获取填充模型对应数值
     *
     * 返回值 Int32 - 返回填充模型对应数值
     */
    public func getPadding(): Int32
}
```

##### enum RsaTypeId

RSA 签名验证类型

```cangjie
public enum RsaTypeId <: ToString{
    | NID_md5
    | NID_md5_sha1
    | NID_sha1
    | NID_sha224
    | NID_sha256
    | NID_sha384
    | NID_sha512

    /*
     * 获取各类型对应数值
     *
     * 返回值 Int32 - 返回对应类型的数值
     */
    public func id(): Int32
}
```

##### class RSA

RSA 数据结构

```
public class RSA {

    /*
     * 初始化 RSA
     */
    public init()

    /*
     * 初始化 RSA
     * 
     * 参数 d - RSA 值
     */
    public init(d: UInt64)

    /*
     * 获取 RSA 值
     *
     * 返回值 UInt64 
     */
    public func getRsa(): UInt64
}
```

#### 4.3.2 全局函数

```cangjie
/*
 * 生成一个RSA数据结构
 *
 * 返回值 RSA
 */
public func rsaNew(): RSA

/*
 * 释放RSA数据结构
 * 
 * 参数 rsa - RSA
 * 返回值 Unit
 */
public func rsaFree(rsa: RSA): Unit

/*
 * 获取RSA密钥长度的字节数
 * 
 * 参数 rsa - RSA
 * 返回值 Int32
 */
public func rsaSize(rsa: RSA): Int32

/*
 * 根据密钥参数生成公私钥
 * 
 * 参数 rsa - RSA
 * 参数 bits - 最小位数为 512，并且是 8 的倍数
 * 返回值 Unit
 */
public func rsaGenerateKey(rsa: RSA, bits: Int32): Unit

/*
 * 验证RSA密钥
 * 
 * 参数 rsa - RSA
 * 返回值 Int32 - 如果rsa是有效的rsa密钥，则返回1，否则返回0。
 *                如果在检查键时发生错误，则返回-1。
 */
public func rsaCheckKey(key: RSA): Int32

/*
 * RSA公钥加密
 * 
 * 参数 flen - PADDING 模型对应的单次加解密最大长度
 * 参数 inside - 明文数据
 * 参数 outside - 存放生成的密文/明文数据，最大长度为 PADDING 模型对应的单次加解密最大长度，若密文/明文数据过长，建议分段加密/解密
 * 参数 rsa - 公钥
 * 参数 padding - 填充方式
 * 返回值 Int32 - 密文数据长度
 */
public func rsaPublicEncrypt(flen: Int32, inside: Array<UInt8>, outside: Array<UInt8>, rsa: RSA, padding: PADDING): Int32

/*
 * RSA私钥加密
 * 
 * 参数 flen - 明文数据长度字节数，若padding参数使用RSA_PKCS1_PADDING方式，则该值最大为所使用密钥的位数 / 8 - 11
 * 参数 inside - 明文数据
 * 参数 outside - 存放生成的密文数据，该空间大小应该为秘钥位数 / 8，保证可以存放的下
 * 参数 rsa - 私钥
 * 参数 padding - 填充方式
 * 返回值 Int32 - 密文数据长度
 */
public func rsaPrivateEncrypt(flen: Int32, inside: Array<UInt8>, outside: Array<UInt8>, rsa: RSA, padding: PADDING): Int32

/*
 * RSA私钥解密
 * 
 * 参数 flen - 密文数据长度，一般固定为秘钥位数 / 8
 * 参数 inside - 密文数据
 * 参数 outside - 存放解密后的明文数据，该空间大小应该为秘钥位数 / 8，保证可以存放的下
 * 参数 rsa - 私钥
 * 参数 padding - 填充方式
 * 返回值 Int32 - 明文数据长度
 */
public func rsaPrivateDecrypt(flen: Int32, inside: Array<UInt8>, outside: Array<UInt8>, rsa: RSA, padding: PADDING): Int32

/*
 * RSA公钥解密
 * 
 * 参数 flen - 密文数据长度，一般固定为秘钥位数 / 8
 * 参数 inside - 密文数据
 * 参数 outside - 存放解密后的明文数据，该空间大小应该为秘钥位数 / 8，保证可以存放的下
 * 参数 rsa - 公钥
 * 参数 padding - 填充方式
 * 返回值 Int32 - 明文数据长度
 */
public func rsaPublicDecrypt(flen: Int32, inside: Array<UInt8>, outside: Array<UInt8>, rsa: RSA, padding: PADDING): Int32

/*
 * RSA签名
 * 
 * 参数 types - rsa签名类型
 * 参数 m - 签名数据
 * 参数 m_len - 签名数据的长度
 * 参数 rsa - RSA
 * 返回值 Int32 - 如果签名成功返回1，否则返回0。
 *       Array<UInt8> - 签名后值
 */
public func rsaSign(types: RsaTypeId, m: Array<UInt8>, m_len: UInt32, rsa: RSA): (Int32, Array<UInt8>)

/*
 * RSA验证
 * 
 * 参数 types - rsa签名类型
 * 参数 m - 签名数据
 * 参数 m_len - 签名数据的长度
 * 参数 sigret - 签名后值（rsaSign参返回值）
 * 参数 rsa - RSA
 * 返回值 Int32 - 如果验证成功返回1，否则返回0。
 */
public func rsaVerify(types: RsaTypeId, m: Array<UInt8>, m_len: UInt32, sigbuf: Array<UInt8>, rsa: RSA): Int32

/*
 * 生成 RSA 公钥 pem 文件
 * 
 * 参数 pub_key_fn - 文件路径
 * 参数 rsa - RSA
 * 参数 isPrint - 是否打印密钥信息
 * 参数 format - 值为1: 调用PEM_write_bio_RSAPublicKey()，其它值:调用PEM_write_bio_RSA_PUBKEY()
 * 返回值 Unit
 */
public func pemWriteRsaPub(pub_key_fn: String, rsa: RSA, isPrint: Bool, format: Int32): Unit

/*
 * 生成 RSA 私钥 pem 文件
 * 
 * 参数 pub_key_fn - 文件路径
 * 参数 rsa - RSA
 * 参数 isPrint - 是否打印密钥信息
 * 返回值 Unit
 */
public func pemWriteRsaPri(pub_key_fn: String, rsa: RSA, isPrint: Bool): Unit

/*
 * 从私钥文件读取 RSA 私钥
 * 
 * 参数 pri_key_fn - 文件路径
 * 参数 isPrint - 是否打印密钥信息
 * 返回值 RSA
 */
public func pemReadRsaPri(pri_key_fn: String, isPrint: Bool): RSA

/*
 * 从公钥文件读取 RSA 公钥
 * 
 * 参数 pub_key_fn - 文件路径
 * 参数 isPrint - 是否打印密钥信息
 * 参数 format - 值为1: 调用PEM_write_bio_RSAPublicKey()，其它值:调用PEM_write_bio_RSA_PUBKEY()
 * 返回值 RSA
 */
public func pemReadRsaPub(pub_key_fn: String, isPrint: Bool, format: Int32): RSA
```

#### 4.3.3 示例

代码如下：

```cangjie
from cryptocj import rsacj.*
from cryptocj import bignumcj.*
from cryptocj import utils.*
from encoding import hex.*
from std import collection.*
from std import unicode.*

main() {
    var r: RSA = rsaNew()
    var bit: Int32 = 1024

    let ret = rsaGenerateKey(r, bit) 

    var len: Int32
    var flen: Int32 
    var padding: Int32
    flen = rsaSize(r)

    let inside: Array<UInt8> = Array<UInt8>(Int64(flen) , item: 0)
    var out: Array<UInt8> = Array<UInt8>(Int64(flen * 2), item: 0)
    var outside: Array<UInt8> = Array<UInt8>(inside.size , item: 0)
    let c = RSA_NO_PADDING
    flen = c.getFlen(flen)
    for (i in 0..Int64(flen)) {
        inside[i] = UInt8(i)
    }
    len = rsaPrivateEncrypt(flen, inside, out, r, c)
    len = rsaPublicDecrypt(len, out, outside, r, c)
    if (outside[0..Int64(flen)].toString() != inside[0..Int64(flen)].toString()) {
        rsaFree(r)
        return -1
    }
    len = rsaPublicEncrypt(flen, inside, out, r, c)
    len = rsaPrivateDecrypt(len, out, outside, r, c)
    if (outside[0..Int64(flen)].toString() != inside[0..Int64(flen)].toString()) {
        rsaFree(r)
        return -1
    }
    rsaFree(r)
    println("Test Ok!")
    return 0
}
```

运行结果如下：

```cangjie
Test Ok!
0
```

### 4.4 ECC

ECC 算法，包括三部分： ECC 算法(crypto/ec)、椭圆曲线数字签名算法 ECDSA (crypto/ecdsa)以及椭圆曲线密钥交换算法 ECDH(crypto/dh)。

支持 ecdsa 签名验证和 ecdh共享密钥生成

#### 4.4.1 主要接口

##### enum CurvesId

椭圆曲线

```cangjie
public enum CurvesId {
    | NID_secp112r1
    | NID_secp112r2 
    | NID_secp128r1 
    | NID_secp128r2 
    | NID_secp160k1 
    | NID_secp160r1 
    | NID_secp160r2 
    | NID_secp192k1 
    | NID_secp224k1 
    | NID_secp224r1 
    | NID_secp256k1 
    | NID_secp384r1 
    | NID_secp521r1 
    | NID_X9_62_prime192v1 
    | NID_X9_62_prime192v2 
    | NID_X9_62_prime192v3 
    | NID_X9_62_prime239v1 
    | NID_X9_62_prime239v2 
    | NID_X9_62_prime239v3 
    | NID_X9_62_prime256v1 
    | NID_sect113r1 
    | NID_sect113r2 
    | NID_sect131r1 
    | NID_sect131r2 
    | NID_sect163k1 
    | NID_sect163r1 
    | NID_sect163r2 
    | NID_sect193r1 
    | NID_sect193r2 
    | NID_sect233k1 
    | NID_sect233r1 
    | NID_sect239k1 
    | NID_sect283k1 
    | NID_sect283r1 
    | NID_sect409k1 
    | NID_sect409r1 
    | NID_sect571k1 
    | NID_sect571r1 
    | NID_X9_62_c2pnb163v1 
    | NID_X9_62_c2pnb163v2 
    | NID_X9_62_c2pnb163v3 
    | NID_X9_62_c2pnb176v1 
    | NID_X9_62_c2tnb191v1 
    | NID_X9_62_c2tnb191v2 
    | NID_X9_62_c2tnb191v3 
    | NID_X9_62_c2pnb208w1 
    | NID_X9_62_c2tnb239v1 
    | NID_X9_62_c2tnb239v2 
    | NID_X9_62_c2tnb239v3 
    | NID_X9_62_c2pnb272w1 
    | NID_X9_62_c2pnb304w1 
    | NID_X9_62_c2tnb359v1 
    | NID_X9_62_c2pnb368w1 
    | NID_X9_62_c2tnb431r1 
    | NID_wap_wsg_idm_ecid_wtls1 
    | NID_wap_wsg_idm_ecid_wtls3 
    | NID_wap_wsg_idm_ecid_wtls4 
    | NID_wap_wsg_idm_ecid_wtls5 
    | NID_wap_wsg_idm_ecid_wtls6 
    | NID_wap_wsg_idm_ecid_wtls7 
    | NID_wap_wsg_idm_ecid_wtls8 
    | NID_wap_wsg_idm_ecid_wtls9 
    | NID_wap_wsg_idm_ecid_wtls10 
    | NID_wap_wsg_idm_ecid_wtls11 
    | NID_wap_wsg_idm_ecid_wtls12 
    | NID_ipsec3 
    | NID_ipsec4 
    | NID_brainpoolP160r1 
    | NID_brainpoolP160t1 
    | NID_brainpoolP192r1 
    | NID_brainpoolP192t1 
    | NID_brainpoolP224r1 
    | NID_brainpoolP224t1 
    | NID_brainpoolP256r1 
    | NID_brainpoolP256t1 
    | NID_brainpoolP320r1 
    | NID_brainpoolP320t1 
    | NID_brainpoolP384r1 
    | NID_brainpoolP384t1 
    | NID_brainpoolP512r1 
    | NID_brainpoolP512t1 
    | NID_sm2 

    /*
     * 获得椭圆曲线对应 id
     *
     * 返回值 Int32
     */
    public func getNum(): Int32
}
```

##### enum EC_KEY

密钥数据结构

```cangjie
public class EC_KEY {
    /*
     * 初始化 EC_KEY
     *
     * 参数 key - EC_KEY 值
     */
    public init(key: UInt64)

    /*
     * Get ECC key 值
     *
     * 返回值 UInt64
     */
    public func getEcKey(): UInt64

    /*
     * Release ECC key 值
     *
     * 返回值 UInt64
     */
    public func free(): Unit
}
```

##### class EC_POINT

ECC 公钥

```
public class EC_POINT {

    /*
     * 初始化 EC_POINT
     *
     * 参数 point - EC_POINT 值
     */
    public init(point: UInt64)

    /*
     * 获取 ECC 公钥值
     *
     * 参数 key - EC_POINT 值
     */
    public func getEcPoint(): UInt64
}
```

##### class EC_GROUP

ECC 密钥参数

```
public class EC_GROUP {
    /*
     * 初始化 EC_GROUP
     *
     * 参数 group - EC_GROUP 值
     */
    public init(group: UInt64)

    /*
     * 获取 ECC 密钥参数值
     *
     * 返回值 UInt64
     */
    public func getEcGroup(): UInt64
}
```

##### class SIN_MALLOC

为签名值分配内存

```
public class SIN_MALLOC {

    /*
     * 初始化 SIN_MALLOC
     *
     * 参数 size - SIN_MALLOC 值
     */
    public init(size: Int32)
    
    /*
     * 获取签名值内存
     *
     * 返回值 CString
     */
    public func getSinMalloc(): CString

}
```

##### class SINSTR

签名结果

```
public class SINSTR {

    /*
     * 初始化 SINSTR
     *
     * 参数 s - Signature 值
     * 参数 l - Signature 值 length
     */
    public init(s: Array<UInt8>, l: Int32)

    /*
     * 获取签名值
     *
     * 返回值 Array<UInt8>
     */
    public func getSinStr(): Array<UInt8>

    /*
     * 获取签名值长度
     *
     * 返回值 Int32 - Signature 值 length
     */
    public func getSinLen(): Int32
}
```

#### 4.4.2 全局函数

```cangjie
/*
 * 创建 ECC 密钥结构
 *
 * 返回值 EC_KEY
 */
public func ecKeyNew(): EC_KEY

/*
 * 创建 ECC 公钥结构
 *
 * 参数 group - 密钥参数结构
 * 返回值 EC_POINT
 */
public func ecPoint(group: EC_GROUP): EC_POINT

/*
 * 创建 ECC 密钥参数结构
 *
 * 返回值 EC_GROUP
 */
public func ecGroup(): EC_GROUP

/*
 * 根据椭圆曲线 id 值创建 EC 密钥参数结构
 *
 * 参数 nid - 椭圆曲线 id
 * 返回值 EC_GROUP - 密钥参数结构
 */
public func ecGroupNewByCurveName(nid: CurvesId): EC_GROUP

/*
 * 设置密钥参数。
 *
 * 参数 key - EC_KEY
 * 参数 group - EC_GROUP
 * 返回值 Unit
 */
public func ecKeySetGroup(key: EC_KEY, group: EC_GROUP): Unit

/*
 * 获取密钥参数。
 *
 * 参数 key - EC_KEY
 * 返回值 EC_GROUP
 */
public func ecKeyGetGroup(key: EC_KEY): EC_GROUP

/*
 * 根据密钥参数生成公私钥。
 *
 * 参数 key - EC_KEY
 * 返回值 Unit
 */
public func ecKeyGenerateKey(key: EC_KEY): Unit

/*
 * 检查密钥。
 *
 * 参数 key - EC_KEY
 * 返回值 Unit
 */
public func ecKeyCheckKey(key: EC_KEY): Unit

/*
 * 返回签名的最大长度。
 *
 * 参数 key - EC_KEY
 * 返回值 Int32
 */
public func ecdsaSize(eckey: EC_KEY): Int32

/*
 * 使用提供的私钥进行签名
 *
 * 参数 dgst - 待签名值
 * 参数 sig - 已分配内存的签名值
 * 参数 eckey - EC_KEY
 * 返回值 SINSTR - 签名值和签名值长度
 */
public func ecdsaSign(dgst: Array<UInt8>, sig: SIN_MALLOC, eckey: EC_KEY): SINSTR

/*
 * 使用指定的公钥验证签名。
 *
 * 参数 dgst - 待签名值
 * 参数 sig - Allocating memory for signatures
 * 参数 eckey - EC_KEY
 * 返回值 Int32 - 1: 成功，其他失败
 */
public func ecdsaVerify(dgst: Array<UInt8>, sig: SINSTR, eckey: EC_KEY): Int32

/*
 * 获取 EC 公钥。
 *
 * 参数 key - EC_KEY
 * 返回值 EC_POINT
 */
public func ecKeyGet0PublicKey(key: EC_KEY): EC_POINT

/*
 * 获取 EC 私钥。
 *
 * 参数 key - EC_KEY
 * 返回值 CPointer<BIGNUM>
 */
public func ecKeyGet0PrivateKey(key: EC_KEY): CPointer<BIGNUM>

/*
 * 获取共享密钥。
 *
 * 参数 outlen - 共享密钥长度
 * 参数 pub_key - EC_POINT
 * 参数 ecdh - EC_POINT
 * 返回值 Int32 - 共享密钥长度
 *         Array<UInt8> - 共享密钥
 */
public func ecdhComputeKey(outlen: Int32, pub_key: EC_POINT, ecdh: EC_KEY): (Int32, Array<UInt8>)

/*
 * 释放 EC_KEY 结构。
 *
 * 参数 key - EC_KEY
 * 返回值 Unit
 */
public func ecKeyFree(key: EC_KEY): Unit

/*
 * 打印 EC 密钥参数。
 *
 * 参数 key - EC_KEY
 * 返回值 Unit
 */
public func ecParamstersPrint(key: EC_KEY): Unit

/*
 * 打印 EC 密钥。
 *
 * 参数 key - EC_KEY
 * 返回值 Unit
 */
public func ecKeyPrint(key: EC_KEY): Unit

/*
 * 将 EC 公钥写入 pem 文件。
 *
 * 参数 pub_key_fn - file path
 * 参数 ecKey - EC_KEY
 * 返回值 Unit
 */
public func pemWriteEcPub(pub_key_fn: String, ecKey: EC_KEY): Unit

/*
 * 将 EC 私钥写入 pem 文件。
 *
 * 参数 pub_key_fn - file path
 * 参数 ecKey - EC_KEY
 * 返回值 Unit
 */
public func pemWriteEcPri(pri_key_fn: String, ecKey: EC_KEY): Unit

/*
 * 将 EC 公密钥参数写入 pem 文件。
 *
 * 参数 pub_key_fn - file path
 * 参数 ecKey - EC_GROUP
 * 返回值 Unit
 */
public func pemWriteEcPara(para_key_fn: String, ecGroup: EC_GROUP): Unit

/*
 * 从文件读取私钥。
 *
 * 参数 pri_key_fn - file path
 * 返回值 EC_KEY
 */
public func pemReadEcPri(pri_key_fn: String): EC_KEY

/*
 * 从文件读取公钥。
 *
 * 参数 pri_key_fn - file path
 * 返回值 EC_KEY
 */
public func pemReadEcPub(pub_key_fn: String): EC_KEY

/*
 * 从文件读取密钥参数。
 *
 * 参数 pri_key_fn - file path
 * 返回值 EC_KEY
 */
public func pemReadEcPara(para_key_fn: String): EC_GROUP

/*
 * 使用椭圆曲线直接创建 EC_KEY
 *
 * 参数 nid - curve id
 * 返回值 EC_KEY
 */
public func ecKeyNewByCurveName(nid: CurvesId): EC_KEY
```

#### 4.4.3 示例

代码如下：

```cangjie
from cryptocj import eccj.*
from encoding import hex.*
from std import os.posix.*

main() {  
    var path: String = getcwd() 
    var key1 = ecKeyNew()
    var key2 = ecKeyNew()
    var pubkey1 = ecPoint()
    var pubkey2 = ecPoint()
    var group1 = ecGroup()
    var group2 = ecGroup()
    var ret: Int32 = 0
    var nid: Int32 = 0
    var size: Int32 = 0
    var sig_len: Int32 = 0
    var i: Int32 = 0
    var crv_len: Int32 = 0

    /* 根据选择的椭圆曲线生成密钥参数 group */
    group1 = ecGroupNewByCurveName(CurvesId.NID_sm2)
    group2 = ecGroupNewByCurveName(CurvesId.NID_sm2)
    /* 设置密钥参数 */
    ecKeySetGroup(key1, group1)
    ecKeySetGroup(key2, group2)
    /* 生成密钥 */
    ecKeyGenerateKey(key1)
    ecKeyGenerateKey(key2)
    /* 检查密钥 */
    ecKeyCheckKey(key1)
    ecKeyCheckKey(key2)
    /* 获取密钥大小 */
    size = ecdsaSize(key1)

    pemWriteEcPub("${path}/ec_pub.pem", key1)
    pemWriteEcPri("${path}/ec_pri.pem", key1)
    pemWriteEcPara("${path}/ec_para.pem", group1)

    var sigbuf = SIN_MALLOC(size)
    var s: String = "e665c280cf27dacd1f1b6b053cb307f32ee32fd0"
    var digest: Array<UInt8> = fromHexString(s).getOrThrow()
    var sinret: SINSTR = ecdsaSign(digest, sigbuf, key1)
    ret = ecdsaVerify(digest, sinret, key1)
    /* 获取对方公钥，不能直接引用 */
    pubkey2 = ecKeyGet0PublicKey(key2)
    /* 生成一方的共享密钥 */
    var (len1,sharekey1)= ecdhComputeKey(128, pubkey2, key1)
    pubkey1 = ecKeyGet0PublicKey(key1)
    var (len2,sharekey2)= ecdhComputeKey(128, pubkey1, key2)
    if(len1 != len2 || sharekey1 != sharekey2) {
        return -1
    }
    return 0 
}

```

运行结果如下：

```cangjie
0
```

## 5 其他接口

```
/*
 * 将 数组转为 bits 位的二维数组
 *
 * 参数 arr - 需要转换数组
 * 参数 bits - 位
 * 返回值 ArrayList<Array<UInt8>> - 转换后的数组
 */
public func arrayTo2Array(arr: Array<UInt8>, bits: Int64): ArrayList<Array<UInt8>>

/*
 * cryptocj  错误处理
 */
public class CryptoException <: Exception {
    /*
     * 无参构造
     */
    public init()

    /*
     * 构造函数
     *
     * 参数 messages - 报错信息
     */
    public init(messages: String)
}
```