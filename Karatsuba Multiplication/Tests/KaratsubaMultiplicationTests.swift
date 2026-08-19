//
//  KaratsubaMultiplicationTests.swift
//  Tests
//
//  Created by Afonso Graça on 8/10/18.
//

import XCTest

final class KaratsubaMultiplicationTests: XCTestCase {

    func testReadmeExample() {
		print(">>> Entering testReadmeExample()")
        let subject = karatsuba(1234, by: 5678)

		print("testReadmeExample(): subject → \(subject)")
        XCTAssertEqual(subject, 7006652)
		print("<<< Exiting testReadmeExample()")
    }
}
