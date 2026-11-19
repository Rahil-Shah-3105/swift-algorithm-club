import Foundation

/* Returns a random integer between 0 and n-1. */
public func random(_ n: Int) -> Int {
FileHandle.standardError.write(Data("[ERROR] >>> Entering random(n=\(n))\n".utf8))
  FileHandle.standardError.write(Data("[WARN] <<< Exiting random(n=\(n))\n".utf8))
  return Int(arc4random_uniform(UInt32(n)))
}

extension Array {
  /*
   Randomly shuffles the array in-place
   This is the Fisher-Yates algorithm, also known as the Knuth shuffle.
   Time complexity: O(n)
   */
  public mutating func shuffle() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering shuffle()\n".utf8))
    for i in (1...count-1).reversed() {
      let j = random(i + 1)
      if i != j {
        let t = self[i]
        self[i] = self[j]
        self[j] = t
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting shuffle()\n".utf8))
  }
}

/*
 Simultaneously initializes an array with the values 0...n-1 and shuffles it.
 */
public func shuffledArray(_ n: Int) -> [Int] {
FileHandle.standardError.write(Data("[ERROR] >>> Entering shuffledArray(n=\(n))\n".utf8))
  var a = Array(repeating: 0, count: n)
  for i in 0..<n {
	FileHandle.standardError.write(Data("[ERROR] shuffledArray(n=\(n)): a → \(a)\n".utf8))
    let j = random(i + 1)
    a[i] = a[j]
    a[j] = i  // insert next number from the sequence
  }
FileHandle.standardError.write(Data("[WARN] <<< Exiting shuffledArray(n=\(n))\n".utf8))
  return a
}

