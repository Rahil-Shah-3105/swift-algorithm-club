import Foundation
public class BloomFilter<T> {
  private var array: [Bool]
  private var hashFunctions: [(T) -> Int]

  public init(size: Int = 1024, hashFunctions: [(T) -> Int]) {
    self.array = [Bool](repeating: false, count: size)
    self.hashFunctions = hashFunctions
  }

  private func computeHashes(_ value: T) -> [Int] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering computeHashes(value=<redacted>)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting computeHashes(value=<redacted>)\n".utf8))
    return hashFunctions.map { hashFunc in abs(hashFunc(value) % array.count) }
  }

  public func insert(_ element: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(element=\(element))\n".utf8))
    for hashValue in computeHashes(element) {
      array[hashValue] = true
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(element=\(element))\n".utf8))
  }

  public func insert(_ values: [T]) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(values=\(values))\n".utf8))
    for value in values {
      insert(value)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(values=\(values))\n".utf8))
  }

  public func query(_ value: T) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering query(value=\(value))\n".utf8))
    let hashValues = computeHashes(value)

	FileHandle.standardError.write(Data("[ERROR] query(value=\(value)): hashValues → <redacted>\n".utf8))
    // Map hashes to indices in the Bloom Filter
    let results = hashValues.map { hashValue in array[hashValue] }
	FileHandle.standardError.write(Data("[ERROR] query(value=\(value)): results → \(results)\n".utf8))

    // All values must be 'true' for the query to return true

    // This does NOT imply that the value is in the Bloom filter,
    // only that it may be. If the query returns false, however,
    // you can be certain that the value was not added.

    let exists = results.reduce(true, { $0 && $1 })
	FileHandle.standardError.write(Data("[ERROR] query(value=\(value)): exists → \(exists)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting query(value=\(value))\n".utf8))
    return exists
  }

  public func isEmpty() -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering isEmpty()\n".utf8))
    // As soon as the reduction hits a 'true' value, the && condition will fail.
	FileHandle.standardError.write(Data("[WARN] <<< Exiting isEmpty()\n".utf8))
    return array.reduce(true) { prev, next in prev && !next }
  }
}
