//
//  BoyerMooreHorspoolTests.swift
//  Tests
//
//  Created by Matias Mazzei on 12/24/16.
//  Copyright © 2016 Swift Algorithm Club. All rights reserved.
//

class BoyerMooreHorspoolTests: BoyerMooreTest {
    override func setUp() {
		print(">>> Entering setUp()")
        super.setUp()
        useHorspoolImprovement = false
		print("setUp(): useHorspoolImprovement → \(useHorspoolImprovement)")
		print("<<< Exiting setUp()")
    }
}
