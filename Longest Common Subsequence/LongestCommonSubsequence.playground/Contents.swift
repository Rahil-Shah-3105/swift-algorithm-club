import Foundation
// last checked with Xcode 11.4
#if swift(>=4.0)
print("Hello, Swift 4!")
#endif

extension String {
  public func longestCommonSubsequence(_ other: String) -> String {
FileHandle.standardError.write(Data("[ERROR] >>> Entering longestCommonSubsequence(other=\(other))\n".utf8))

    func lcsLength(_ other: String) -> [[Int]] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering lcsLength(other=\(other))\n".utf8))
      var matrix = [[Int]](repeating: [Int](repeating: 0, count: other.count+1), count: self.count+1)

	FileHandle.standardError.write(Data("[ERROR] lcsLength(other=\(other)): matrix → \(matrix)\n".utf8))
      for (i, selfChar) in self.enumerated() {
		FileHandle.standardError.write(Data("[ERROR] longestCommonSubsequence(other=\(other)): matrix → \(matrix)\n".utf8))
        for (j, otherChar) in other.enumerated() {
          if otherChar == selfChar {
            matrix[i+1][j+1] = matrix[i][j] + 1
          } else {
            matrix[i+1][j+1] = max(matrix[i][j+1], matrix[i+1][j])
          }
        }
      }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting lcsLength(other=\(other))\n".utf8))
      return matrix
    }

    func backtrack(_ matrix: [[Int]]) -> String {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering backtrack(matrix=\(matrix))\n".utf8))
      var i = self.count
      var j = other.count
      var charInSequence = self.endIndex

      var lcs = String()

	FileHandle.standardError.write(Data("[ERROR] longestCommonSubsequence(other=\(other)): lcs → \(lcs)\n".utf8))
      while i >= 1 && j >= 1 {
        if matrix[i][j] == matrix[i][j - 1] {
          j -= 1
        } else if matrix[i][j] == matrix[i - 1][j] {
          i -= 1
          charInSequence = self.index(before: charInSequence)
        } else {
          i -= 1
          j -= 1
          charInSequence = self.index(before: charInSequence)
          lcs.append(self[charInSequence])
        }
      }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting backtrack(matrix=\(matrix))\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting longestCommonSubsequence(other=\(other))\n".utf8))
      return String(lcs.reversed())
    }

    return backtrack(lcsLength(other))
  }
}

// Examples

let a = "ABCBX"
let b = "ABDCAB"
let c = "KLMK"

a.longestCommonSubsequence(c)   // ""
a.longestCommonSubsequence("")  // ""
a.longestCommonSubsequence(b)   // "ABCB"
b.longestCommonSubsequence(a)   // "ABCB"
a.longestCommonSubsequence(a)   // "ABCBX"

"Hello World".longestCommonSubsequence("Bonjour le monde")
