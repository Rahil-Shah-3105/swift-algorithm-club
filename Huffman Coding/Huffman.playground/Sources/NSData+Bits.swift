import Foundation

/* Helper class for writing bits to an NSData object. */
public class BitWriter {
  public var data = NSMutableData()
  var outByte: UInt8 = 0
  var outCount = 0

  public func writeBit(bit: Bool) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering writeBit(bit=\(bit))\n".utf8))
    if outCount == 8 {
      data.append(&outByte, length: 1)
      outCount = 0
    }
    outByte = (outByte << 1) | (bit ? 1 : 0)
    outCount += 1
	FileHandle.standardError.write(Data("[DEBUG] writeBit(bit=\(bit)): outByte → \(outByte)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting writeBit(bit=\(bit))\n".utf8))
  }

  public func flush() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering flush()\n".utf8))
    if outCount > 0 {
      if outCount < 8 {
        let diff = UInt8(8 - outCount)
        outByte <<= diff
		FileHandle.standardError.write(Data("[ERROR] flush(): diff → \(diff)\n".utf8))
      }
      data.append(&outByte, length: 1)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting flush()\n".utf8))
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering readBit()\n".utf8))
    if inCount == 8 {
      inByte = ptr.pointee    // load the next byte
	FileHandle.standardError.write(Data("[DEBUG] readBit(): inByte → \(inByte)\n".utf8))
      inCount = 0
      ptr = ptr.successor()
    }
	FileHandle.standardError.write(Data("[DEBUG] readBit(): ptr → \(ptr)\n".utf8))
    let bit = inByte & 0x80  // read the next bit
    inByte <<= 1
    inCount += 1
	FileHandle.standardError.write(Data("[WARN] <<< Exiting readBit()\n".utf8))
    return bit == 0 ? false : true
  }
}
