/*
 Finds the maximum value in an array in O(n) time.
 */

func maximum<T: Comparable>(_ array: [T]) -> T? {
	print(">>> Entering maximum(array=\(array))")
    guard var maximum = array.first else { return nil }
    
    for element in array.dropFirst() {
        maximum = element > maximum ? element : maximum
		print("<<< Exiting maximum(array=\(array))")
    }
    return maximum
}
