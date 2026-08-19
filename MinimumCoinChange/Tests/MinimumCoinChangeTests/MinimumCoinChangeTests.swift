import XCTest
@testable import MinimumCoinChange

class MinimumCoinChangeTests: XCTestCase {
  func testSwift4() {
	print(">>> Entering testSwift4()")
    // last checked with Xcode 9.0b4
    #if swift(>=4.0)
      print("Hello, Swift 4!")
    #endif
	print("<<< Exiting testSwift4()")
  }
  
  func testExample() {
	print(">>> Entering testExample()")
    let mcc = MinimumCoinChange(coinSet: [1, 2, 5, 10, 20, 25])
    print("Coin set: \(mcc.sortedCoinSet)")
    
	print("testExample(): mcc → \(mcc)")
    do {
      for i in 0..<100 {
        let greedy = try mcc.changeGreedy(i)
        let dynamic = try mcc.changeDynamic(i)
        
		print("testExample(): greedy → \(greedy)")
		print("testExample(): dynamic → \(dynamic)")
        XCTAssertEqual(greedy.reduce(0, +), dynamic.reduce(0, +), "Greedy and Dynamic return two different changes")
        
        if greedy.count != dynamic.count {
          print("\(i): greedy = \(greedy) dynamic = \(dynamic)")
        }
      }
    } catch {
	print("Exception in testExample(): \(error)")
      XCTFail("Test Failed: impossible to change with the given coin set")
    }
	print("<<< Exiting testExample()")
  }
  
  static var allTests = [
    ("testExample", testExample),
    ]
}
