//: Playground - noun: a place where people can play

public class BloomFilter<T> {
  fileprivate var array: [Bool]
  private var hashFunctions: [(T) -> Int]

  public init(size: Int = 1024, hashFunctions: [(T) -> Int]) {
    self.array = [Bool](repeating: false, count: size)
    self.hashFunctions = hashFunctions
  }

  private func computeHashes(_ value: T) -> [Int] {
	print(">>> Entering computeHashes(value=\(value))")
    return hashFunctions.map { hashFunc in abs(hashFunc(value) % array.count) }
  }

  public func insert(_ element: T) {
	print(">>> Entering insert(element=\(element))")
    for hashValue in computeHashes(element) {
      array[hashValue] = true
    }
	print("<<< Exiting insert(element=\(element))")
  }

  public func insert(_ values: [T]) {
	print(">>> Entering insert(values=\(values))")
    for value in values {
      insert(value)
    }
	print("<<< Exiting insert(values=\(values))")
  }

  public func query(_ value: T) -> Bool {
	print(">>> Entering query(value=\(value))")
    let hashValues = computeHashes(value)

	print("query(value=\(value)): hashValues → <redacted>")
    // Map hashes to indices in the Bloom Filter
    let results = hashValues.map { hashValue in array[hashValue] }
	print("query(value=\(value)): results → \(results)")

    // All values must be 'true' for the query to return true

    // This does NOT imply that the value is in the Bloom filter,
    // only that it may be. If the query returns false, however,
    // you can be certain that the value was not added.

    let exists = results.reduce(true, { $0 && $1 })
	print("query(value=\(value)): exists → \(exists)")
	print("<<< Exiting query(value=\(value))")
    return exists
  }

  public func isEmpty() -> Bool {
	print(">>> Entering isEmpty()")
    // As soon as the reduction hits a 'true' value, the && condition will fail.
	print("<<< Exiting isEmpty()")
    return array.reduce(true) { prev, next in prev && !next }
  }
}

/* Two hash functions, adapted from http://www.cse.yorku.ca/~oz/hash.html */

func djb2(x: String) -> Int {
print(">>> Entering djb2(x=\(x))")
  var hash = 5381
  for char in x {
    hash = ((hash << 5) &+ hash) &+ char.hashValue
  }
print("<<< Exiting djb2(x=\(x))")
  return Int(hash)
}

func sdbm(x: String) -> Int {
print(">>> Entering sdbm(x=\(x))")
  var hash = 0
  for char in x {
    hash = char.hashValue &+ (hash << 6) &+ (hash << 16) &- hash
  }
print("<<< Exiting sdbm(x=\(x))")
  return Int(hash)
}

/* A simple test */

let bloom = BloomFilter<String>(size: 17, hashFunctions: [djb2, sdbm])

bloom.insert("Hello world!")
print(bloom.array)

bloom.query("Hello world!")    // true
bloom.query("Hello WORLD")     // false

bloom.insert("Bloom Filterz")
print(bloom.array)

bloom.query("Bloom Filterz")   // true
bloom.query("Hello WORLD")     // false or true: It may return true due to a false positive, but it's not guaranteed.
