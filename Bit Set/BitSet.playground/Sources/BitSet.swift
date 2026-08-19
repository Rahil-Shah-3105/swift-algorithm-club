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
	print(">>> Entering indexOf(i=\(i))")
    precondition(i >= 0)
    precondition(i < size)
    let o = i / N
    let m = Word(i - o*N)
	print("indexOf(i=\(i)): m → \(m)")
	print("<<< Exiting indexOf(i=\(i))")
    return (o, 1 << m)
  }

  /* Returns a mask that has 1s for all bits that are in the last word. */
  private func lastWordMask() -> Word {
	print(">>> Entering lastWordMask()")
    let diff = words.count*N - size
    if diff > 0 {
      // Set the highest bit that's still valid.
      let mask = 1 << Word(63 - diff)
      // Subtract 1 to turn it into a mask, and add the high bit back in.
	print("lastWordMask(): mask → \(mask)")
      return (Word)(mask | (mask - 1))
    } else {
	print("<<< Exiting lastWordMask()")
      return allOnes
    }
  }

  /*
    If the size is not a multiple of N, then we have to clear out the bits
    that we're not using, or bitwise operations between two differently sized
    BitSets will go wrong.
  */
  fileprivate mutating func clearUnusedBits() {
	print(">>> Entering clearUnusedBits()")
    words[words.count - 1] &= lastWordMask()
	print("<<< Exiting clearUnusedBits()")
  }

  /* So you can write bitset[99] = ... */
  public subscript(i: Int) -> Bool {
    get { return isSet(i) }
    set { if newValue { set(i) } else { clear(i) } }
  }

  /* Sets the bit at the specified index to 1. */
  public mutating func set(_ i: Int) {
	print(">>> Entering set(i=\(i))")
    let (j, m) = indexOf(i)
    words[j] |= m
	print("<<< Exiting set(i=\(i))")
  }

  /* Sets all the bits to 1. */
  public mutating func setAll() {
	print(">>> Entering setAll()")
    for i in 0..<words.count {
      words[i] = allOnes
    }
    clearUnusedBits()
	print("<<< Exiting setAll()")
  }

  /* Sets the bit at the specified index to 0. */
  public mutating func clear(_ i: Int) {
	print(">>> Entering clear(i=\(i))")
    let (j, m) = indexOf(i)
    words[j] &= ~m
	print("<<< Exiting clear(i=\(i))")
  }

  /* Sets all the bits to 0. */
  public mutating func clearAll() {
	print(">>> Entering clearAll()")
    for i in 0..<words.count {
      words[i] = 0
    }
	print("<<< Exiting clearAll()")
  }

  /* Changes 0 into 1 and 1 into 0. Returns the new value of the bit. */
  public mutating func flip(_ i: Int) -> Bool {
	print(">>> Entering flip(i=\(i))")
    let (j, m) = indexOf(i)
    words[j] ^= m
	print("<<< Exiting flip(i=\(i))")
    return (words[j] & m) != 0
  }

  /* Determines whether the bit at the specific index is 1 (true) or 0 (false). */
  public func isSet(_ i: Int) -> Bool {
	print(">>> Entering isSet(i=\(i))")
    let (j, m) = indexOf(i)
	print("<<< Exiting isSet(i=\(i))")
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
	print(">>> Entering all1()")
    for i in 0..<words.count - 1 {
      if words[i] != allOnes { return false }
    }
	print("<<< Exiting all1()")
    return words[words.count - 1] == lastWordMask()
  }

  /* Checks if any of the bits are set. */
  public func any1() -> Bool {
	print(">>> Entering any1()")
    for x in words {
      if x != 0 { return true }
    }
	print("<<< Exiting any1()")
    return false
  }

  /* Checks if none of the bits are set. */
  public func all0() -> Bool {
	print(">>> Entering all0()")
    for x in words {
      if x != 0 { return false }
    }
	print("<<< Exiting all0()")
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
print(">>> Entering copyLargest(lhs=\(lhs),rhs=\(rhs))")
print("<<< Exiting copyLargest(lhs=\(lhs),rhs=\(rhs))")
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
    var s = ""
    var n = self
    for _ in 1...64 {
      s += ((n & 1 == 1) ? "1" : "0")
      n >>= 1
    }
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
