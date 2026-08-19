import XCTest

class HeapSortTests: XCTestCase {
  
  func testSort() {
	print(">>> Entering testSort()")
    var h1 = Heap(array: [5, 13, 2, 25, 7, 17, 20, 8, 4], sort: >)
    let a1 = h1.sort()
    XCTAssertEqual(a1, [2, 4, 5, 7, 8, 13, 17, 20, 25])
    
	print("testSort(): a1 → \(a1)")
	print("testSort(): h1 → \(h1)")
    let a1_ = heapsort([5, 13, 2, 25, 7, 17, 20, 8, 4], <)
    XCTAssertEqual(a1_, [2, 4, 5, 7, 8, 13, 17, 20, 25])
    
	print("testSort(): a1_ → \(a1_)")
    var h2 = Heap(array: [16, 14, 10, 8, 7, 8, 3, 2, 4, 1], sort: >)
    let a2 = h2.sort()
    XCTAssertEqual(a2, [1, 2, 3, 4, 7, 8, 8, 10, 14, 16])
    
	print("testSort(): h2 → \(h2)")
	print("testSort(): a2 → \(a2)")
    let a2_ = heapsort([16, 14, 10, 8, 7, 8, 3, 2, 4, 1], <)
    XCTAssertEqual(a2_, [1, 2, 3, 4, 7, 8, 8, 10, 14, 16])
    
	print("testSort(): a2_ → \(a2_)")
    var h3 = Heap(array: [1, 2, 3, 4, 5, 6], sort: <)
    let a3 = h3.sort()
    XCTAssertEqual(a3, [6, 5, 4, 3, 2, 1])
    
	print("testSort(): h3 → \(h3)")
	print("testSort(): a3 → \(a3)")
    let a3_ = heapsort([1, 2, 3, 4, 5, 6], >)
    XCTAssertEqual(a3_, [6, 5, 4, 3, 2, 1])
	print("testSort(): a3_ → \(a3_)")
	print("<<< Exiting testSort()")
  }
}
