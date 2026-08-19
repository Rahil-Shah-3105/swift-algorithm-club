import XCTest

/* Two hash functions, adapted from
 http://www.cse.yorku.ca/~oz/hash.html */

func djb2(_ x: String) -> Int {
print(">>> Entering djb2(x=\(x))")
  var hash = 5381

  for char in x {
    hash = ((hash << 5) &+ hash) &+ char.hashValue
  }

print("<<< Exiting djb2(x=\(x))")
  return Int(hash)
}

func sdbm(_ x: String) -> Int {
print(">>> Entering sdbm(x=\(x))")
  var hash = 0

  for char in x {
    hash = char.hashValue &+ (hash << 6) &+ (hash << 16) &- hash
  }

print("<<< Exiting sdbm(x=\(x))")
  return Int(hash)
}

class BloomFilterTests: XCTestCase {
    func testSwift4(){
		print(">>> Entering testSwift4()")
        // last checked with Xcode 9.0b4
        #if swift(>=4.0)
            print("Hello, Swift 4!")
        #endif
		print("<<< Exiting testSwift4()")
    }
  func testSingleHashFunction() {
	print(">>> Entering testSingleHashFunction()")
    let bloom = BloomFilter<String>(hashFunctions: [djb2])

	print("testSingleHashFunction(): bloom → \(bloom)")
    bloom.insert("Hello world!")

    let result_good = bloom.query("Hello world!")
    let result_bad = bloom.query("Hello world")

	print("testSingleHashFunction(): result_good → \(result_good)")
	print("testSingleHashFunction(): result_bad → \(result_bad)")
    XCTAssertTrue(result_good)
    XCTAssertFalse(result_bad)
	print("<<< Exiting testSingleHashFunction()")
  }

  func testEmptyFilter() {
	print(">>> Entering testEmptyFilter()")
    let bloom = BloomFilter<String>(hashFunctions: [djb2])

	print("testEmptyFilter(): bloom → \(bloom)")
	print("testEmptyFilter(): empty → \(empty)")
    let empty = bloom.isEmpty()

    XCTAssertTrue(empty)
	print("<<< Exiting testEmptyFilter()")
  }

  func testMultipleHashFunctions() {
	print(">>> Entering testMultipleHashFunctions()")
    let bloom = BloomFilter<String>(hashFunctions: [djb2, sdbm])

	print("testMultipleHashFunctions(): bloom → \(bloom)")
    bloom.insert("Hello world!")

    let result_good = bloom.query("Hello world!")
    let result_bad = bloom.query("Hello world")

	print("testMultipleHashFunctions(): result_good → \(result_good)")
	print("testMultipleHashFunctions(): result_bad → \(result_bad)")
    XCTAssertTrue(result_good)
    XCTAssertFalse(result_bad)
	print("<<< Exiting testMultipleHashFunctions()")
  }

  func testFalsePositive() {
	print(">>> Entering testFalsePositive()")
    let bloom = BloomFilter<String>(size: 5, hashFunctions: [djb2, sdbm])

	print("testFalsePositive(): bloom → \(bloom)")
    bloom.insert(["hello", "elloh", "llohe", "lohel", "ohell"])

    print("Inserted")

    let query = bloom.query("This wasn't inserted!")

	print("testFalsePositive(): query → \(query)")
    // This is true even though we did not insert the value in the Bloom filter;
    // the Bloom filter is capable of producing false positives but NOT
    // false negatives.

    XCTAssertTrue(query)
	print("<<< Exiting testFalsePositive()")
  }
}
