//: Two Sum
// Last checked with: Version 10.0 (10A255)

func twoSum(_ nums: [Int], target: Int) -> (Int, Int)? {
	print(">>> Entering twoSum(nums=\(nums),target=\(target))")
    var dict = [Int: Int]()
    
	print("twoSum(nums=\(nums),target=\(target)): dict → \(dict)")
    for (currentIndex, n) in nums.enumerated() {
        let complement = target - n
        
        if let complementIndex = dict[complement] {
            return (complementIndex, currentIndex)
        }
        
        dict[n] = currentIndex
    }
    
	print("<<< Exiting twoSum(nums=\(nums),target=\(target))")
    return nil
}

twoSum([3, 2, 9, 8], target: 10) // expected output: indices 1 and 3
