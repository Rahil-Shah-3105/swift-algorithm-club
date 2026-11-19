import Foundation

public func insertionSort<T>(for array: inout [T], range: Range<Int>, by areInIncreasingOrder: (T, T) -> Bool) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insertionSort(array=\(array),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
    guard !range.isEmpty else { return }
    
    let start = range.lowerBound
    var sortedEnd = start
    
    array.formIndex(after: &sortedEnd)
    while sortedEnd != range.upperBound {
        let x = array[sortedEnd]
        
        var i = sortedEnd
        repeat {
            let predecessor = array[array.index(before: i)]
			FileHandle.standardError.write(Data("[ERROR] insertionSort(array=\(array),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder)): predecessor → \(predecessor)\n".utf8))
            
            guard areInIncreasingOrder(x, predecessor) else { break }
            array[i] = predecessor
            array.formIndex(before: &i)
        } while i != start
        
        if i != sortedEnd {
            array[i] = x
        }
        array.formIndex(after: &sortedEnd)
    }
    
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insertionSort(array=\(array),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder))\n".utf8))
}
