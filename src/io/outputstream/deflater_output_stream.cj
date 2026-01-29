/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package zip4cj.io.outputstream

enum OUTPUT <: OutputStream & Resource {
    | DEFLATE(Zlib4cjDeflaterOutputStream)
    | BUFFER(BufferedOutputStream<ICipherOutputStream>)

    public func write(b: Array<UInt8>): Unit {
        match(this) {
            case DEFLATE(v) => v.write(b)
            case BUFFER(v) => v.write(b)
        }
    } 

    public func close(): Unit {
        match(this) {
            case DEFLATE(v) => v.close()
            case BUFFER(v) => v.close()
        }
    }

    public func isClosed(): Bool {
        match(this) {
            case DEFLATE(v) => false
            case BUFFER(v) => v.isClosed()
        }
    }

    public func flush(): Unit {
        match(this) {
            case DEFLATE(v) => v.flush()
            case BUFFER(v) => v.flush()
        }
    }
}

class DeflaterOutputStream <: CompressedOutputStream {
    var deflater: OUTPUT
    public init(cipherOutputStream: ICipherOutputStream, compressionLevel: CompressionLevel, bufferSize: Int64) {
        super(cipherOutputStream)
        let level = Int64(compressionLevel.getLevel())
        this.deflater = if (level == 0) {
            OUTPUT.BUFFER(BufferedOutputStream<ICipherOutputStream>(cipherOutputStream))
        } else {
            OUTPUT.DEFLATE(Zlib4cjDeflaterOutputStream(cipherOutputStream, bufferSize: bufferSize, level: level))
        }
    }

    public func write(b: Array<UInt8>): Unit {
        this.deflater.write(b)
    }

    public func closeEntry(): Unit {
        this.deflater.close()
        super.closeEntry()
    }
}
