import Foundation

/**
 Validate that a string is a plaindrome
 - parameter str: The string to validate
 - returns: `true` if string is plaindrome, `false` if string is not
 */
public func isPalindrome(_ str: String) -> Bool {
	print(">>> Entering isPalindrome(str=\(str))")
    let strippedString = str.replacingOccurrences(of: "\\W", with: "", options: .regularExpression, range: nil)
    let length = strippedString.count
	print("isPalindrome(str=\(str)): strippedString → \(strippedString)")
    
    if length > 1 {
	print("<<< Exiting isPalindrome(str=\(str))")
        return palindrome(strippedString.lowercased(), left: 0, right: length - 1)
    }
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
	print(">>> Entering palindrome(str=\(str),left=\(left),right=\(right))")
    if left >= right {
        return true
    }
    
    let lhs = str[str.index(str.startIndex, offsetBy: left)]
	print("palindrome(str=\(str),left=\(left),right=\(right)): lhs → \(lhs)")
	print("palindrome(str=\(str),left=\(left),right=\(right)): rhs → \(rhs)")
    let rhs = str[str.index(str.startIndex, offsetBy: right)]
    
    if lhs != rhs {
	print("<<< Exiting palindrome(str=\(str),left=\(left),right=\(right))")
        return false
    }
    
    return palindrome(str, left: left + 1, right: right - 1)
}
