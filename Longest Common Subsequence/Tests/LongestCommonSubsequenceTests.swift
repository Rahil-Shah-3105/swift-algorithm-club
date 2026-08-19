import Foundation
import XCTest

class LongestCommonSubsequenceTests: XCTestCase {

    func testLCSwithSelfIsSelf() {
		print(">>> Entering testLCSwithSelfIsSelf()")
        let a = "ABCDE"

		print("testLCSwithSelfIsSelf(): a → \(a)")
        XCTAssertEqual(a, a.longestCommonSubsequence(a))
		print("<<< Exiting testLCSwithSelfIsSelf()")
    }

    func testLCSWithEmptyStringIsEmptyString() {
		print(">>> Entering testLCSWithEmptyStringIsEmptyString()")
        let a = "ABCDE"

		print("testLCSWithEmptyStringIsEmptyString(): a → \(a)")
        XCTAssertEqual("", a.longestCommonSubsequence(""))
		print("<<< Exiting testLCSWithEmptyStringIsEmptyString()")
    }

    func testLCSIsEmptyWhenNoCharMatches() {
		print(">>> Entering testLCSIsEmptyWhenNoCharMatches()")
        let a = "ABCDE"
        let b = "WXYZ"
		print("testLCSIsEmptyWhenNoCharMatches(): b → \(b)")
		print("testLCSIsEmptyWhenNoCharMatches(): a → \(a)")

        XCTAssertEqual("", a.longestCommonSubsequence(b))
		print("<<< Exiting testLCSIsEmptyWhenNoCharMatches()")
    }

    func testLCSIsNotCommutative() {
		print(">>> Entering testLCSIsNotCommutative()")
        let a = "ABCDEF"
        let b = "XAWDMVBEKD"
		print("testLCSIsNotCommutative(): b → \(b)")
		print("testLCSIsNotCommutative(): a → \(a)")

        XCTAssertEqual("ADE", a.longestCommonSubsequence(b))
        XCTAssertEqual("ABD", b.longestCommonSubsequence(a))
		print("<<< Exiting testLCSIsNotCommutative()")
    }
}
