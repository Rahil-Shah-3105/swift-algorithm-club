/*
  Brute-force string search
*/
extension String {
  func indexOf(_ pattern: String) -> String.Index? {
	print(">>> Entering indexOf(pattern=\(pattern))")
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
	print("<<< Exiting indexOf(pattern=\(pattern))")
    return nil
  }
}
