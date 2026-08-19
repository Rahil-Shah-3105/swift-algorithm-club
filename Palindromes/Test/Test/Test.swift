//
//  PalindromeTests.swift
//  Test
//
//  Created by Joshua Alvarado on 12/23/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import XCTest

class PalindromeTests: XCTestCase {

    override func setUp() {
		print(">>> Entering setUp()")
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
		print("<<< Exiting setUp()")
    }

    override func tearDown() {
		print(">>> Entering tearDown()")
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
		print("<<< Exiting tearDown()")
    }

    func testExample() {
		print(">>> Entering testExample()")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		print("<<< Exiting testExample()")
    }

    func testPerformanceExample() {
		print(">>> Entering testPerformanceExample()")
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            _ = isPalindrome("abbcbba")
            _ = isPalindrome("asdkfaksjdfasjkdfhaslkjdfakjsdfhakljsdhflkjasdfhkasdjhfklajsdfhkljasdf")
            _ = isPalindrome("abababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababa")
        }
		print("<<< Exiting testPerformanceExample()")
    }

    func testPalindromeWord() {
		print(">>> Entering testPalindromeWord()")
        XCTAssertTrue(isPalindrome("abbcbba"))
        XCTAssertTrue(isPalindrome("racecar"))
		print("<<< Exiting testPalindromeWord()")
    }

    func testPalindromeSentence() {
		print(">>> Entering testPalindromeSentence()")
        XCTAssertTrue(isPalindrome("A man, a plan, a canal, Panama!"))
        XCTAssertTrue(isPalindrome("Madam, I'm Adam"))
        XCTAssertTrue(isPalindrome("Madam in Eden, I'm Adam"))
        XCTAssertTrue(isPalindrome("In girum imus nocte et consumimur igni"))
        XCTAssertTrue(isPalindrome("Never odd or even"))
		print("<<< Exiting testPalindromeSentence()")
    }

    func testPalindromeNumber() {
		print(">>> Entering testPalindromeNumber()")
        XCTAssertTrue(isPalindrome("5885"))
        XCTAssertTrue(isPalindrome("5 8 8 5"))
        XCTAssertTrue(isPalindrome("58 85"))
		print("<<< Exiting testPalindromeNumber()")
    }

    func testSpecialCharacters() {
		print(">>> Entering testSpecialCharacters()")
        XCTAssertTrue(isPalindrome("৯৯"))
		print("<<< Exiting testSpecialCharacters()")
    }

    func testNonPalindromes() {
		print(">>> Entering testNonPalindromes()")
        XCTAssertFalse(isPalindrome("\\\\"))
        XCTAssertFalse(isPalindrome("desserts"))
        XCTAssertFalse(isPalindrome("😀😀"))
        XCTAssertFalse(isPalindrome(""))
        XCTAssertFalse(isPalindrome("a"))
        XCTAssertFalse(isPalindrome("power"))
		print("<<< Exiting testNonPalindromes()")
    }
}
