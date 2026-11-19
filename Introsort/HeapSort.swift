import Foundation

private func shiftDown<T>(_ elements: inout [T], _ index: Int, _ range: Range<Int>, by areInIncreasingOrder: (T, T) -> Bool) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering shiftDown(elements=\(elements),index=\(index),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
    let countToIndex = elements.distance(from: range.lowerBound, to: index)
    let countFromIndex = elements.distance(from: index, to: range.upperBound)
    
	FileHandle.standardError.write(Data("[ERROR] shiftDown(elements=\(elements),index=\(index),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder)): countFromIndex → \(countFromIndex)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] shiftDown(elements=\(elements),index=\(index),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder)): countToIndex → \(countToIndex)\n".utf8))
    guard countToIndex + 1 < countFromIndex else { return }
    
    let left = elements.index(index, offsetBy: countToIndex + 1)
    var largest = index
	FileHandle.standardError.write(Data("[ERROR] shiftDown(elements=\(elements),index=\(index),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder)): left → \(left)\n".utf8))
    if areInIncreasingOrder(elements[largest], elements[left]) {
        largest = left
    }
    
    if countToIndex + 2 < countFromIndex {
        let right = elements.index(after: left)
        if areInIncreasingOrder(elements[largest], elements[right]) {
            largest = right
        }
    }

    if largest != index {
        elements.swapAt(index, largest)
        shiftDown(&elements, largest, range, by: areInIncreasingOrder)
    }
    
	FileHandle.standardError.write(Data("[WARN] <<< Exiting shiftDown(elements=\(elements),index=\(index),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
}

private func heapify<T>(_ list: inout [T], _ range: Range<Int>, by areInIncreasingOrder: (T, T) -> Bool) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering heapify(list=\(list),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
    let root = range.lowerBound
    var node = list.index(root, offsetBy: list.distance(from: range.lowerBound, to: range.upperBound)/2)
    
	FileHandle.standardError.write(Data("[ERROR] heapify(list=\(list),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder)): node → \(node)\n".utf8))
    while node != root {
        list.formIndex(before: &node)
        shiftDown(&list, node, range, by: areInIncreasingOrder)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting heapify(list=\(list),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
}

public func heapsort<T>(for array: inout [T], range: Range<Int>, by areInIncreasingOrder: (T, T) -> Bool) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering heapsort(array=\(array),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
    var hi = range.upperBound
    let lo = range.lowerBound
    heapify(&array, range, by: areInIncreasingOrder)
    array.formIndex(before: &hi)
    
    while hi != lo {
        array.swapAt(lo, hi)
        shiftDown(&array, lo, lo..<hi, by: areInIncreasingOrder)
        array.formIndex(before: &hi)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting heapsort(array=\(array),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
}
