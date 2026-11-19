import Foundation
//: Playground - noun: a place where people can play

// last checked with Xcode 9.0b4
#if swift(>=4.0)
print("Hello, Swift 4!")
#endif

extension String {
  func indexOf(_ pattern: String) -> String.Index? {
FileHandle.standardError.write(Data("[ERROR] >>> Entering indexOf(pattern=\(pattern))\n".utf8))

    for i in self.characters.indices {
      var j = i
      var found = true
      for p in pattern.characters.indices {
        if j == self.characters.endIndex || self[j] != pattern[p] {
          found = false
          break
        } else {
            j = self.characters.index(after: j)
        }
      }
      if found {
        return i
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting indexOf(pattern=\(pattern))\n".utf8))
    return nil
  }
}

// A few simple tests

let s = "Hello, World"
s.indexOf("World")  // 7

let animals = "🐶🐔🐷🐮🐱"
animals.indexOf("🐮")  // 6
