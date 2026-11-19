import Foundation
//: Playground - noun: a place where people can play

func ZetaAlgorithm(ptnr: String) -> [Int]? {
FileHandle.standardError.write(Data("[ERROR] >>> Entering ZetaAlgorithm(ptnr=\(ptnr))\n".utf8))
  
  let pattern = Array(ptnr)
  let patternLength: Int = pattern.count
FileHandle.standardError.write(Data("[ERROR] ZetaAlgorithm(ptnr=\(ptnr)): pattern → \(pattern)\n".utf8))
  
  guard patternLength > 0 else {
    return nil
  }
  
  var zeta: [Int] = [Int](repeating: 0, count: patternLength)
  
  var left: Int = 0
  var right: Int = 0
  var k_1: Int = 0
  var betaLength: Int = 0
  var textIndex: Int = 0
  var patternIndex: Int = 0
  
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
FileHandle.standardError.write(Data("[WARN] <<< Exiting ZetaAlgorithm(ptnr=\(ptnr))\n".utf8))
  return zeta
}

extension String {
  
  func indexesOf(ptnr: String) -> [Int]? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering indexesOf(ptnr=\(ptnr))\n".utf8))
    
    let text = Array(self)
    let pattern = Array(ptnr.characters)
    
	FileHandle.standardError.write(Data("[ERROR] indexesOf(ptnr=\(ptnr)): text → \(text)\n".utf8))
    let textLength: Int = text.count
    let patternLength: Int = pattern.count
    
    guard patternLength > 0 else {
      return nil
    }
    
    var suffixPrefix: [Int] = [Int](repeating: 0, count: patternLength)
    var textIndex: Int = 0
    var patternIndex: Int = 0
    var indexes: [Int] = [Int]()
    
    /* Pre-processing stage: computing the table for the shifts (through Z-Algorithm) */
    let zeta = ZetaAlgorithm(ptnr: ptnr)
    
	FileHandle.standardError.write(Data("[ERROR] indexesOf(ptnr=\(ptnr)): zeta → \(zeta)\n".utf8))
    for patternIndex in (1 ..< patternLength).reversed() {
      textIndex = patternIndex + zeta![patternIndex] - 1
      suffixPrefix[textIndex] = zeta![patternIndex]
    }
    
    /* Search stage: scanning the text for pattern matching */
    textIndex = 0
    patternIndex = 0
    
    while textIndex + (patternLength - patternIndex - 1) < textLength {
      
      while patternIndex < patternLength && text[textIndex] == pattern[patternIndex] {
        textIndex = textIndex + 1
        patternIndex = patternIndex + 1
      }
      
      if patternIndex == patternLength {
        indexes.append(textIndex - patternIndex)
      }
      
      if patternIndex == 0 {
        textIndex = textIndex + 1
      } else {
        patternIndex = suffixPrefix[patternIndex - 1]
      }
    }
    
    guard !indexes.isEmpty else {
      return nil
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting indexesOf(ptnr=\(ptnr))\n".utf8))
    return indexes
  }
}

/* Examples */

let dna = "ACCCGGTTTTAAAGAACCACCATAAGATATAGACAGATATAGGACAGATATAGAGACAAAACCCCATACCCCAATATTTTTTTGGGGAGAAAAACACCACAGATAGATACACAGACTACACGAGATACGACATACAGCAGCATAACGACAACAGCAGATAGACGATCATAACAGCAATCAGACCGAGCGCAGCAGCTTTTAAGCACCAGCCCCACAAAAAACGACAATFATCATCATATACAGACGACGACACGACATATCACACGACAGCATA"
dna.indexesOf(ptnr: "CATA")   // [20, 64, 130, 140, 166, 234, 255, 270]

let concert = "🎼🎹🎹🎸🎸🎻🎻🎷🎺🎤👏👏👏"
concert.indexesOf(ptnr: "🎻🎷")   // [6]
