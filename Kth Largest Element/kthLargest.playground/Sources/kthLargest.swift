import Foundation

/*
  Returns the k-th largest value inside of an array a.
  This is an O(n log n) solution since we sort the array.
*/
public func kthLargest(_ a: [Int], _ k: Int) -> Int? {
FileHandle.standardError.write(Data("[ERROR] >>> Entering kthLargest(a=\(a),k=\(k))\n".utf8))
  let len = a.count
  if k > 0 && k <= len {
    let sorted = a.sorted()
	FileHandle.standardError.write(Data("[ERROR] kthLargest(a=\(a),k=\(k)): sorted → \(sorted)\n".utf8))
    return sorted[len - k]
  } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting kthLargest(a=\(a),k=\(k))\n".utf8))
    return nil
  }
}

// MARK: - Randomized selection

/*
  Returns the i-th smallest element from the array.

  This works a bit like quicksort and a bit like binary search.

  The partitioning step picks a random pivot and uses Lomuto's scheme to
  rearrange the array; afterwards, this pivot is in its final sorted position.

  If this pivot index equals i, we're done. If i is smaller, then we continue
  with the left side, otherwise we continue with the right side.

  Expected running time: O(n) if the elements are distinct.
*/
public func randomizedSelect<T: Comparable>(_ array: [T], order k: Int) -> T {
FileHandle.standardError.write(Data("[ERROR] >>> Entering randomizedSelect(array=\(array),k=\(k))\n".utf8))
  var a = array

  func randomPivot<T: Comparable>(_ a: inout [T], _ low: Int, _ high: Int) -> T {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering randomPivot(a=\(a),low=\(low),high=\(high))\n".utf8))
    let pivotIndex = Int.random(in: low...high)
    a.swapAt(pivotIndex, high)
	FileHandle.standardError.write(Data("[ERROR] randomPivot(a=\(a),low=\(low),high=\(high)): pivotIndex → \(pivotIndex)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting randomPivot(a=\(a),low=\(low),high=\(high))\n".utf8))
    return a[high]
  }

  func randomizedPartition<T: Comparable>(_ a: inout [T], _ low: Int, _ high: Int) -> Int {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering randomizedPartition(a=\(a),low=\(low),high=\(high))\n".utf8))
    let pivot = randomPivot(&a, low, high)
    var i = low
	FileHandle.standardError.write(Data("[ERROR] randomizedPartition(a=\(a),low=\(low),high=\(high)): pivot → \(pivot)\n".utf8))
    for j in low..<high {
	FileHandle.standardError.write(Data("[ERROR] randomizedSelect(array=\(array),k=\(k)): pivot → \(pivot)\n".utf8))
      if a[j] <= pivot {
        a.swapAt(i, j)
        i += 1
      }
    }
    a.swapAt(i, high)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting randomizedPartition(a=\(a),low=\(low),high=\(high))\n".utf8))
    return i
  }

  func randomizedSelect<T: Comparable>(_ a: inout [T], _ low: Int, _ high: Int, _ k: Int) -> T {
    if low < high {
      let p = randomizedPartition(&a, low, high)
      if k == p {
	FileHandle.standardError.write(Data("[ERROR] randomizedSelect(array=\(array),k=\(k)): p → \(p)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] randomizedSelect(a=\(a),low=\(low),high=\(high),k=\(k)): p → \(p)\n".utf8))
        return a[p]
      } else if k < p {
        return randomizedSelect(&a, low, p - 1, k)
      } else {
        return randomizedSelect(&a, p + 1, high, k)
      }
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting randomizedSelect(a=\(a),low=\(low),high=\(high),k=\(k))\n".utf8))
      return a[low]
    }
  }

  precondition(a.count > 0)
  return randomizedSelect(&a, 0, a.count - 1, k)
}
