package zip4cj.util

public class Zip4cjUtil {
    private static let DOSTIME_BEFORE_1980: Int64 = (1 << 21) | (1 << 16)

    private static let MAX_RAW_READ_FULLY_RETRY_ATTEMPTS: Int32 = 15

    public static func isStringNullOrEmpty(str: ?String): Bool {
        return str.isNone() || str.getOrThrow().trim().size == 0
    }

    public static func isStringNotNullAndNotEmpty(str: ?String): Bool {
        return str != None && str.getOrThrow().trim().size > 0
    }

    public static func createDirectoryIfNotExists(file: Path): Bool {
        /* Temporal and Temporal Implementation */
        return true
    }

    public static func epochToExtendedDosTime(time: Int64): Int64 {
        if (time < 0) {
            return DOSTIME_BEFORE_1980
        }
        let FileTime = DateTime.ofEpoch(second: time / 1000000000, nanosecond: 0)
        return (FileTime.year - 1980) << 25
            | FileTime.month.value() << 21
            | (FileTime.dayOfYear + 1) << 16
            | (FileTime.hour * 2) << 11
            | FileTime.minute << 5
            | FileTime.second >> 1
    }

    private static func dosToEpochTime(dosTime: Int64): Int64 {
        var sec: Int64 = Int64(((dosTime << 1) & 0x3e))
        var min: Int64 = Int64((dosTime >> 5) & 0x3f)
        var hrs: Int64 = Int64(((dosTime >> 11) & 0x1f))
        var day: Int64 = Int64(((dosTime >> 16) & 0x1f))
        var mon: Int64 = Int64((((dosTime >> 21) & 0xf) - 1))
        var year: Int64 = Int64((((dosTime >> 25) & 0x7f) + 1980))

        var date: DateTime = DateTime.of(year: year, month: Month.of(mon), dayOfMonth: day, hour: hrs, minute: min,
            second: sec, nanosecond: 0)
        return date.toUnixTimeStamp().toMilliseconds()
    }

    public static func convertCharArrayToByteArray(charArray: Array<Char>, useUtf8Charset: Bool): Array<Byte> {
        return if (useUtf8Charset) {
            convertCharArrayToByteArrayUsingUtf8(charArray)
        } else {
            convertCharArrayToByteArrayUsingDefaultCharset(charArray)
        }
    }

    public static func getCompressionMethod(localFileHeader: AbstractFileHeader): CompressionMethod {
        if (localFileHeader.getCompressionMethod().getOrThrow().getCode() !=
            CompressionMethod.AES_INTERNAL_ONLY.getCode()) {
            return localFileHeader.getCompressionMethod().getOrThrow()
        }
        match (localFileHeader.getAesExtraDataRecord()) {
            case None => throw ZipException("AesExtraDataRecord not present in local header for aes encrypted data")
            case Some(v) => return v.getCompressionMethod()
        }
    }

    public static func readFully(inputStream: InputStream, bufferToReadInto: Array<Byte>): Int32 {
        var readLen: Int32 = Int32(inputStream.read(bufferToReadInto))
        if (readLen == 0) {
            throw ZipIOException("Unexpected EOF reached when trying to read stream")
        }
        if (Int64(readLen) != bufferToReadInto.size) {
            readLen = readUntilBufferIsFull(inputStream, bufferToReadInto, readLen)
            if (Int64(readLen) != bufferToReadInto.size) {
                throw ZipIOException("Cannot read fully into byte buffer")
            }
        }
        return readLen
    }

    public static func readFully(inputStream: InputStream, b: Array<Byte>, offset: Int64, length: Int64): Int64 {
        if (offset < 0) {
            throw IllegalArgumentException("Negative offset")
        }
        if (length < 0) {
            throw IllegalArgumentException("Negative length")
        }
        if (length == 0) {
            return 0
        }
        if (Int64(offset + length) > b.size) {
            throw IllegalArgumentException("Length greater than buffer size")
        }
        return inputStream.read(b[offset..offset + length])
    }

    private static func readUntilBufferIsFull(inputStream: InputStream, bufferToReadInto: Array<Byte>, readLength: Int32): Int32 {
        if (readLength < 0) {
            throw ZipIOException("Invalid readLength")
        }
        if (readLength == 0) {
            return 0
        }
        var remainingLength: Int32 = Int32(bufferToReadInto.size) - readLength
        var loopReadLength: Int32 = 0

        // first attempt is already done before this method is called
        var retryAttempt: Int32 = 1
        var readLengthNew: Int32 = readLength
        while (readLengthNew < Int32(bufferToReadInto.size) && loopReadLength != -1 && retryAttempt <
                MAX_RAW_READ_FULLY_RETRY_ATTEMPTS) {
            loopReadLength = Int32(inputStream.read(
                    bufferToReadInto[Int64(readLengthNew)..Int64(readLengthNew) + Int64(remainingLength)]))
            if (loopReadLength > 0) {
                readLengthNew += loopReadLength
                remainingLength -= loopReadLength
            }
            retryAttempt++
        }
        return readLengthNew
    }

    private static func convertCharArrayToByteArrayUsingUtf8(charArray: Array<Char>): Array<Byte> {
        // TODO
        try {
            return Array<Byte>()
        } catch (e: Exception) {
            return convertCharArrayToByteArrayUsingDefaultCharset(charArray)
        }
    }

    private static func convertCharArrayToByteArrayUsingDefaultCharset(charArray: Array<Char>): Array<Byte> {
        var bytes: Array<Byte> = Array<Byte>(charArray.size, item: 0)
        for (i in 0..charArray.size) {
            bytes[i] = UInt8.parse(charArray[i].toString())
        }
        return bytes
    }
}

public class ByteBuffer <: Buffer & ToString & Hashable & Equatable<Buffer> {
    let hb: Array<Byte>
    let offset: Int64

    init(mark: Int64, position: Int64, limits: Int64, capacity: Int64, hbs: Array<Byte>, offsets: Int64) {
        super(mark, position, limits, capacity)
        this.hb = hbs
        this.offset = offsets
    }

    init(cap: Int64, lims: Int64) {
        this(-1, 0, lims, cap, Array<Byte>(cap, item: 0), 0)
    }

    init(bufs: Array<Byte>, off: Int64, len: Int64) {
        this(-1, off, off + len, bufs.size, bufs, 0)
    }

    protected init(bufs: Array<Byte>, mark: Int64, pos: Int64, lim: Int64, cap: Int64, off: Int64) {
        this(mark, pos, lim, cap, bufs, off)
    }

    public static func allocate(capacitys: Int64): ByteBuffer {
        if (capacitys < 0) {
            throw IllegalArgumentException()
        }
        return ByteBuffer(capacitys, capacitys)
    }

    public static func wrap(arrays: Array<UInt8>, offset: Int64, length: Int64): ByteBuffer {
        try {
            return ByteBuffer(arrays, offset, length)
        } catch (ex: IllegalArgumentException) {
            throw IndexOutOfBoundsException()
        }
    }

    public static func wrap(arrays: Array<UInt8>): ByteBuffer {
        return wrap(arrays, 0, arrays.size)
    }

    public func get(dst: Array<UInt8>): ByteBuffer {
        return get(dst, 0, dst.size)
    }

    public func put(srcs: Array<UInt8>): ByteBuffer {
        return this.put(srcs, 0, srcs.size)
    }

    public func hasArray(): Bool {
        return false
    }

    public func array(): Array<UInt8> {
        return this.hb
    }

    public func arrayOffset(): Int64 {
        return this.offset
    }

    public func position(newPosit: Int64): ByteBuffer {
        super.position(newPosit)
        return this
    }

    public func limit(newLim: Int64): ByteBuffer {
        super.limit(newLim)
        return this
    }

    public func reset(): ByteBuffer {
        super.reset()
        return this
    }

    public func clear(): ByteBuffer {
        super.clear()
        return this
    }

    public func flip(): ByteBuffer {
        super.flip()
        return this
    }

    public func rewind(): ByteBuffer {
        super.rewind()
        return this
    }

    public func toString(): String {
        let sbd = StringBuilder()
        sbd.append("ByteBuffer: [offset=")
        sbd.append(this.offset)
        sbd.append(" mark=")
        sbd.append(this.mar)
        sbd.append(" pos=")
        sbd.append(position())
        sbd.append(" lim=")
        sbd.append(limit())
        sbd.append(" cap=")
        sbd.append(capacity())
        sbd.append("]")
        return sbd.toString()
    }

    @OverflowWrapping
    public func hashCode(): Int64 {
        var hc: Int32 = 1
        var p = position()
        for (i in limit() - 1..=p : -1) {
            hc = 31 * hc + Int32(get(i))
        }
        return Int64(hc)
    }

    public operator func ==(thats: Buffer): Bool {
        return refEq(this, thats)
    }

    public operator func !=(thats: Buffer): Bool {
        return !refEq(this, thats)
    }

    public func slice(): ByteBuffer {
        return ByteBuffer(this.hb, -1, 0, this.remaining(), this.remaining(), this.position() + offset)
    }

    public func slice(pos: Int64, limit: Int64): ByteBuffer {
        let rem = limit - pos
        return ByteBuffer(hb, -1, 0, rem, rem, pos + offset)
    }

    public func duplicate(): ByteBuffer {
        return ByteBuffer(hb, this.markValue(), this.position(), this.limit(), this.capacity(), offset)
    }

    public func asReadOnlyBuffer(): ByteBuffer {
        return ByteBuffer(hb, this.markValue(), this.position(), this.limit(), this.capacity(), offset)
    }

    protected func ix(ii: Int64): Int64 {
        return ii + offset
    }

    public func get(): Byte {
        return hb[ix(nextGetIndex())]
    }

    public func get(i: Int64): Byte {
        return hb[ix(checkIndex(i))]
    }

    public func get(dsts: Array<Byte>, offset: Int64, length: Int64): ByteBuffer {
        checkBounds(offset, length, dsts.size)
        if (length > this.remaining()) {
            throw BufferUnderflowException()
        }
        ArrayCopy(hb, ix(position()), dsts, offset, length)
        position(position() + length)
        return this
    }

    public func put(x: Byte): ByteBuffer {
        hb[ix(nextGetIndex())] = x
        return this
    }

    public func put(i: Int64, x: Byte): ByteBuffer {
        hb[ix(checkIndex(i))] = x
        return this
    }

    public func put(src: Array<Byte>, offsets: Int64, length: Int64): ByteBuffer {
        checkBounds(offsets, length, src.size)
        if (length > remaining()) {
            throw BufferOverflowException()
        }
        ArrayCopy(src, offsets, hb, ix(position()), length)
        position(position() + length)
        return this
    }

    public func put(srcs: ByteBuffer): ByteBuffer {
        if (srcs is ByteBuffer) {
            if (srcs == this) {
                throw createSameBufferException()
            }
            let sb: ByteBuffer = (srcs as ByteBuffer).getOrThrow()
            let n = sb.remaining()
            if (n > remaining()) {
                throw BufferOverflowException() // BufferOverflowException
            }
            ArrayCopy(sb.hb, sb.ix(sb.position()), hb, ix(position()), n)
            sb.position(sb.position() + n)
            position(position() + n)
        }
        return this
    }

    public func compact(): ByteBuffer {
        ArrayCopy(hb, ix(position()), hb, ix(0), remaining())
        position(remaining())
        limit(capacity())
        discardMark()
        return this
    }

    @OverflowWrapping
    public func putLong(val: Int64): ByteBuffer {
        this.putUInt64(UInt64(val))
    }

    @OverflowWrapping
    public func putInt(val: Int32): ByteBuffer {
        this.putUInt32(UInt32(val))
    }

    @OverflowWrapping
    public func putShort(val: Int16): ByteBuffer {
        this.putUInt16(UInt16(val))
    }

    @OverflowWrapping
    public func getLong(): Int64 {
        return Int64(this.getUInt64())
    }

    @OverflowWrapping
    public func getInt(): Int32 {
        return Int32(this.getUInt32())
    }

    @OverflowWrapping
    public func getShort(): Int16 {
        return Int16(this.getUInt16())
    }

    @OverflowWrapping
    public func putUInt64(val: UInt64): ByteBuffer {
        this.put(UInt8((val >> 56) & 0xff))
        this.put(UInt8((val >> 48) & 0xff))
        this.put(UInt8((val >> 40) & 0xff))
        this.put(UInt8((val >> 32) & 0xff))
        this.put(UInt8((val >> 24) & 0xff))
        this.put(UInt8((val >> 16) & 0xff))
        this.put(UInt8((val >> 8) & 0xff))
        this.put(UInt8(val & 0xff))
        return this
    }

    @OverflowWrapping
    public func putUInt32(val: UInt32): ByteBuffer {
        this.put(UInt8((val >> 24) & 0xff))
        this.put(UInt8((val >> 16) & 0xff))
        this.put(UInt8((val >> 8) & 0xff))
        this.put(UInt8(val & 0xff))
        return this
    }

    @OverflowWrapping
    public func putUInt16(val: UInt16): ByteBuffer {
        this.put(UInt8((val >> 8) & 0xff))
        this.put(UInt8(val & 0xff))
        return this
    }

    @OverflowWrapping
    public func getUInt64(): UInt64 {
        return UInt64(this.get()) << 56 | UInt64(this.get()) << 48 | UInt64(this.get()) << 40 | UInt64(this.get()) << 32 |
            UInt64(this.get()) << 24 | UInt64(this.get()) << 16 | UInt64(this.get()) << 8 | UInt64(this.get())
    }

    @OverflowWrapping
    public func getUInt32(): UInt32 {
        return UInt32(this.get()) << 24 | UInt32(this.get()) << 16 | UInt32(this.get()) << 8 | UInt32(this.get())
    }

    @OverflowWrapping
    public func getUInt16(): UInt16 {
        return UInt16(this.get()) << 8 | UInt16(this.get())
    }
    func createSameBufferException(): IllegalArgumentException {
        throw IllegalArgumentException("The source buffer is this buffer")
    }
}

public class BufferOverflowException <: Exception {
    public init() {
        super("BufferOverflowException: \n")
    }
}

/**
 * The class is Buffer inherited from Object & ToString
 * @author liyanqing14
 * @since 0.32.5
 */
public abstract class Buffer <: Object & ToString {
    // Invariants: mar <= pos <= lim <= capa
    // Read / write mark
    var mar: Int64 = -1

    // Read / write position
    var pos: Int64 = 0

    // Read / write limit
    var lim: Int64

    // Read / write capacity
    var capa: Int64

    Buffer(marks: Int64, position: Int64, limits: Int64, capacity: Int64) {
        if (capacity < 0) {
            throw IllegalArgumentException()
        }
        this.capa = capacity
        if (limits > this.capa || limits < 0) {
            throw IllegalArgumentException()
        }
        this.lim = limits
        if (this.pos > this.lim) {
            this.pos = this.lim
        }
        if (this.mar > this.lim) {
            this.mar = -1
        }
        if (position > this.lim || position < 0) {
            throw IllegalArgumentException()
        }
        this.pos = position
        if (mar > pos) {
            this.mar = -1
        }
        if (marks >= 0) {
            if (marks > position) {
                throw IllegalArgumentException()
            }
            this.mar = marks
        }
    }

    /**
     * The Function is capacity
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func capacity(): Int64 {
        return capa
    }

    /**
     * The Function is position
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func position(): Int64 {
        return pos
    }

    /**
     * The Function is position
     *
     * @param newPosition of Int64
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func position(newPosit: Int64): Buffer {
        if (newPosit > lim || newPosit < 0) {
            throw IllegalArgumentException("newPosition")
        }
        if (mar > pos) {
            mar = -1
        }
        pos = newPosit
        return this
    }

    /**
     * The Function is limit
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func limit(): Int64 {
        return lim
    }

    /**
     * The Function is limit
     *
     * @param newLimit of Int64
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func limit(newLimits: Int64): Buffer {
        if (newLimits > capa || newLimits < 0) {
            throw IllegalArgumentException("newLimit")
        }
        lim = newLimits
        if (pos > lim) {
            pos = lim
        }
        if (mar > lim) {
            mar = -1
        }
        return this
    }

    /**
     * The Function is mark
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func mark(): Buffer {
        mar = pos
        return this
    }

    /**
     * The Function is reset
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func reset(): Buffer {
        var ma = mar
        if (ma < 0) {
            throw BufferOverflowException()
        }
        pos = ma
        return this
    }

    /**
     * The Function is clear
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func clear(): Buffer {
        pos = 0
        lim = capa
        mar = -1
        return this
    }

    /**
     * The Function is flip
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func flip(): Buffer {
        lim = pos
        pos = 0
        mar = -1
        return this
    }

    /**
     * The Function is rewind
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public open func rewind(): Buffer {
        pos = 0
        mar = -1
        return this
    }

    /**
     * The Function is remaining
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func remaining(): Int64 {
        let rems = lim - pos
        return if (rems > 0) {
            rems
        } else {
            0
        }
    }

    /**
     * The Function is hasRemaining
     *
     * @return Type of Bool
     * @since 0.32.5
     */
    public func hasRemaining(): Bool {
        return pos < lim
    }

    /**
     * The Function is arrayOffset
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    public func arrayOffset(): Int64

    /**
     * The Function is slice
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func slice(): Buffer

    /**
     * The Function is duplicate
     *
     * @return Type of Buffer
     * @since 0.32.5
     */
    public func duplicate(): Buffer

    /**
     * The Function is array
     *
     * @return Type of Array<UInt8>
     * @since 0.32.5
     */
    public func array(): Array<UInt8>

    /**
     * The Function is nextGetIndex
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    func nextGetIndex(): Int64 {
        if (pos >= lim) {
            throw BufferOverflowException()
        }
        let temps = pos
        pos++
        return temps
    }

    /**
     * The Function is checkIndex
     *
     * @param i of Int64
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    func checkIndex(t: Int64): Int64 {
        if ((t < 0) || (t >= lim)) {
            throw IndexOutOfBoundsException()
        }
        return t
    }

    /**
     * The Function is markValue
     *
     * @return Type of Int64
     * @since 0.32.5
     */
    func markValue(): Int64 {
        return mar
    }

    /**
     * The Function is discardMark
     *
     * @since 0.32.5
     */
    func discardMark() {
        mar = -1
    }

    /**
     * The Function is checkBounds
     *
     * @param off of Int64
     * @param len of Int64
     * @param size of Int64
     *
     * @since 0.32.5
     */
    func checkBounds(off: Int64, len: Int64, size: Int64) {
        if ((off | len | (off + len) | (size - (off + len))) < 0) {
            throw IndexOutOfBoundsException()
        }
    }
}
