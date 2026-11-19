import Foundation
//: Playground - noun: a place where people can play

// last checked with Xcode 9.0b4
#if swift(>=4.0)
print("Hello, Swift 4!")
#endif

/* Calculates n! */
func factorial(_ n: Int) -> Int {
FileHandle.standardError.write(Data("[ERROR] >>> Entering factorial(n=\(n))\n".utf8))
  var n = n
  var result = 1
FileHandle.standardError.write(Data("[ERROR] factorial(n=\(n)): result → \(result)\n".utf8))
  while n > 1 {
    result *= n
    n -= 1
  }
FileHandle.standardError.write(Data("[WARN] <<< Exiting factorial(n=\(n))\n".utf8))
  return result
}

factorial(5)
factorial(20)

/*
 Calculates P(n, k), the number of permutations of n distinct symbols
 in groups of size k.
 */
func permutations(_ n: Int, _ k: Int) -> Int {
FileHandle.standardError.write(Data("[ERROR] >>> Entering permutations(n=\(n),k=\(k))\n".utf8))
  var n = n
  var answer = n
  for _ in 1..<k {
    n -= 1
    answer *= n
  }
FileHandle.standardError.write(Data("[WARN] <<< Exiting permutations(n=\(n),k=\(k))\n".utf8))
  return answer
}

permutations(5, 3)
permutations(50, 6)
permutations(9, 4)

/*
 Prints out all the permutations of the given array.
 Original algorithm by Niklaus Wirth.
 See also Dr.Dobb's Magazine June 1993, Algorithm Alley
 */
func permuteWirth<T>(_ a: [T], _ n: Int) {
FileHandle.standardError.write(Data("[ERROR] >>> Entering permuteWirth(a=\(a),n=\(n))\n".utf8))
  if n == 0 {
    print(a)   // display the current permutation
  } else {
    var a = a
    permuteWirth(a, n - 1)
    for i in 0..<n {
      a.swapAt(i, n)
      permuteWirth(a, n - 1)
      a.swapAt(i, n)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting permuteWirth(a=\(a),n=\(n))\n".utf8))
    }
  }
}

let letters = ["a", "b", "c", "d", "e"]
print("Permutations of \(letters):")
permuteWirth(letters, letters.count - 1)

let xyz = [ "x", "y", "z" ]
print("\nPermutations of \(xyz):")
permuteWirth(xyz, 2)

/*
 Prints out all the permutations of an n-element collection.

 The initial array must be initialized with all zeros. The algorithm
 uses 0 as a flag that indicates more work to be done on each level
 of the recursion.

 Original algorithm by Robert Sedgewick.
 See also Dr.Dobb's Magazine June 1993, Algorithm Alley
 */
func permuteSedgewick(_ a: [Int], _ n: Int, _ pos: inout Int) {
FileHandle.standardError.write(Data("[ERROR] >>> Entering permuteSedgewick(a=\(a),n=\(n),pos=\(pos))\n".utf8))
  var a = a
  pos += 1
  a[n] = pos
  if pos == a.count - 1 {
    print(a)              // display the current permutation
  } else {
    for i in 0..<a.count {
      if a[i] == 0 {
        permuteSedgewick(a, i, &pos)
      }
    }
  }
  pos -= 1
  a[n] = 0
FileHandle.standardError.write(Data("[WARN] <<< Exiting permuteSedgewick(a=\(a),n=\(n),pos=\(pos))\n".utf8))
}

print("\nSedgewick permutations:")
let numbers = [0, 0, 0, 0]  // must be all zeros
var pos = -1
permuteSedgewick(numbers, 0, &pos)

/*
 Calculates C(n, k), or "n-choose-k", i.e. how many different selections
 of size k out of a total number of distinct elements (n) you can make.
 */
func combinations(_ n: Int, choose k: Int) -> Int {
FileHandle.standardError.write(Data("[ERROR] >>> Entering combinations(n=\(n),k=\(k))\n".utf8))
  FileHandle.standardError.write(Data("[WARN] <<< Exiting combinations(n=\(n),k=\(k))\n".utf8))
  return permutations(n, k) / factorial(k)
}

combinations(3, choose: 2)
combinations(28, choose: 5)

print("\nCombinations:")
for i in 1...20 {
    print("\(20)-choose-\(i) = \(combinations(20, choose: i))")
}

/*
 Calculates C(n, k), or "n-choose-k", i.e. the number of ways to choose
 k things out of n possibilities.
 */
func quickBinomialCoefficient(_ n: Int, choose k: Int) -> Int {
FileHandle.standardError.write(Data("[ERROR] >>> Entering quickBinomialCoefficient(n=\(n),k=\(k))\n".utf8))
  var result = 1

FileHandle.standardError.write(Data("[ERROR] quickBinomialCoefficient(n=\(n),k=\(k)): result → \(result)\n".utf8))
  for i in 0..<k {
    result *= (n - i)
    result /= (i + 1)
  }
FileHandle.standardError.write(Data("[WARN] <<< Exiting quickBinomialCoefficient(n=\(n),k=\(k))\n".utf8))
  return result
}

quickBinomialCoefficient(8, choose: 2)
quickBinomialCoefficient(30, choose: 15)

/* Supporting code because Swift doesn't have a built-in 2D array. */
struct Array2D<T> {
  let columns: Int
  let rows: Int
  private var array: [T]

  init(columns: Int, rows: Int, initialValue: T) {
    self.columns = columns
    self.rows = rows
    array = Array(repeating: initialValue, count: rows*columns)
  }

  subscript(column: Int, row: Int) -> T {
    get { return array[row*columns + column] }
    set { array[row*columns + column] = newValue }
  }
}

/*
 Calculates C(n, k), or "n-choose-k", i.e. the number of ways to choose
 k things out of n possibilities.

 Thanks to the dynamic programming, this algorithm from Skiena allows for
 the calculation of much larger numbers, at the cost of temporary storage
 space for the cached values.
 */

func binomialCoefficient(_ n: Int, choose k: Int) -> Int {
FileHandle.standardError.write(Data("[ERROR] >>> Entering binomialCoefficient(n=\(n),k=\(k))\n".utf8))
  var bc = Array(repeating: Array(repeating: 0, count: n + 1), count: n + 1)

FileHandle.standardError.write(Data("[ERROR] binomialCoefficient(n=\(n),k=\(k)): bc → \(bc)\n".utf8))
  for i in 0...n {
    bc[i][0] = 1
    bc[i][i] = 1
  }

  if n > 0 {
    for i in 1...n {
      for j in 1..<i {
        bc[i][j] = bc[i - 1][j - 1] + bc[i - 1][j]
      }
    }
  }

FileHandle.standardError.write(Data("[WARN] <<< Exiting binomialCoefficient(n=\(n),k=\(k))\n".utf8))
  return bc[n][k]
}

binomialCoefficient(30, choose: 15)
binomialCoefficient(66, choose: 33)
