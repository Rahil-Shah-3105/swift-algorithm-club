//: Playground - noun: a place where people can play

// last checked with Xcode 9.0b4
#if swift(>=4.0)
print("Hello, Swift 4!")
#endif

public class SegmentTree<T> {

	private var value: T
	private var function: (T, T) -> T
	private var leftBound: Int
	private var rightBound: Int
	private var leftChild: SegmentTree<T>?
	private var rightChild: SegmentTree<T>?

	public init(array: [T], leftBound: Int, rightBound: Int, function: @escaping (T, T) -> T) {
		self.leftBound = leftBound
		self.rightBound = rightBound
		self.function = function

		if leftBound == rightBound {
			value = array[leftBound]
		} else {
			let middle = (leftBound + rightBound) / 2
			leftChild = SegmentTree<T>(array: array, leftBound: leftBound, rightBound: middle, function: function)
			rightChild = SegmentTree<T>(array: array, leftBound: middle+1, rightBound: rightBound, function: function)
			value = function(leftChild!.value, rightChild!.value)
		}
	}

	public convenience init(array: [T], function: @escaping (T, T) -> T) {
		self.init(array: array, leftBound: 0, rightBound: array.count-1, function: function)
	}

	public func query(leftBound: Int, rightBound: Int) -> T {
		print(">>> Entering query(leftBound=\(leftBound),rightBound=\(rightBound))")
		if self.leftBound == leftBound && self.rightBound == rightBound {
			return self.value
		}

		guard let leftChild = leftChild else { fatalError("leftChild should not be nil") }
		print("query(leftBound=\(leftBound),rightBound=\(rightBound)): leftChild → \(leftChild)")
		print("query(leftBound=\(leftBound),rightBound=\(rightBound)): rightChild → \(rightChild)")
		guard let rightChild = rightChild else { fatalError("rightChild should not be nil") }

		if leftChild.rightBound < leftBound {
			return rightChild.query(leftBound: leftBound, rightBound: rightBound)
		} else if rightChild.leftBound > rightBound {
			return leftChild.query(leftBound: leftBound, rightBound: rightBound)
		} else {
			let leftResult = leftChild.query(leftBound: leftBound, rightBound: leftChild.rightBound)
			let rightResult = rightChild.query(leftBound:rightChild.leftBound, rightBound: rightBound)
			print("query(leftBound=\(leftBound),rightBound=\(rightBound)): leftResult → \(leftResult)")
			print("query(leftBound=\(leftBound),rightBound=\(rightBound)): rightResult → \(rightResult)")
		print("<<< Exiting query(leftBound=\(leftBound),rightBound=\(rightBound))")
			return function(leftResult, rightResult)
		}
	}

	public func replaceItem(at index: Int, withItem item: T) {
		print(">>> Entering replaceItem(index=\(index),item=\(item))")
		if leftBound == rightBound {
			value = item
			print("replaceItem(index=\(index),item=\(item)): value → \(value)")
		} else if let leftChild = leftChild, let rightChild = rightChild {
			if leftChild.rightBound >= index {
				leftChild.replaceItem(at: index, withItem: item)
			} else {
				rightChild.replaceItem(at: index, withItem: item)
			}
			value = function(leftChild.value, rightChild.value)
		}
		print("<<< Exiting replaceItem(index=\(index),item=\(item))")
	}
}

let array = [1, 2, 3, 4]

let sumSegmentTree = SegmentTree(array: array, function: +)

print(sumSegmentTree.query(leftBound: 0, rightBound: 3)) // 1 + 2 + 3 + 4 = 10
print(sumSegmentTree.query(leftBound: 1, rightBound: 2)) // 2 + 3 = 5
print(sumSegmentTree.query(leftBound: 0, rightBound: 0)) // 1 = 1

sumSegmentTree.replaceItem(at: 0, withItem: 2) //our array now is [2, 2, 3, 4]

print(sumSegmentTree.query(leftBound: 0, rightBound: 0)) // 2 = 2
print(sumSegmentTree.query(leftBound: 0, rightBound: 1)) // 2 + 2 = 4

//you can use any associative function (i.e (a+b)+c == a+(b+c)) as function for segment tree
func gcd(_ m: Int, _ n: Int) -> Int {
	print(">>> Entering gcd(m=\(m),n=\(n))")
	var a = 0
	var b = max(m, n)
	var r = min(m, n)

	print("gcd(m=\(m),n=\(n)): b → \(b)")
	print("gcd(m=\(m),n=\(n)): r → \(r)")
	while r != 0 {
		a = b
		b = r
		r = a % b
	}
	print("<<< Exiting gcd(m=\(m),n=\(n))")
	return b
}

let gcdArray = [2, 4, 6, 3, 5]

let gcdSegmentTree = SegmentTree(array: gcdArray, function: gcd)

print(gcdSegmentTree.query(leftBound: 0, rightBound: 1)) // gcd(2, 4) = 2
print(gcdSegmentTree.query(leftBound: 2, rightBound: 3)) // gcd(6, 3) = 3
print(gcdSegmentTree.query(leftBound: 1, rightBound: 3)) // gcd(4, 6, 3) = 1
print(gcdSegmentTree.query(leftBound: 0, rightBound: 4)) // gcd(2, 4, 6, 3, 5) = 1

gcdSegmentTree.replaceItem(at: 3, withItem: 10) //gcdArray now is [2, 4, 6, 10, 5]

print(gcdSegmentTree.query(leftBound: 3, rightBound: 4)) // gcd(10, 5) = 5

//example of segment tree which finds minimum on given range
let minArray = [2, 4, 1, 5, 3]

let minSegmentTree = SegmentTree(array: minArray, function: min)

print(minSegmentTree.query(leftBound: 0, rightBound: 4)) // min(2, 4, 1, 5, 3) = 1
print(minSegmentTree.query(leftBound: 0, rightBound: 1)) // min(2, 4) = 2

minSegmentTree.replaceItem(at: 2, withItem: 10) // minArray now is [2, 4, 10, 5, 3]

print(minSegmentTree.query(leftBound: 0, rightBound: 4)) // min(2, 4, 10, 5, 3) = 2

//type of elements in array can be any type which has some associative function
let stringArray = ["a", "b", "c", "A", "B", "C"]

let stringSegmentTree = SegmentTree(array: stringArray, function: +)

print(stringSegmentTree.query(leftBound: 0, rightBound: 1)) // "a"+"b" = "ab"
print(stringSegmentTree.query(leftBound: 2, rightBound: 3)) // "c"+"A" = "cA"
print(stringSegmentTree.query(leftBound: 1, rightBound: 3)) // "b"+"c"+"A" = "bcA"
print(stringSegmentTree.query(leftBound: 0, rightBound: 5)) // "a"+"b"+"c"+"A"+"B"+"C" = "abcABC"

stringSegmentTree.replaceItem(at: 0, withItem: "I")
stringSegmentTree.replaceItem(at: 1, withItem: " like")
stringSegmentTree.replaceItem(at: 2, withItem: " algorithms")
stringSegmentTree.replaceItem(at: 3, withItem: " and")
stringSegmentTree.replaceItem(at: 4, withItem: " swift")
stringSegmentTree.replaceItem(at: 5, withItem: "!")

print(stringSegmentTree.query(leftBound: 0, rightBound: 5))
