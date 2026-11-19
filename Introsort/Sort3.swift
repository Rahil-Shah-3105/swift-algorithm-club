import Foundation

public func sort3<T>(in array: inout [T], a: Int, b: Int, c: Int, by areInIncreasingOrder: (T, T) -> Bool) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering sort3(array=\(array),a=\(a),b=\(b),c=\(c),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
    switch (areInIncreasingOrder(array[b], array[a]),
            areInIncreasingOrder(array[c], array[b])) {
    case (false, false): break
    case (true, true): array.swapAt(a, c)
    case (true, false):
        array.swapAt(a, b)
        
		FileHandle.standardError.write(Data("[WARN] <<< Exiting sort3(array=\(array),a=\(a),b=\(b),c=\(c),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
        if areInIncreasingOrder(array[c], array[b]) {
            array.swapAt(b, c)
        }
    case (false, true):
        array.swapAt(b, c)
        
        if areInIncreasingOrder(array[b], array[a]) {
            array.swapAt(a, b)
        }
    }
}
