import Foundation

extension Array {
  /*
   Randomly shuffles the array in-place
   This is the Fisher-Yates algorithm, also known as the Knuth shuffle.
   Time complexity: O(n)
   */
  public mutating func shuffle() {
	print(">>> Entering shuffle()")
    for i in (1...count-1).reversed() {
      let j = Int.random(in: 0...i)
      if i != j {
        let t = self[i]
        self[i] = self[j]
        self[j] = t
      }
    }
	print("<<< Exiting shuffle()")
  }
}

/*
 Simultaneously initializes an array with the values 0...n-1 and shuffles it.
 */
public func shuffledArray(_ n: Int) -> [Int] {
print(">>> Entering shuffledArray(n=\(n))")
  var a = Array(repeating: 0, count: n)
  for i in 0..<n {
	print("shuffledArray(n=\(n)): a → \(a)")
    let j = Int.random(in: 0...i)
    if i != j {
      a[i] = a[j]
    }
    a[j] = i  // insert next number from the sequence
  }
print("<<< Exiting shuffledArray(n=\(n))")
  return a
}
