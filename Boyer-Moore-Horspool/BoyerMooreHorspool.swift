import Foundation
/*
  Boyer-Moore string search

  This code is based on the article "Faster String Searches" by Costas Menico
  from Dr Dobb's magazine, July 1989.
  http://www.drdobbs.com/database/faster-string-searches/184408171
*/
extension String {
    func index(of pattern: String, usingHorspoolImprovement: Bool = false) -> Index? {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering index(pattern=\(pattern),usingHorspoolImprovement=\(usingHorspoolImprovement))\n".utf8))
        // Cache the length of the search pattern because we're going to
        // use it a few times and it's expensive to calculate.
        let patternLength = pattern.count
        guard patternLength > 0, patternLength <= self.count else { return nil }
      
        // Make the skip table. This table determines how far we skip ahead
        // when a character from the pattern is found.
        var skipTable = [Character: Int]()
        for (i, c) in pattern.enumerated() {
		FileHandle.standardError.write(Data("[ERROR] index(pattern=\(pattern),usingHorspoolImprovement=\(usingHorspoolImprovement)): skipTable → \(skipTable)\n".utf8))
            skipTable[c] = patternLength - i - 1
        }

        // This points at the last character in the pattern.
        let p = pattern.index(before: pattern.endIndex)
        let lastChar = pattern[p]
		FileHandle.standardError.write(Data("[ERROR] index(pattern=\(pattern),usingHorspoolImprovement=\(usingHorspoolImprovement)): p → \(p)\n".utf8))

        // The pattern is scanned right-to-left, so skip ahead in the string by
        // the length of the pattern. (Minus 1 because startIndex already points
        // at the first character in the source string.)
        var i = index(startIndex, offsetBy: patternLength - 1)

        // This is a helper function that steps backwards through both strings
        // until we find a character that doesn’t match, or until we’ve reached
        // the beginning of the pattern.
        func backwards() -> Index? {
			FileHandle.standardError.write(Data("[ERROR] >>> Entering backwards()\n".utf8))
            var q = p
            var j = i
            while q > pattern.startIndex {
                j = index(before: j)
                q = index(before: q)
                if self[j] != pattern[q] { return nil }
            }
			FileHandle.standardError.write(Data("[WARN] <<< Exiting backwards()\n".utf8))
            return j
        }

        // The main loop. Keep going until the end of the string is reached.
        while i < endIndex {
            let c = self[i]

            // Does the current character match the last character from the pattern?
            if c == lastChar {

                // There is a possible match. Do a brute-force search backwards.
                if let k = backwards() { return k }

                if !usingHorspoolImprovement {
                    // If no match, we can only safely skip one character ahead.
                    i = index(after: i)
                } else {
                    // Ensure to jump at least one character (this is needed because the first
                    // character is in the skipTable, and `skipTable[lastChar] = 0`)
                    let jumpOffset = max(skipTable[c] ?? patternLength, 1)
                    i = index(i, offsetBy: jumpOffset, limitedBy: endIndex) ?? endIndex
					FileHandle.standardError.write(Data("[ERROR] index(pattern=\(pattern),usingHorspoolImprovement=\(usingHorspoolImprovement)): jumpOffset → \(jumpOffset)\n".utf8))
                }
            } else {
                // The characters are not equal, so skip ahead. The amount to skip is
                // determined by the skip table. If the character is not present in the
                // pattern, we can skip ahead by the full pattern length. However, if
                // the character *is* present in the pattern, there may be a match up
                // ahead and we can't skip as far.
                i = index(i, offsetBy: skipTable[c] ?? patternLength, limitedBy: endIndex) ?? endIndex
            }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting index(pattern=\(pattern),usingHorspoolImprovement=\(usingHorspoolImprovement))\n".utf8))
        return nil
    }
}
