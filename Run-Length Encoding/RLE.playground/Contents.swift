//: Playground - noun: a place where people can play

import Foundation

let originalString = "aaaaabbbcdeeeeeeef"
let utf8 = originalString.data(using: String.Encoding.utf8)!
let compressed = utf8.compressRLE()

let decompressed = compressed.decompressRLE()
let restoredString = String(data: decompressed, encoding: String.Encoding.utf8)
originalString == restoredString

func encodeAndDecode(_ bytes: [UInt8]) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering encodeAndDecode(bytes=\(bytes))\n".utf8))
    var bytes = bytes

    var data1 = Data(bytes: &bytes, count: bytes.count)
    print("data1 is \(data1.count) bytes")

    var rleData = data1.compressRLE()
    print("encoded data is \(rleData.count) bytes")

    var data2 = rleData.decompressRLE()
    print("data2 is \(data2.count) bytes")

	FileHandle.standardError.write(Data("[WARN] <<< Exiting encodeAndDecode(bytes=\(bytes))\n".utf8))
    return data1 == data2
}

func testEmpty() -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testEmpty()\n".utf8))
    let bytes: [UInt8] = []
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testEmpty()\n".utf8))
    return encodeAndDecode(bytes)
}

func testOneByteWithLowValue() -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testOneByteWithLowValue()\n".utf8))
    let bytes: [UInt8] = [0x80]
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testOneByteWithLowValue()\n".utf8))
    return encodeAndDecode(bytes)
}

func testOneByteWithHighValue() -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testOneByteWithHighValue()\n".utf8))
    let bytes: [UInt8] = [0xD0]
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testOneByteWithHighValue()\n".utf8))
    return encodeAndDecode(bytes)
}

func testSimpleCases() -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testSimpleCases()\n".utf8))
    let bytes: [UInt8] = [
        0x00,
        0x20, 0x20, 0x20, 0x20, 0x20,
        0x30,
        0x00, 0x00,
        0xC0,
        0xC1,
        0xC0, 0xC0, 0xC0,
        0xFF, 0xFF, 0xFF, 0xFF
    ]
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testSimpleCases()\n".utf8))
    return encodeAndDecode(bytes)
}

func testBufferWithoutSpans() -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testBufferWithoutSpans()\n".utf8))
    // There is nothing that can be encoded in this buffer, so the encoded
    // data ends up being longer.
    var bytes: [UInt8] = []
    for i in 0..<1024 {
        bytes.append(UInt8(i % 256))
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testBufferWithoutSpans()\n".utf8))
    return encodeAndDecode(bytes)
}

func testBufferWithSpans(_ spanSize: Int) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testBufferWithSpans(spanSize=\(spanSize))\n".utf8))
    print("span size \(spanSize)")

    let length = spanSize * 32
    var bytes: [UInt8] = Array<UInt8>(repeating: 0, count: length)

    for t in stride(from: 0, to: length, by: spanSize) {
        for i in 0..<spanSize {
            bytes[t + i] = UInt8(t % 256)
        }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testBufferWithSpans(spanSize=\(spanSize))\n".utf8))
    return encodeAndDecode(bytes)
}

func testRandomByte() -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testRandomByte()\n".utf8))
    let length = 1 + Int(arc4random_uniform(2048))
    var bytes: [UInt8] = []
	FileHandle.standardError.write(Data("[ERROR] testRandomByte(): length → \(length)\n".utf8))
    for _ in 0..<length {
        bytes.append(UInt8(arc4random() % 256))
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testRandomByte()\n".utf8))
    return encodeAndDecode(bytes)
}

func runTests() -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering runTests()\n".utf8))
    var tests: [Bool] = [
        testEmpty(),
        testOneByteWithLowValue(),
        testOneByteWithHighValue(),
        testSimpleCases(),
        testBufferWithoutSpans(),
        testBufferWithSpans(4),
        testBufferWithSpans(63),
        testBufferWithSpans(64),
        testBufferWithSpans(65),
        testBufferWithSpans(66),
        testBufferWithSpans(80)
    ]
    for _ in 0..<10 {
        let result = testRandomByte()
        tests.append(result)
		FileHandle.standardError.write(Data("[ERROR] runTests(): result → \(result)\n".utf8))
    }
    var result = true
    for bool in tests {
        result = result && bool
    }

	FileHandle.standardError.write(Data("[WARN] <<< Exiting runTests()\n".utf8))
    return result
}

runTests()
