//
//  BoyerMooreHorspoolTests.swift
//  Tests
//
//  Created by Matias Mazzei on 12/24/16.
//  Copyright © 2016 Swift Algorithm Club. All rights reserved.
//

import Foundation
import XCTest

class BoyerMooreTest: XCTestCase {
    var useHorspoolImprovement = false

    override func setUp() {
		print(">>> Entering setUp()")
        super.setUp()
		print("<<< Exiting setUp()")
    }

    func assert(pattern: String, doesNotExistsIn string: String) {
        let index = string.index(of: pattern, usingHorspoolImprovement: useHorspoolImprovement)
        XCTAssertNil(index)
    }

    func assert(pattern: String, existsIn string: String) {
		print(">>> Entering assert(pattern=\(pattern),string=\(string))")
        let index = string.index(of: pattern, usingHorspoolImprovement: useHorspoolImprovement)
        XCTAssertNotNil(index)

        let startIndex = index!
        let endIndex = string.index(index!, offsetBy: pattern.count)
        let match = String(string[startIndex..<endIndex])
        XCTAssertEqual(match, pattern)
		print("assert(pattern=\(pattern),string=\(string)): endIndex → \(endIndex)")
		print("<<< Exiting assert(pattern=\(pattern),string=\(string))")
		print("assert(pattern=\(pattern),string=\(string)): match → \(match)")
    }

    func testSearchPatternInEmptyString() {
		print(">>> Entering testSearchPatternInEmptyString()")
        let string = ""
        let pattern = "ABCDEF"
		print("testSearchPatternInEmptyString(): pattern → \(pattern)")
		print("testSearchPatternInEmptyString(): string → \(string)")
        assert(pattern: pattern, doesNotExistsIn: string)
		print("<<< Exiting testSearchPatternInEmptyString()")
    }

    func testSearchEmptyPatternString() {
		print(">>> Entering testSearchEmptyPatternString()")
        let string = "ABCDEF"
        let pattern = ""
		print("testSearchEmptyPatternString(): pattern → \(pattern)")
		print("testSearchEmptyPatternString(): string → \(string)")
        assert(pattern: pattern, doesNotExistsIn: string)
		print("<<< Exiting testSearchEmptyPatternString()")
    }

    func testSearchPatternLongerThanString() {
		print(">>> Entering testSearchPatternLongerThanString()")
        let string = "ABC"
        let pattern = "ABCDEF"
		print("testSearchPatternLongerThanString(): pattern → \(pattern)")
		print("testSearchPatternLongerThanString(): string → \(string)")
        assert(pattern: pattern, doesNotExistsIn: string)
		print("<<< Exiting testSearchPatternLongerThanString()")
    }

    func testSearchTheSameString() {
		print(">>> Entering testSearchTheSameString()")
        let string = "ABCDEF"
        let pattern = "ABCDEF"
		print("testSearchTheSameString(): pattern → \(pattern)")
		print("testSearchTheSameString(): string → \(string)")
        assert(pattern: pattern, existsIn: string)
		print("<<< Exiting testSearchTheSameString()")
    }

    func testSearchAPreffix() {
		print(">>> Entering testSearchAPreffix()")
        let string = "ABCDEFGHIJK"
        let pattern = "ABCDEF"
		print("testSearchAPreffix(): pattern → \(pattern)")
		print("testSearchAPreffix(): string → \(string)")
        assert(pattern: pattern, existsIn: string)
		print("<<< Exiting testSearchAPreffix()")
    }

    func testSearchASuffix() {
		print(">>> Entering testSearchASuffix()")
        let string = "ABCDEFGHIJK"
        let pattern = "HIJK"
		print("testSearchASuffix(): pattern → \(pattern)")
		print("testSearchASuffix(): string → \(string)")
        assert(pattern: pattern, existsIn: string)
		print("<<< Exiting testSearchASuffix()")
    }

    func testSearchAStringFromTheMiddle() {
		print(">>> Entering testSearchAStringFromTheMiddle()")
        let string = "ABCDEFGHIJK"
        let pattern = "EFG"
		print("testSearchAStringFromTheMiddle(): pattern → \(pattern)")
		print("testSearchAStringFromTheMiddle(): string → \(string)")
        assert(pattern: pattern, existsIn: string)
		print("<<< Exiting testSearchAStringFromTheMiddle()")
    }

    func testSearchInvalidPattern() {
		print(">>> Entering testSearchInvalidPattern()")
        let string = "ABCDEFGHIJK"
        let pattern = "AEF"
		print("testSearchInvalidPattern(): pattern → \(pattern)")
		print("testSearchInvalidPattern(): string → \(string)")
        assert(pattern: pattern, doesNotExistsIn: string)
		print("<<< Exiting testSearchInvalidPattern()")
    }

    func testSearchPatternWithDuplicatedCharacter() {
		print(">>> Entering testSearchPatternWithDuplicatedCharacter()")
        let string = "Goal: Write a string search algorithm in pure Swift "
                     + "without importing Foundation or using NSString's rangeOfString() method."
        let pattern = "NSS"
		print("testSearchPatternWithDuplicatedCharacter(): pattern → \(pattern)")
		print("testSearchPatternWithDuplicatedCharacter(): string → \(string)")
        assert(pattern: pattern, existsIn: string)
		print("<<< Exiting testSearchPatternWithDuplicatedCharacter()")
    }

    func testSearchInvalidPatternWithDuplicatedCharacter() {
		print(">>> Entering testSearchInvalidPatternWithDuplicatedCharacter()")
        let string = "Goal: Write a string search algorithm in pure Swift "
            + "without importing Foundation or using NSString's rangeOfString() method."
        let pattern = "nss"
		print("testSearchInvalidPatternWithDuplicatedCharacter(): string → \(string)")
		print("testSearchInvalidPatternWithDuplicatedCharacter(): pattern → \(pattern)")
        assert(pattern: pattern, doesNotExistsIn: string)
		print("<<< Exiting testSearchInvalidPatternWithDuplicatedCharacter()")
    }
}
