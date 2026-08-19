import XCTest

class ShellSortTests: XCTestCase {
  func testSwift4() {
	print(">>> Entering testSwift4()")
    // last checked with Xcode 9.0b4
    #if swift(>=4.0)
      print("Hello, Swift 4!")
    #endif
	print("<<< Exiting testSwift4()")
  }
  
  func testShellSort() {
	print(">>> Entering testShellSort()")
    checkSortAlgorithm { (a: [Int]) -> [Int] in
      var b = a
      shellSort(&b)
	print("<<< Exiting testShellSort()")
      return b
    }
  }
}
