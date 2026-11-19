import Foundation

/**
 Validate that a string is a plaindrome
 - parameter str: The string to validate
 - returns: `true` if string is plaindrome, `false` if string is not
 */
public func isPalindrome(_ str: String) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering isPalindrome(str=\(str))\n".utf8))
    let strippedString = str.replacingOccurrences(of: "\\W", with: "", options: .regularExpression, range: nil)
    let length = strippedString.count
	FileHandle.standardError.write(Data("[ERROR] isPalindrome(str=\(str)): strippedString → \(strippedString)\n".utf8))
    
    if length > 1 {
        return palindrome(strippedString.lowercased(), left: 0, right: length - 1)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting isPalindrome(str=\(str))\n".utf8))
    return false
}

/**
 Compares a strings left side character against right side character following
 - parameter str: The string to compare characters of
 - parameter left: Index of left side to compare, must be less than or equal to right
 - parameter right: Index of right side to compare, must be greater than or equal to left
 - returns: `true` if left side and right side have all been compared and they all match, `false` if a left and right aren't equal
 */
private func palindrome(_ str: String, left: Int, right: Int) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering palindrome(str=\(str),left=\(left),right=\(right))\n".utf8))
    if left >= right {
        return true
    }
    
    let lhs = str[str.index(str.startIndex, offsetBy: left)]
	FileHandle.standardError.write(Data("[ERROR] palindrome(str=\(str),left=\(left),right=\(right)): lhs → \(lhs)\n".utf8))
    let rhs = str[str.index(str.startIndex, offsetBy: right)]
	FileHandle.standardError.write(Data("[ERROR] palindrome(str=\(str),left=\(left),right=\(right)): rhs → \(rhs)\n".utf8))
    
    if lhs != rhs {
        return false
    }
    
	FileHandle.standardError.write(Data("[WARN] <<< Exiting palindrome(str=\(str),left=\(left),right=\(right))\n".utf8))
    return palindrome(str, left: left + 1, right: right - 1)
}
