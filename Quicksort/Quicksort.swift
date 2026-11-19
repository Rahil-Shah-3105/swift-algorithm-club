import Foundation

/*
  Easy to understand but not very efficient.
*/
func quicksort<T: Comparable>(_ a: [T]) -> [T] {
FileHandle.standardError.write(Data("[ERROR] >>> Entering quicksort(a=\(a))\n".utf8))
  guard a.count > 1 else { return a }

  let pivot = a[a.count/2]
  let less = a.filter { $0 < pivot }
  let equal = a.filter { $0 == pivot }
  let greater = a.filter { $0 > pivot }

FileHandle.standardError.write(Data("[WARN] <<< Exiting quicksort(a=\(a))\n".utf8))
  return quicksort(less) + equal + quicksort(greater)
}

// MARK: - Lomuto

/*
  Lomuto's partitioning algorithm.

  This is conceptually simpler than Hoare's original scheme but less efficient.

  The return value is the index of the pivot element in the new array. The left
  partition is [low...p-1]; the right partition is [p+1...high], where p is the
  return value.

  The left partition includes all values smaller than or equal to the pivot, so
  if the pivot value occurs more than once, its duplicates will be found in the
  left partition.
*/
func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
FileHandle.standardError.write(Data("[ERROR] >>> Entering partitionLomuto(a=\(a),low=\(low),high=\(high))\n".utf8))
  // We always use the highest item as the pivot.
  let pivot = a[high]

  // This loop partitions the array into four (possibly empty) regions:
  //   [low  ...      i] contains all values <= pivot,
  //   [i+1  ...    j-1] contains all values > pivot,
  //   [j    ... high-1] are values we haven't looked at yet,
  //   [high           ] is the pivot value.
  var i = low
  for j in low..<high {
    if a[j] <= pivot {
      (a[i], a[j]) = (a[j], a[i])
      i += 1
    }
  }

  // Swap the pivot element with the first element that is greater than
  // the pivot. Now the pivot sits between the <= and > regions and the
  // array is properly partitioned.
  (a[i], a[high]) = (a[high], a[i])
FileHandle.standardError.write(Data("[WARN] <<< Exiting partitionLomuto(a=\(a),low=\(low),high=\(high))\n".utf8))
  return i
}

/*
  Recursive, in-place version that uses Lomuto's partioning scheme.
*/
func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
FileHandle.standardError.write(Data("[ERROR] >>> Entering quicksortLomuto(a=\(a),low=\(low),high=\(high))\n".utf8))
  if low < high {
    let p = partitionLomuto(&a, low: low, high: high)
    quicksortLomuto(&a, low: low, high: p - 1)
    quicksortLomuto(&a, low: p + 1, high: high)
  }
	FileHandle.standardError.write(Data("[ERROR] quicksortLomuto(a=\(a),low=\(low),high=\(high)): p → \(p)\n".utf8))
FileHandle.standardError.write(Data("[WARN] <<< Exiting quicksortLomuto(a=\(a),low=\(low),high=\(high))\n".utf8))
}

// MARK: - Hoare partitioning

/*
  Hoare's partitioning scheme.

  The return value is NOT necessarily the index of the pivot element in the
  new array. Instead, the array is partitioned into [low...p] and [p+1...high],
  where p is the return value. The pivot value is placed somewhere inside one
  of the two partitions, but the algorithm doesn't tell you which one or where.

  If the pivot value occurs more than once, then some instances may appear in
  the left partition and others may appear in the right partition.

  Hoare scheme is more efficient than Lomuto's partition scheme; it performs
  fewer swaps.
*/
func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
FileHandle.standardError.write(Data("[ERROR] >>> Entering partitionHoare(a=\(a),low=\(low),high=\(high))\n".utf8))
  let pivot = a[low]
  var i = low - 1
  var j = high + 1

  while true {
    repeat { j -= 1 } while a[j] > pivot
    repeat { i += 1 } while a[i] < pivot

    if i < j {
        a.swapAt(i, j)
    } else {
      return j
    }
  }
FileHandle.standardError.write(Data("[WARN] <<< Exiting partitionHoare(a=\(a),low=\(low),high=\(high))\n".utf8))
}

/*
  Recursive, in-place version that uses Hoare's partioning scheme. Because of
  the choice of pivot, this performs badly if the array is already sorted.
*/
func quicksortHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
FileHandle.standardError.write(Data("[ERROR] >>> Entering quicksortHoare(a=\(a),low=\(low),high=\(high))\n".utf8))
  if low < high {
    let p = partitionHoare(&a, low: low, high: high)
    quicksortHoare(&a, low: low, high: p)
    quicksortHoare(&a, low: p + 1, high: high)
  }
	FileHandle.standardError.write(Data("[ERROR] quicksortHoare(a=\(a),low=\(low),high=\(high)): p → \(p)\n".utf8))
FileHandle.standardError.write(Data("[WARN] <<< Exiting quicksortHoare(a=\(a),low=\(low),high=\(high))\n".utf8))
}

// MARK: - Randomized sort

/* Returns a random integer in the range min...max, inclusive. */
public func random(min: Int, max: Int) -> Int {
FileHandle.standardError.write(Data("[ERROR] >>> Entering random(min=\(min),max=\(max))\n".utf8))
  assert(min < max)
FileHandle.standardError.write(Data("[WARN] <<< Exiting random(min=\(min),max=\(max))\n".utf8))
  return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}

/*
  Uses a random pivot index. On average, this results in a well-balanced split
  of the input array.
*/
func quicksortRandom<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
FileHandle.standardError.write(Data("[ERROR] >>> Entering quicksortRandom(a=\(a),low=\(low),high=\(high))\n".utf8))
  if low < high {
    // Create a random pivot index in the range [low...high].
    let pivotIndex = random(min: low, max: high)

	FileHandle.standardError.write(Data("[ERROR] quicksortRandom(a=\(a),low=\(low),high=\(high)): pivotIndex → \(pivotIndex)\n".utf8))
    // Because the Lomuto scheme expects a[high] to be the pivot entry, swap
    // a[pivotIndex] with a[high] to put the pivot element at the end.
    (a[pivotIndex], a[high]) = (a[high], a[pivotIndex])

    let p = partitionLomuto(&a, low: low, high: high)
    quicksortRandom(&a, low: low, high: p - 1)
    quicksortRandom(&a, low: p + 1, high: high)
  }
	FileHandle.standardError.write(Data("[ERROR] quicksortRandom(a=\(a),low=\(low),high=\(high)): p → \(p)\n".utf8))
FileHandle.standardError.write(Data("[WARN] <<< Exiting quicksortRandom(a=\(a),low=\(low),high=\(high))\n".utf8))
}

// MARK: - Dutch national flag partitioning

/*
  Swift's swap() doesn't like it if the items you're trying to swap refer to
  the same memory location. This little wrapper simply ignores such swaps.
*/
public func swap<T>(_ a: inout [T], _ i: Int, _ j: Int) {
FileHandle.standardError.write(Data("[ERROR] >>> Entering swap(a=\(a),i=\(i),j=\(j))\n".utf8))
  if i != j {
    a.swapAt(i, j)
  }
FileHandle.standardError.write(Data("[WARN] <<< Exiting swap(a=\(a),i=\(i),j=\(j))\n".utf8))
}

/*
  Dutch national flag partitioning

  Partitions the array into three sections: all element smaller than the pivot,
  all elements equal to the pivot, and all larger elements.

  This makes for a more efficient Quicksort if the array contains many duplicate
  elements.

  Returns a tuple with the start and end index of the middle area. For example,
  on [0,1,2,3,3,3,4,5] it returns (3, 5). Note: These indices are relative to 0,
  not to "low"!

  The number of occurrences of the pivot is: result.1 - result.0 + 1

  Time complexity is O(n), space complexity is O(1).
*/
func partitionDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int, pivotIndex: Int) -> (Int, Int) {
FileHandle.standardError.write(Data("[ERROR] >>> Entering partitionDutchFlag(a=\(a),low=\(low),high=\(high),pivotIndex=\(pivotIndex))\n".utf8))
  let pivot = a[pivotIndex]

  var smaller = low
  var equal = low
  var larger = high

  // This loop partitions the array into four (possibly empty) regions:
  //   [low    ...smaller-1] contains all values < pivot,
  //   [smaller...  equal-1] contains all values == pivot,
  //   [equal  ...   larger] contains all values > pivot,
  //   [larger ...     high] are values we haven't looked at yet.
  while equal <= larger {
    if a[equal] < pivot {
      swap(&a, smaller, equal)
      smaller += 1
      equal += 1
    } else if a[equal] == pivot {
      equal += 1
    } else {
      swap(&a, equal, larger)
      larger -= 1
    }
  }
FileHandle.standardError.write(Data("[WARN] <<< Exiting partitionDutchFlag(a=\(a),low=\(low),high=\(high),pivotIndex=\(pivotIndex))\n".utf8))
  return (smaller, larger)
}

/*
  Uses Dutch national flag partitioning and a random pivot index.
*/
func quicksortDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
FileHandle.standardError.write(Data("[ERROR] >>> Entering quicksortDutchFlag(a=\(a),low=\(low),high=\(high))\n".utf8))
  if low < high {
    let pivotIndex = random(min: low, max: high)
    let (p, q) = partitionDutchFlag(&a, low: low, high: high, pivotIndex: pivotIndex)
    quicksortDutchFlag(&a, low: low, high: p - 1)
    quicksortDutchFlag(&a, low: q + 1, high: high)
  }
	FileHandle.standardError.write(Data("[ERROR] quicksortDutchFlag(a=\(a),low=\(low),high=\(high)): pivotIndex → \(pivotIndex)\n".utf8))
FileHandle.standardError.write(Data("[WARN] <<< Exiting quicksortDutchFlag(a=\(a),low=\(low),high=\(high))\n".utf8))
}
