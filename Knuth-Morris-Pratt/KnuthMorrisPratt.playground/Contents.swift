//: Playground - noun: a place where people can play

func ZetaAlgorithm(ptnr: String) -> [Int]? {
print(">>> Entering ZetaAlgorithm(ptnr=\(ptnr))")
  
  let pattern = Array(ptnr)
  let patternLength: Int = pattern.count
print("ZetaAlgorithm(ptnr=\(ptnr)): pattern → \(pattern)")
  
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
	print("ZetaAlgorithm(ptnr=\(ptnr)): patternIndex → \(patternIndex)")
      
      while k + patternIndex < patternLength  &&
        pattern[k + patternIndex] == pattern[patternIndex] {
          patternIndex = patternIndex + 1
      }
      
      zeta[k] = patternIndex
      
      if zeta[k] > 0 {
        left = k
		print("ZetaAlgorithm(ptnr=\(ptnr)): left → \(left)")
		print("ZetaAlgorithm(ptnr=\(ptnr)): right → \(right)")
        right = k + zeta[k] - 1
      }
    } else {
      k_1 = k - left + 1
	print("ZetaAlgorithm(ptnr=\(ptnr)): k_1 → \(k_1)")
	print("ZetaAlgorithm(ptnr=\(ptnr)): betaLength → \(betaLength)")
      betaLength = right - k + 1
      
      if zeta[k_1 - 1] < betaLength {
        zeta[k] = zeta[k_1 - 1]
      } else if zeta[k_1 - 1] >= betaLength {
        textIndex = betaLength
		print("ZetaAlgorithm(ptnr=\(ptnr)): textIndex → \(textIndex)")
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
print("<<< Exiting ZetaAlgorithm(ptnr=\(ptnr))")
  return zeta
}

extension String {
  
  func indexesOf(ptnr: String) -> [Int]? {
	print(">>> Entering indexesOf(ptnr=\(ptnr))")
    
    let text = Array(self)
    let pattern = Array(ptnr.characters)
    
	print("indexesOf(ptnr=\(ptnr)): text → \(text)")
	print("indexesOf(ptnr=\(ptnr)): pattern → \(pattern)")
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
    
	print("indexesOf(ptnr=\(ptnr)): zeta → \(zeta)")
    for patternIndex in (1 ..< patternLength).reversed() {
      textIndex = patternIndex + zeta![patternIndex] - 1
	print("indexesOf(ptnr=\(ptnr)): textIndex → \(textIndex)")
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
	print("<<< Exiting indexesOf(ptnr=\(ptnr))")
      return nil
    }
    return indexes
  }
}

/* Examples */

let dna = "ACCCGGTTTTAAAGAACCACCATAAGATATAGACAGATATAGGACAGATATAGAGACAAAACCCCATACCCCAATATTTTTTTGGGGAGAAAAACACCACAGATAGATACACAGACTACACGAGATACGACATACAGCAGCATAACGACAACAGCAGATAGACGATCATAACAGCAATCAGACCGAGCGCAGCAGCTTTTAAGCACCAGCCCCACAAAAAACGACAATFATCATCATATACAGACGACGACACGACATATCACACGACAGCATA"
dna.indexesOf(ptnr: "CATA")   // [20, 64, 130, 140, 166, 234, 255, 270]

let concert = "🎼🎹🎹🎸🎸🎻🎻🎷🎺🎤👏👏👏"
concert.indexesOf(ptnr: "🎻🎷")   // [6]
