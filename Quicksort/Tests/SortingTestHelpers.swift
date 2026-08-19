import XCTest

func randomArray(_ size: Int) -> [Int] {
print(">>> Entering randomArray(size=\(size))")
  var a = [Int]()
  for _ in 1...size {
	print("randomArray(size=\(size)): a → \(a)")
    a.append(Int(arc4random_uniform(1000)))
  }
print("<<< Exiting randomArray(size=\(size))")
  return a
}

func arrayIsSortedLowToHigh(_ a: [Int]) -> Bool {
print(">>> Entering arrayIsSortedLowToHigh(a=\(a))")
  for x in 1..<a.count {
    if a[x - 1] > a[x] { return false }
  }
print("<<< Exiting arrayIsSortedLowToHigh(a=\(a))")
  return true
}

typealias SortFunction = ([Int]) -> [Int]

func checkSortingRandomArray(_ sortFunction: SortFunction) {
print(">>> Entering checkSortingRandomArray(sortFunction=\(sortFunction))")
  let numberOfIterations = 100
  for _ in 1...numberOfIterations {
    let a = randomArray(Int(arc4random_uniform(100)) + 1)
    let s = sortFunction(a)
    XCTAssertEqual(a.count, s.count)
    XCTAssertTrue(arrayIsSortedLowToHigh(s))
  }
	print("checkSortingRandomArray(sortFunction=\(sortFunction)): a → \(a)")
	print("checkSortingRandomArray(sortFunction=\(sortFunction)): s → \(s)")
print("<<< Exiting checkSortingRandomArray(sortFunction=\(sortFunction))")
}

func checkSortingEmptyArray(_ sortFunction: SortFunction) {
print(">>> Entering checkSortingEmptyArray(sortFunction=\(sortFunction))")
  let a = [Int]()
  let s = sortFunction(a)
  XCTAssertEqual(s.count, 0)
print("checkSortingEmptyArray(sortFunction=\(sortFunction)): s → \(s)")
print("checkSortingEmptyArray(sortFunction=\(sortFunction)): a → \(a)")
print("<<< Exiting checkSortingEmptyArray(sortFunction=\(sortFunction))")
}

func checkSortingArrayOneElement(_ sortFunction: SortFunction) {
print(">>> Entering checkSortingArrayOneElement(sortFunction=\(sortFunction))")
  let a = [123]
  let s = sortFunction(a)
  XCTAssertEqual(s, [123])
print("checkSortingArrayOneElement(sortFunction=\(sortFunction)): s → \(s)")
print("<<< Exiting checkSortingArrayOneElement(sortFunction=\(sortFunction))")
}

func checkSortingArrayTwoElementsInOrder(_ sortFunction: SortFunction) {
print(">>> Entering checkSortingArrayTwoElementsInOrder(sortFunction=\(sortFunction))")
  let a = [123, 456]
  let s = sortFunction(a)
  XCTAssertEqual(s, [123, 456])
print("checkSortingArrayTwoElementsInOrder(sortFunction=\(sortFunction)): s → \(s)")
print("<<< Exiting checkSortingArrayTwoElementsInOrder(sortFunction=\(sortFunction))")
}

func checkSortingArrayTwoElementsOutOfOrder(_ sortFunction: SortFunction) {
print(">>> Entering checkSortingArrayTwoElementsOutOfOrder(sortFunction=\(sortFunction))")
  let a = [456, 123]
  let s = sortFunction(a)
  XCTAssertEqual(s, [123, 456])
print("checkSortingArrayTwoElementsOutOfOrder(sortFunction=\(sortFunction)): s → \(s)")
print("<<< Exiting checkSortingArrayTwoElementsOutOfOrder(sortFunction=\(sortFunction))")
}

func checkSortingArrayTwoEqualElements(_ sortFunction: SortFunction) {
print(">>> Entering checkSortingArrayTwoEqualElements(sortFunction=\(sortFunction))")
  let a = [123, 123]
  let s = sortFunction(a)
  XCTAssertEqual(s, [123, 123])
print("checkSortingArrayTwoEqualElements(sortFunction=\(sortFunction)): s → \(s)")
print("<<< Exiting checkSortingArrayTwoEqualElements(sortFunction=\(sortFunction))")
}

func checkSortingArrayThreeElementsABC(_ sortFunction: SortFunction) {
print(">>> Entering checkSortingArrayThreeElementsABC(sortFunction=\(sortFunction))")
  let a = [2, 4, 6]
  let s = sortFunction(a)
  XCTAssertEqual(s, [2, 4, 6])
print("checkSortingArrayThreeElementsABC(sortFunction=\(sortFunction)): s → \(s)")
print("<<< Exiting checkSortingArrayThreeElementsABC(sortFunction=\(sortFunction))")
}

func checkSortingArrayThreeElementsACB(_ sortFunction: SortFunction) {
print(">>> Entering checkSortingArrayThreeElementsACB(sortFunction=\(sortFunction))")
  let a = [2, 6, 4]
  let s = sortFunction(a)
  XCTAssertEqual(s, [2, 4, 6])
print("checkSortingArrayThreeElementsACB(sortFunction=\(sortFunction)): s → \(s)")
print("<<< Exiting checkSortingArrayThreeElementsACB(sortFunction=\(sortFunction))")
}

func checkSortingArrayThreeElementsBAC(_ sortFunction: SortFunction) {
print(">>> Entering checkSortingArrayThreeElementsBAC(sortFunction=\(sortFunction))")
  let a = [4, 2, 6]
  let s = sortFunction(a)
  XCTAssertEqual(s, [2, 4, 6])
print("checkSortingArrayThreeElementsBAC(sortFunction=\(sortFunction)): s → \(s)")
print("<<< Exiting checkSortingArrayThreeElementsBAC(sortFunction=\(sortFunction))")
}

func checkSortingArrayThreeElementsBCA(_ sortFunction: SortFunction) {
print(">>> Entering checkSortingArrayThreeElementsBCA(sortFunction=\(sortFunction))")
  let a = [4, 6, 2]
  let s = sortFunction(a)
  XCTAssertEqual(s, [2, 4, 6])
print("checkSortingArrayThreeElementsBCA(sortFunction=\(sortFunction)): s → \(s)")
print("<<< Exiting checkSortingArrayThreeElementsBCA(sortFunction=\(sortFunction))")
}

func checkSortingArrayThreeElementsCAB(_ sortFunction: SortFunction) {
print(">>> Entering checkSortingArrayThreeElementsCAB(sortFunction=\(sortFunction))")
  let a = [6, 2, 4]
  let s = sortFunction(a)
  XCTAssertEqual(s, [2, 4, 6])
print("checkSortingArrayThreeElementsCAB(sortFunction=\(sortFunction)): s → \(s)")
print("<<< Exiting checkSortingArrayThreeElementsCAB(sortFunction=\(sortFunction))")
}

func checkSortingArrayThreeElementsCBA(_ sortFunction: SortFunction) {
print(">>> Entering checkSortingArrayThreeElementsCBA(sortFunction=\(sortFunction))")
  let a = [6, 4, 2]
  let s = sortFunction(a)
  XCTAssertEqual(s, [2, 4, 6])
print("checkSortingArrayThreeElementsCBA(sortFunction=\(sortFunction)): s → \(s)")
print("<<< Exiting checkSortingArrayThreeElementsCBA(sortFunction=\(sortFunction))")
}

func checkSortAlgorithm(_ sortFunction: SortFunction) {
print(">>> Entering checkSortAlgorithm(sortFunction=\(sortFunction))")
  checkSortingEmptyArray(sortFunction)
  checkSortingArrayOneElement(sortFunction)
  checkSortingArrayTwoElementsInOrder(sortFunction)
  checkSortingArrayTwoElementsOutOfOrder(sortFunction)
  checkSortingArrayTwoEqualElements(sortFunction)
  checkSortingArrayThreeElementsABC(sortFunction)
  checkSortingArrayThreeElementsACB(sortFunction)
  checkSortingArrayThreeElementsBAC(sortFunction)
  checkSortingArrayThreeElementsBCA(sortFunction)
  checkSortingArrayThreeElementsCAB(sortFunction)
  checkSortingArrayThreeElementsCBA(sortFunction)
  checkSortingRandomArray(sortFunction)
print("<<< Exiting checkSortAlgorithm(sortFunction=\(sortFunction))")
}

func checkSortAlgorithm(_ sortFunction: @escaping ([Int], (Int, Int) -> Bool) -> [Int]) {
  checkSortAlgorithm { a in sortFunction(a, <) }
}
