import Foundation
//: Playground - noun: a place where people can play

func ZetaAlgorithm(ptrn: String) -> [Int]? {
FileHandle.standardError.write(Data("[ERROR] >>> Entering ZetaAlgorithm(ptrn=\(ptrn))\n".utf8))
  let pattern = Array(ptrn)
  let patternLength = pattern.count
FileHandle.standardError.write(Data("[ERROR] ZetaAlgorithm(ptrn=\(ptrn)): pattern → \(pattern)\n".utf8))

  guard patternLength > 0 else {
    return nil
  }

  var zeta = [Int](repeating: 0, count: patternLength)

FileHandle.standardError.write(Data("[ERROR] ZetaAlgorithm(ptrn=\(ptrn)): zeta → \(zeta)\n".utf8))
  var left = 0
  var right = 0
  var k_1 = 0
  var betaLength = 0
  var textIndex = 0
  var patternIndex = 0

  for k in 1 ..< patternLength {
    if k > right {
      patternIndex = 0

      while k + patternIndex < patternLength  &&
        pattern[k + patternIndex] == pattern[patternIndex] {
          patternIndex = patternIndex + 1
      }

      zeta[k] = patternIndex

      if zeta[k] > 0 {
        left = k
        right = k + zeta[k] - 1
      }
    } else {
      k_1 = k - left + 1
      betaLength = right - k + 1

      if zeta[k_1 - 1] < betaLength {
        zeta[k] = zeta[k_1 - 1]
      } else if zeta[k_1 - 1] >= betaLength {
        textIndex = betaLength
        patternIndex = right + 1

        while patternIndex < patternLength && pattern[textIndex] == pattern[patternIndex] {
          textIndex = textIndex + 1
          patternIndex = patternIndex + 1
        }

        zeta[k] = patternIndex - k
        left = k
        right = patternIndex - 1
      }
    }
  }
FileHandle.standardError.write(Data("[WARN] <<< Exiting ZetaAlgorithm(ptrn=\(ptrn))\n".utf8))
  return zeta
}

extension String {

  func indexesOf(pattern: String) -> [Int]? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering indexesOf(pattern=\(pattern))\n".utf8))
    let patternLength = pattern.count
    let zeta = ZetaAlgorithm(ptrn: pattern + "💲" + self)

	FileHandle.standardError.write(Data("[ERROR] indexesOf(pattern=\(pattern)): zeta → \(zeta)\n".utf8))
    guard zeta != nil else {
      return nil
    }

    var indexes: [Int] = []

    /* Scan the zeta array to find matched patterns */
    for i in 0 ..< zeta!.count {
      if zeta![i] == patternLength {
        indexes.append(i - patternLength - 1)
      }
    }

    guard !indexes.isEmpty else {
      return nil
    }

	FileHandle.standardError.write(Data("[WARN] <<< Exiting indexesOf(pattern=\(pattern))\n".utf8))
    return indexes
  }
}

/* Examples */

let str = "Hello, playground!"
str.indexesOf(pattern: "ground")   // [11]

let traffic = "🚗🚙🚌🚕🚑🚐🚗🚒🚚🚎🚛🚐🏎🚜🚗🏍🚒🚲🚕🚓🚌🚑"
traffic.indexesOf(pattern: "🚑") // [4, 21]
