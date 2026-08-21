import Foundation

public func randomize(n: Int) -> [Int] {
	print(">>> Entering randomize(n=\(n))")
    var unsorted = [Int]()
    for _ in 0..<n {
		print("randomize(n=\(n)): unsorted → \(unsorted)")
        unsorted.append(Int(arc4random()))
    }
	print("<<< Exiting randomize(n=\(n))")
    return unsorted
}
