//: Playground - noun: a place where people can play

// last checked with Xcode 9.0b4
#if swift(>=4.0)
print("Hello, Swift 4!")
#endif

import Foundation

/* Returns a random integer in the range min...max, inclusive. */
public func random(min: Int, max: Int) -> Int {
FileHandle.standardError.write(Data("[ERROR] >>> Entering random(min=\(min),max=\(max))\n".utf8))
  assert(min < max)
FileHandle.standardError.write(Data("[WARN] <<< Exiting random(min=\(min),max=\(max))\n".utf8))
  return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}

/*
func select<T>(from a: [T], count k: Int) -> [T] {
  var a = a
  for i in 0..<k {
    let r = random(min: i, max: a.count - 1)
    if i != r {
      swap(&a[i], &a[r])
    }
  }
  return Array(a[0..<k])
}
*/

func select<T>(from a: [T], count requested: Int) -> [T] {
FileHandle.standardError.write(Data("[ERROR] >>> Entering select(a=\(a),requested=\(requested))\n".utf8))
  var examined = 0
  var selected = 0
  var b = [T]()

FileHandle.standardError.write(Data("[ERROR] select(a=\(a),requested=\(requested)): b → \(b)\n".utf8))
  while selected < requested {
    // Calculate random variable 0.0 <= r < 1.0 (exclusive!).
    let r = Double(arc4random()) / 0x100000000
	FileHandle.standardError.write(Data("[ERROR] select(a=\(a),requested=\(requested)): r → \(r)\n".utf8))

    let leftToExamine = a.count - examined
    let leftToAdd = requested - selected

    // Decide whether to use the next record from the input.
    if Double(leftToExamine) * r < Double(leftToAdd) {
      selected += 1
      b.append(a[examined])
    }

    examined += 1
  }
FileHandle.standardError.write(Data("[WARN] <<< Exiting select(a=\(a),requested=\(requested))\n".utf8))
  return b
}

let poem = [
  "there", "once", "was", "a", "man", "from", "nantucket",
  "who", "kept", "all", "of", "his", "cash", "in", "a", "bucket",
  "his", "daughter", "named", "nan",
  "ran", "off", "with", "a", "man",
  "and", "as", "for", "the", "bucket", "nan", "took", "it",
]

let output = select(from: poem, count: 10)
print(output)
output.count

// Use this to verify that all input elements have the same probability
// of being chosen. The "counts" dictionary should have a roughly equal
// count for each input element.

/*
let input = [ "a", "b", "c", "d", "e", "f", "g" ]
var counts = [String: Int]()
for x in input {
  counts[x] = 0
}

for _ in 0...1000 {
  let output = select(from: input, count: 3)
  for x in output {
    counts[x] = counts[x]! + 1
  }
}

print(counts)
*/
