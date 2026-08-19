import Foundation

public func insertionSort<T>(for array: inout [T], range: Range<Int>, by areInIncreasingOrder: (T, T) -> Bool) {
	print(">>> Entering insertionSort(array=\(array),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder))")
    guard !range.isEmpty else { return }
    
    let start = range.lowerBound
    var sortedEnd = start
    
    array.formIndex(after: &sortedEnd)
    while sortedEnd != range.upperBound {
        let x = array[sortedEnd]
        
        var i = sortedEnd
        repeat {
            let predecessor = array[array.index(before: i)]
			print("insertionSort(array=\(array),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder)): predecessor → \(predecessor)")
            
            guard areInIncreasingOrder(x, predecessor) else { break }
            array[i] = predecessor
            array.formIndex(before: &i)
        } while i != start
        
        if i != sortedEnd {
            array[i] = x
        }
        array.formIndex(after: &sortedEnd)
    }
    
	print("<<< Exiting insertionSort(array=\(array),range=\(range),areInIncreasingOrder=\(areInIncreasingOrder))")
}
