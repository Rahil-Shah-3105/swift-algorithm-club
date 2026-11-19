import Foundation
/*
  A fixed-size sequence of n bits. Bits have indices 0 to n-1.
*/
public struct BitSet {
  /* How many bits this object can hold. */
  private(set) public var size: Int

  /*
    We store the bits in a list of unsigned 64-bit integers.
    The first entry, `words[0]`, is the least significant word.
  */
  fileprivate let N = 64
  public typealias Word = UInt64
  fileprivate(set) public var words: [Word]

  private let allOnes = ~Word()

  /* Creates a bit set that can hold `size` bits. All bits are initially 0. */
  public init(size: Int) {
    precondition(size > 0)
    self.size = size

    // Round up the count to the next multiple of 64.
    let n = (size + (N-1)) / N
    words = [Word](repeating: 0, count: n)
  }

  /* Converts a bit index into an array index and a mask inside the word. */
  private func indexOf(_ i: Int) -> (Int, Word) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering indexOf(i=\(i))\n".utf8))
    precondition(i >= 0)
    precondition(i < size)
    let o = i / N
    let m = Word(i - o*N)
	FileHandle.standardError.write(Data("[ERROR] indexOf(i=\(i)): m → \(m)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting indexOf(i=\(i))\n".utf8))
    return (o, 1 << m)
  }

  /* Returns a mask that has 1s for all bits that are in the last word. */
  private func lastWordMask() -> Word {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering lastWordMask()\n".utf8))
    let diff = words.count*N - size
    if diff > 0 {
      // Set the highest bit that's still valid.
      let mask = 1 << Word(63 - diff)
      // Subtract 1 to turn it into a mask, and add the high bit back in.
	FileHandle.standardError.write(Data("[ERROR] lastWordMask(): mask → \(mask)\n".utf8))
      return (Word)(mask | (mask - 1))
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting lastWordMask()\n".utf8))
      return allOnes
    }
  }

  /*
    If the size is not a multiple of N, then we have to clear out the bits
    that we're not using, or bitwise operations between two differently sized
    BitSets will go wrong.
  */
  fileprivate mutating func clearUnusedBits() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering clearUnusedBits()\n".utf8))
    words[words.count - 1] &= lastWordMask()
	FileHandle.standardError.write(Data("[WARN] <<< Exiting clearUnusedBits()\n".utf8))
  }

  /* So you can write bitset[99] = ... */
  public subscript(i: Int) -> Bool {
    get { return isSet(i) }
    set { if newValue { set(i) } else { clear(i) } }
  }

  /* Sets the bit at the specified index to 1. */
  public mutating func set(_ i: Int) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering set(i=\(i))\n".utf8))
    let (j, m) = indexOf(i)
    words[j] |= m
	FileHandle.standardError.write(Data("[WARN] <<< Exiting set(i=\(i))\n".utf8))
  }

  /* Sets all the bits to 1. */
  public mutating func setAll() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering setAll()\n".utf8))
    for i in 0..<words.count {
      words[i] = allOnes
    }
    clearUnusedBits()
	FileHandle.standardError.write(Data("[WARN] <<< Exiting setAll()\n".utf8))
  }

  /* Sets the bit at the specified index to 0. */
  public mutating func clear(_ i: Int) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering clear(i=\(i))\n".utf8))
    let (j, m) = indexOf(i)
    words[j] &= ~m
	FileHandle.standardError.write(Data("[WARN] <<< Exiting clear(i=\(i))\n".utf8))
  }

  /* Sets all the bits to 0. */
  public mutating func clearAll() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering clearAll()\n".utf8))
    for i in 0..<words.count {
      words[i] = 0
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting clearAll()\n".utf8))
  }

  /* Changes 0 into 1 and 1 into 0. Returns the new value of the bit. */
  public mutating func flip(_ i: Int) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering flip(i=\(i))\n".utf8))
    let (j, m) = indexOf(i)
    words[j] ^= m
	FileHandle.standardError.write(Data("[WARN] <<< Exiting flip(i=\(i))\n".utf8))
    return (words[j] & m) != 0
  }

  /* Determines whether the bit at the specific index is 1 (true) or 0 (false). */
  public func isSet(_ i: Int) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering isSet(i=\(i))\n".utf8))
    let (j, m) = indexOf(i)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting isSet(i=\(i))\n".utf8))
    return (words[j] & m) != 0
  }

  /*
    Returns the number of bits that are 1. Time complexity is O(s) where s is
    the number of 1-bits.
  */
  public var cardinality: Int {
    var count = 0
    for var x in words {
      while x != 0 {
        let y = x & ~(x - 1)  // find lowest 1-bit
        x = x ^ y             // and erase it
        count += 1
      }
    }
    return count
  }

  /* Checks if all the bits are set. */
  public func all1() -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering all1()\n".utf8))
    for i in 0..<words.count - 1 {
      if words[i] != allOnes { return false }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting all1()\n".utf8))
    return words[words.count - 1] == lastWordMask()
  }

  /* Checks if any of the bits are set. */
  public func any1() -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering any1()\n".utf8))
    for x in words {
      if x != 0 { return true }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting any1()\n".utf8))
    return false
  }

  /* Checks if none of the bits are set. */
  public func all0() -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering all0()\n".utf8))
    for x in words {
      if x != 0 { return false }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting all0()\n".utf8))
    return true
  }
}

// MARK: - Equality

extension BitSet: Equatable {
}

public func == (lhs: BitSet, rhs: BitSet) -> Bool {
  return lhs.words == rhs.words
}

// MARK: - Hashing

extension BitSet: Hashable {
  /* Based on the hashing code from Java's BitSet. */
  public var hashValue: Int {
    var h = Word(1234)
    for i in stride(from: words.count, to: 0, by: -1) {
      h ^= words[i - 1] &* Word(i)
    }
    return Int((h >> 32) ^ h)
  }
}

// MARK: - Bitwise operations

extension BitSet {
  public static var allZeros: BitSet {
    return BitSet(size: 64)
  }
}

private func copyLargest(_ lhs: BitSet, _ rhs: BitSet) -> BitSet {
FileHandle.standardError.write(Data("[ERROR] >>> Entering copyLargest(lhs=\(lhs),rhs=\(rhs))\n".utf8))
  FileHandle.standardError.write(Data("[WARN] <<< Exiting copyLargest(lhs=\(lhs),rhs=\(rhs))\n".utf8))
  return (lhs.words.count > rhs.words.count) ? lhs : rhs
}

/*
  Note: In all of these bitwise operations, lhs and rhs are allowed to have a
  different number of bits. The new BitSet always has the larger size.
  The extra bits that get added to the smaller BitSet are considered to be 0.
  That will strip off the higher bits from the larger BitSet when doing &.
*/

public func & (lhs: BitSet, rhs: BitSet) -> BitSet {
  let m = max(lhs.size, rhs.size)
  var out = BitSet(size: m)
  let n = min(lhs.words.count, rhs.words.count)
  for i in 0..<n {
    out.words[i] = lhs.words[i] & rhs.words[i]
  }
  return out
}

public func | (lhs: BitSet, rhs: BitSet) -> BitSet {
  var out = copyLargest(lhs, rhs)
  let n = min(lhs.words.count, rhs.words.count)
  for i in 0..<n {
    out.words[i] = lhs.words[i] | rhs.words[i]
  }
  return out
}

public func ^ (lhs: BitSet, rhs: BitSet) -> BitSet {
  var out = copyLargest(lhs, rhs)
  let n = min(lhs.words.count, rhs.words.count)
  for i in 0..<n {
    out.words[i] = lhs.words[i] ^ rhs.words[i]
  }
  return out
}

prefix public func ~ (rhs: BitSet) -> BitSet {
  var out = BitSet(size: rhs.size)
  for i in 0..<rhs.words.count {
    out.words[i] = ~rhs.words[i]
  }
  out.clearUnusedBits()
  return out
}

// MARK: - Bit shift operations

/*
 Note: For bitshift operations, the assumption is that any bits that are
 shifted off the end of the end of the declared size are not still set.
 In other words, we are maintaining the original number of bits.
 */

public func << (lhs: BitSet, numBitsLeft: Int) -> BitSet {
    var out = lhs
    let offset = numBitsLeft / lhs.N
    let shift = numBitsLeft % lhs.N
    for i in 0..<lhs.words.count {
        out.words[i] = 0
        if (i - offset >= 0) {
            out.words[i] = lhs.words[i - offset] << shift
        }
        if (i - offset - 1 >= 0) {
            out.words[i] |= lhs.words[i - offset - 1] >> (lhs.N - shift)
        }
    }
    
    out.clearUnusedBits()
    return out
}

public func >> (lhs: BitSet, numBitsRight: Int) -> BitSet {
    var out = lhs
    let offset = numBitsRight / lhs.N
    let shift = numBitsRight % lhs.N
    for i in 0..<lhs.words.count {
        out.words[i] = 0
        if (i + offset < lhs.words.count) {
            out.words[i] = lhs.words[i + offset] >> shift
        }
        if (i + offset + 1 < lhs.words.count) {
            out.words[i] |= lhs.words[i + offset + 1] << (lhs.N - shift)
        }
    }
    
    out.clearUnusedBits()
    return out
}

// MARK: - Debugging

extension UInt64 {
  /* Writes the bits in little-endian order, LSB first. */
  public func bitsToString() -> String {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering bitsToString()\n".utf8))
    var s = ""
    var n = self
	FileHandle.standardError.write(Data("[ERROR] bitsToString(): s → \(s)\n".utf8))
    for _ in 1...64 {
      s += ((n & 1 == 1) ? "1" : "0")
      n >>= 1
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting bitsToString()\n".utf8))
    return s
  }
}

extension BitSet: CustomStringConvertible {
  public var description: String {
    var s = ""
    for x in words {
      s += x.bitsToString() + " "
    }
    return s
  }
}
