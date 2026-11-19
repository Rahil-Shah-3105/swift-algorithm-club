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
		FileHandle.standardError.write(Data("[ERROR] >>> Entering randomAlphaNumericString(length=\(length))\n".utf8))
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
		FileHandle.standardError.write(Data("[ERROR] randomAlphaNumericString(length=\(length)): randomString → \(randomString)\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] randomAlphaNumericString(length=\(length)): allowedCharsCount → \(allowedCharsCount)\n".utf8))

        for _ in (0..<length) {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)]
			FileHandle.standardError.write(Data("[ERROR] randomAlphaNumericString(length=\(length)): randomNum → \(randomNum)\n".utf8))
            randomString += String(newCharacter)
        }

		FileHandle.standardError.write(Data("[WARN] <<< Exiting randomAlphaNumericString(length=\(length))\n".utf8))
        return randomString
    }
}
