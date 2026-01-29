/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package zip4cj.io.inputstream



class InflaterInputStream <: DecompressedInputStream {
    private var inflater: Zlib4cjInflaterInputStream
    private var buff: Array<Byte>
    private var singleByteBuffer = Array<Byte>(1, repeat: 0)
    private var len: Int64 = 0
    private var inputLen: Int64 = 0

    public init(cipherInputStream: ICipherInputStream, bufferSize: Int64) {
        super(cipherInputStream)
        this.inflater = Zlib4cjInflaterInputStream(cipherInputStream, bufferSize)
        buff = Array<Byte>(bufferSize, repeat: 0)
    }

    public func read(b: Array<Byte>): Int64 {
        return this.inflater.read(b)
    }

    public func endOfEntryReached(inputStream: InputStream, numberOfBytesPushedBack: Int64) {
        //inflater.end()
        super.endOfEntryReached(inputStream, numberOfBytesPushedBack)
    }

    public func pushBackInputStreamIfNecessary(pushbackInputStream: InputStream): Int64 {
        let n = this.inflater.getRemaining()
        if (n > 0) {
            let rawDataCache = getLastReadRawDataCache()
            (pushbackInputStream as PushbackInputStream).getOrThrow().unread(rawDataCache[inputLen - n..inputLen])
        }
        return n
    }

    public func close(): Unit {
        inflater.close()
        super.close()
    }
}
