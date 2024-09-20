/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights resvered.
 */
package zip4cj.io.outputstream

abstract class CipherOutputStream <: OutputStream & Resource {
    protected var outputStream: ZipEntryOutputStream
    protected var zipParameters: ZipParameters
    protected var password: ?Array<Rune>
    protected var useUtf8ForPassword: Bool
    protected open prop encrypter: Encrypter
    var closed = false
    public init(
        zipEntryOutputStream: ZipEntryOutputStream,
        zipParameters: ZipParameters,
        password: ?Array<Rune>,
        useUtf8ForPassword: Bool
    ) {
        this.outputStream = zipEntryOutputStream
        this.zipParameters = zipParameters
        this.password = password
        this.useUtf8ForPassword = useUtf8ForPassword
    }

    public open func write(b: Array<UInt8>): Unit {
        encrypter.encryptData(b)
        this.outputStream.write(b)
    }

    public open func writeHeaders(b: Array<UInt8>): Unit {
        this.outputStream.write(b)
    }

    public open func closeEntry(): Unit {
        this.outputStream.closeEntry()
    }

    public open func close(): Unit {
        this.outputStream.close()
        closed = true
    }

    public open func isClosed(): Bool {
        if (let Some(v) <- (outputStream as Resource)){
            v.isClosed()
        } else {
            closed
        }
    }

    public open func getNumberOfBytesWrittenForThisEntry(): Int64 {
        return this.outputStream.getNumberOfBytesWrittenForThisEntry()
    }

    protected open func getEncrypter(): Encrypter {
        return encrypter
    }

    public open func flush(): Unit {
        return
    }
}
