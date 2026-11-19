import Foundation
/*
 Finds the maximum value in an array in O(n) time.
 */

func maximum<T: Comparable>(_ array: [T]) -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering maximum(array=\(array))\n".utf8))
    guard var maximum = array.first else { return nil }
    
    for element in array.dropFirst() {
        maximum = element > maximum ? element : maximum
		FileHandle.standardError.write(Data("[WARN] <<< Exiting maximum(array=\(array))\n".utf8))
    }
    return maximum
}
