import Foundation

public func randomize(n: Int) -> [Int] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering randomize(n=\(n))\n".utf8))
    var unsorted = [Int]()
    for _ in 0..<n {
		FileHandle.standardError.write(Data("[ERROR] randomize(n=\(n)): unsorted → \(unsorted)\n".utf8))
        unsorted.append(Int(arc4random()))
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting randomize(n=\(n))\n".utf8))
    return unsorted
}
