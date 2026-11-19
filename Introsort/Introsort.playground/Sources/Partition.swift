import Foundation

public func partitionIndex<T>(for elements: inout [T], subRange range: Range<Int>, by areInIncreasingOrder: (T, T) -> Bool) -> Int {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering partitionIndex(elements=\(elements),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
    var lo = range.lowerBound
    var hi = elements.index(before: range.upperBound)
    
	FileHandle.standardError.write(Data("[ERROR] partitionIndex(elements=\(elements),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder)): hi → \(hi)\n".utf8))
    // Sort the first, middle, and last elements, then use the middle value
    // as the pivot for the partition.
    let half = elements.distance(from: lo, to: hi) / 2
	FileHandle.standardError.write(Data("[ERROR] partitionIndex(elements=\(elements),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder)): half → \(half)\n".utf8))
    let mid = elements.index(lo, offsetBy: half)
    
	FileHandle.standardError.write(Data("[ERROR] partitionIndex(elements=\(elements),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder)): mid → \(mid)\n".utf8))
    sort3(in: &elements, a: lo, b: mid, c: hi, by: areInIncreasingOrder)
    let pivot = elements[mid]
    
    while true {
        elements.formIndex(after: &lo)
        guard findLo(in: elements, pivot: pivot, from: &lo, to: hi, by: areInIncreasingOrder) else { break }
        elements.formIndex(before: &hi)
        guard findHi(in: elements, pivot: pivot, from: lo, to: &hi, by: areInIncreasingOrder) else { break }
        elements.swapAt(lo, hi)
    }

    
	FileHandle.standardError.write(Data("[WARN] <<< Exiting partitionIndex(elements=\(elements),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
    return lo
}

private func findLo<T>(in array: [T], pivot: T, from lo: inout Int, to hi: Int, by areInIncreasingOrder: (T, T)->Bool) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering findLo(array=\(array),pivot=\(pivot),lo=\(lo),hi=\(hi),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
    while lo != hi {
        if !areInIncreasingOrder(array[lo], pivot) {
            return true
        }
        array.formIndex(after: &lo)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting findLo(array=\(array),pivot=\(pivot),lo=\(lo),hi=\(hi),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
    return false
}

private func findHi<T>(in array: [T], pivot: T, from lo: Int, to hi: inout Int, by areInIncreasingOrder: (T, T)->Bool) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering findHi(array=\(array),pivot=\(pivot),lo=\(lo),hi=\(hi),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
    while hi != lo {
        if areInIncreasingOrder(array[hi], pivot) { return true }
        array.formIndex(before: &hi)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting findHi(array=\(array),pivot=\(pivot),lo=\(lo),hi=\(hi),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
    return false
}
