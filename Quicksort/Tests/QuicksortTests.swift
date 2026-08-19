import XCTest

class QuicksortTests: XCTestCase {
  func testQuicksort() {
	print(">>> Entering testQuicksort()")
    checkSortAlgorithm(quicksort)
	print("<<< Exiting testQuicksort()")
  }

  fileprivate typealias QuicksortFunction = (inout [Int], _ low: Int, _ high: Int) -> Void

  fileprivate func checkQuicksort(_ function: QuicksortFunction) {
	print(">>> Entering checkQuicksort(function=\(function))")
    checkSortAlgorithm { (a: [Int]) -> [Int] in
      var b = a
      function(&b, 0, b.count - 1)
	print("<<< Exiting checkQuicksort(function=\(function))")
      return b
    }
  }

  func testQuicksortLomuto() {
	print(">>> Entering testQuicksortLomuto()")
    checkQuicksort(quicksortLomuto)
	print("<<< Exiting testQuicksortLomuto()")
  }

  func testQuicksortHoare() {
	print(">>> Entering testQuicksortHoare()")
    checkQuicksort(quicksortHoare)
	print("<<< Exiting testQuicksortHoare()")
  }

  func testQuicksortRandom() {
	print(">>> Entering testQuicksortRandom()")
    checkQuicksort(quicksortRandom)
	print("<<< Exiting testQuicksortRandom()")
  }

  func testQuicksortDutchFlag() {
	print(">>> Entering testQuicksortDutchFlag()")
    checkQuicksort(quicksortDutchFlag)
	print("<<< Exiting testQuicksortDutchFlag()")
  }
}
