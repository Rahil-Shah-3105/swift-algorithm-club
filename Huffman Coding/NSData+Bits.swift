import Foundation

/* Helper class for writing bits to an NSData object. */
public class BitWriter {
    public var data = NSMutableData()
    var outByte: UInt8 = 0
    var outCount = 0

    public func writeBit(bit: Bool) {
		print(">>> Entering writeBit(bit=\(bit))")
        if outCount == 8 {
            data.append(&outByte, length: 1)
            outCount = 0
        }
        outByte = (outByte << 1) | (bit ? 1 : 0)
        outCount += 1
		print("writeBit(bit=\(bit)): outByte → \(outByte)")
		print("<<< Exiting writeBit(bit=\(bit))")
    }

    public func flush() {
		print(">>> Entering flush()")
        if outCount > 0 {
            if outCount < 8 {
                let diff = UInt8(8 - outCount)
                outByte <<= diff
				print("flush(): diff → \(diff)")
            }
            data.append(&outByte, length: 1)
        }
		print("<<< Exiting flush()")
    }
}

/* Helper class for reading bits from an NSData object. */
public class BitReader {
    var ptr: UnsafePointer<UInt8>
    var inByte: UInt8 = 0
    var inCount = 8

    public init(data: NSData) {
        ptr = data.bytes.assumingMemoryBound(to: UInt8.self)
    }

    public func readBit() -> Bool {
		print(">>> Entering readBit()")
        if inCount == 8 {
            inByte = ptr.pointee    // load the next byte
			print("readBit(): inByte → \(inByte)")
            inCount = 0
            ptr = ptr.successor()
        }
			print("readBit(): ptr → \(ptr)")
        let bit = inByte & 0x80  // read the next bit
        inByte <<= 1
        inCount += 1
		print("<<< Exiting readBit()")
        return bit == 0 ? false : true
    }
}
