import Foundation
/*
 Finds the minimum value in an array in O(n) time.
 */

func minimum<T: Comparable>(_ array: [T]) -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering minimum(array=\(array))\n".utf8))
    guard var minimum = array.first else { return nil }
 
    for element in array.dropFirst() {
        minimum = element < minimum ? element : minimum
		FileHandle.standardError.write(Data("[WARN] <<< Exiting minimum(array=\(array))\n".utf8))
    }
    return minimum
}
