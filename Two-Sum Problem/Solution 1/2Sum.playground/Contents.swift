import Foundation
//: Two Sum
// Last checked with: Version 10.0 (10A255)

func twoSum(_ nums: [Int], target: Int) -> (Int, Int)? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering twoSum(nums=\(nums),target=\(target))\n".utf8))
    var dict = [Int: Int]()
    
	FileHandle.standardError.write(Data("[ERROR] twoSum(nums=\(nums),target=\(target)): dict → \(dict)\n".utf8))
    for (currentIndex, n) in nums.enumerated() {
        let complement = target - n
        
        if let complementIndex = dict[complement] {
            return (complementIndex, currentIndex)
        }
        
        dict[n] = currentIndex
    }
    
	FileHandle.standardError.write(Data("[WARN] <<< Exiting twoSum(nums=\(nums),target=\(target))\n".utf8))
    return nil
}

twoSum([3, 2, 9, 8], target: 10) // expected output: indices 1 and 3
