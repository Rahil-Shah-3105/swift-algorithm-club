//
//  Utils.swift
//  
//
//  Created by Peter Bødskov on 10/01/17.
//
//

import Foundation

public struct Utils {

    public static let shared = Utils()

    let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    //Random string generator from:
    //http://stackoverflow.com/questions/26845307/generate-random-alphanumeric-string-in-swift/26845710
    public func randomAlphaNumericString(withLength length: Int) -> String {
		print(">>> Entering randomAlphaNumericString(length=\(length))")
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
		print("randomAlphaNumericString(length=\(length)): randomString → \(randomString)")
		print("randomAlphaNumericString(length=\(length)): allowedCharsCount → \(allowedCharsCount)")

        for _ in (0..<length) {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)]
			print("randomAlphaNumericString(length=\(length)): randomNum → \(randomNum)")
			print("randomAlphaNumericString(length=\(length)): newCharacter → \(newCharacter)")
            randomString += String(newCharacter)
        }

		print("<<< Exiting randomAlphaNumericString(length=\(length))")
        return randomString
    }
}
