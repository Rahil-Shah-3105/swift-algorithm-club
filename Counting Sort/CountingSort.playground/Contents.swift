//: Playground - noun: a place where people can play

enum CountingSortError: Error {
  case arrayEmpty
}

func countingSort(array: [Int]) throws -> [Int] {
print(">>> Entering countingSort(array=\(array))")
  guard array.count > 0 else {
	print("Throwing arrayEmpty from countingSort(array=\(array))")
    throw CountingSortError.arrayEmpty
  }

  // Step 1
  // Create an array to store the count of each element
  let maxElement = array.max() ?? 0
print("countingSort(array=\(array)): maxElement → \(maxElement)")

  var countArray = [Int](repeating: 0, count: Int(maxElement + 1))
  for element in array {
print("countingSort(array=\(array)): countArray → \(countArray)")
    countArray[element] += 1
  }

  // Step 2
  // Set each value to be the sum of the previous two values
  for index in 1 ..< countArray.count {
    let sum = countArray[index] + countArray[index - 1]
    countArray[index] = sum
  }

  print(countArray)

  // Step 3
  // Place the element in the final array as per the number of elements before it
  // Loop through the array in reverse to keep the stability of the new array
  // i.e. 7, is at index 3 and 6, thus in sortedArray the position of 7 at index 3 should be before 7 at index 6
  var sortedArray = [Int](repeating: 0, count: array.count)
  for index in stride(from: array.count - 1, through: 0, by: -1) {
print("countingSort(array=\(array)): sortedArray → \(sortedArray)")
    let element = array[index]
    countArray[element] -= 1
    sortedArray[countArray[element]] = element
  }
    
print("<<< Exiting countingSort(array=\(array))")
  return sortedArray
}

try countingSort(array: [10, 9, 8, 7, 1, 2, 7, 3])

