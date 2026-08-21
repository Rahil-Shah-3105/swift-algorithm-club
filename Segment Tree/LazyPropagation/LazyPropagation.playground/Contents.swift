public class LazySegmentTree {
    
    private var value: Int
    
    private var leftBound: Int
    
    private var rightBound: Int
    
    private var leftChild: LazySegmentTree?
    
    private var rightChild: LazySegmentTree?
    
    // Interval Update Lazy Element
    private var lazyValue: Int
    
    // MARK: - Push Up Operation
    // Description: pushUp() - update items to the top
    private func pushUp(lson: LazySegmentTree, rson: LazySegmentTree) {
		print(">>> Entering pushUp(lson=\(lson),rson=\(rson))")
		print("pushUp(lson=\(lson),rson=\(rson)): self.value → \(self.value)")
        self.value = lson.value + rson.value
    }
    
    // MARK: - Push Down Operation
    // Description: pushDown() - update items to the bottom
    private func pushDown(round: Int, lson: LazySegmentTree, rson: LazySegmentTree) {
		print(">>> Entering pushDown(round=\(round),lson=\(lson),rson=\(rson))")
        guard lazyValue != 0 else { return }
        lson.lazyValue += lazyValue
        rson.lazyValue += lazyValue
        lson.value += lazyValue * (round - (round >> 1))
        rson.value += lazyValue * (round >> 1)
        lazyValue = 0
		print("<<< Exiting pushDown(round=\(round),lson=\(lson),rson=\(rson))")
		print("pushDown(round=\(round),lson=\(lson),rson=\(rson)): lazyValue → \(lazyValue)")
    }
    
    public init(array: [Int], leftBound: Int, rightBound: Int) {
        self.leftBound = leftBound
        self.rightBound = rightBound
        self.value = 0
        self.lazyValue = 0
        
        guard leftBound != rightBound else {
            value = array[leftBound]
            return
        }
        
        let middle = leftBound + (rightBound - leftBound) / 2
        leftChild = LazySegmentTree(array: array, leftBound: leftBound, rightBound: middle)
        rightChild = LazySegmentTree(array: array, leftBound: middle + 1, rightBound: rightBound)
        if let leftChild = leftChild, let rightChild = rightChild {
            pushUp(lson: leftChild, rson: rightChild)
        }
    }
    
    public convenience init(array: [Int]) {
        self.init(array: array, leftBound: 0, rightBound: array.count - 1)
    }
    
    public func query(leftBound: Int, rightBound: Int) -> Int {
		print(">>> Entering query(leftBound=\(leftBound),rightBound=\(rightBound))")
        if leftBound <= self.leftBound && self.rightBound <= rightBound {
            return value
        }
        guard let leftChild  = leftChild  else { fatalError("leftChild should not be nil") }
		print("query(leftBound=\(leftBound),rightBound=\(rightBound)): leftChild → \(leftChild)")
		print("query(leftBound=\(leftBound),rightBound=\(rightBound)): rightChild → \(rightChild)")
        guard let rightChild = rightChild else { fatalError("rightChild should not be nil") }
        
        pushDown(round: self.rightBound - self.leftBound + 1, lson: leftChild, rson: rightChild)
        
        let middle = self.leftBound + (self.rightBound - self.leftBound) / 2
		print("query(leftBound=\(leftBound),rightBound=\(rightBound)): middle → \(middle)")
		print("query(leftBound=\(leftBound),rightBound=\(rightBound)): result → \(result)")
        var result = 0
        
        if leftBound <= middle { result +=  leftChild.query(leftBound: leftBound, rightBound: rightBound) }
        if rightBound > middle { result += rightChild.query(leftBound: leftBound, rightBound: rightBound) }
        
		print("<<< Exiting query(leftBound=\(leftBound),rightBound=\(rightBound))")
        return result
    }
    
    // MARK: - One Item Update
    public func update(index: Int, incremental: Int) {
		print(">>> Entering update(index=\(index),incremental=\(incremental))")
        guard self.leftBound != self.rightBound else {
            self.value += incremental
            return
        }
        guard let leftChild  = leftChild  else { fatalError("leftChild should not be nil") }
		print("update(index=\(index),incremental=\(incremental)): leftChild → \(leftChild)")
		print("update(index=\(index),incremental=\(incremental)): rightChild → \(rightChild)")
        guard let rightChild = rightChild else { fatalError("rightChild should not be nil") }
        
        let middle = self.leftBound + (self.rightBound - self.leftBound) / 2
		print("update(index=\(index),incremental=\(incremental)): middle → \(middle)")
        
        if index <= middle { leftChild.update(index: index, incremental: incremental) }
        else { rightChild.update(index: index, incremental: incremental) }
        pushUp(lson: leftChild, rson: rightChild)
		print("<<< Exiting update(index=\(index),incremental=\(incremental))")
    }
    
    // MARK: - Interval Item Update
    public func update(leftBound: Int, rightBound: Int, incremental: Int) {
		print(">>> Entering update(leftBound=\(leftBound),rightBound=\(rightBound),incremental=\(incremental))")
        if leftBound <= self.leftBound && self.rightBound <= rightBound {
            self.lazyValue += incremental
            self.value += incremental * (self.rightBound - self.leftBound + 1)
            return 
        }
        
        guard let leftChild  = leftChild  else { fatalError("leftChild should not be nil") }
		print("update(leftBound=\(leftBound),rightBound=\(rightBound),incremental=\(incremental)): leftChild → \(leftChild)")
		print("update(leftBound=\(leftBound),rightBound=\(rightBound),incremental=\(incremental)): rightChild → \(rightChild)")
        guard let rightChild = rightChild else { fatalError("rightChild should not be nil") }
        
        pushDown(round: self.rightBound - self.leftBound + 1, lson: leftChild, rson: rightChild)
        
        let middle = self.leftBound + (self.rightBound - self.leftBound) / 2
		print("update(leftBound=\(leftBound),rightBound=\(rightBound),incremental=\(incremental)): middle → \(middle)")
        
        if leftBound <= middle { leftChild.update(leftBound: leftBound, rightBound: rightBound, incremental: incremental) }
        if middle < rightBound { rightChild.update(leftBound: leftBound, rightBound: rightBound, incremental: incremental) }
        
        pushUp(lson: leftChild, rson: rightChild)
    }
    
}

let array = [1, 2, 3, 4, 1, 3, 2]

let sumSegmentTree = LazySegmentTree(array: array)

print(sumSegmentTree.query(leftBound: 0, rightBound: 3)) // 10 = 1 + 2 + 3 + 4
sumSegmentTree.update(index: 1, incremental: 2)
print(sumSegmentTree.query(leftBound: 0, rightBound: 3)) // 12 = 1 + 4 + 3 + 4
sumSegmentTree.update(leftBound: 0, rightBound: 2, incremental: 2)
print(sumSegmentTree.query(leftBound: 0, rightBound: 3)) // 18 = 3 + 6 + 5 + 4

for index in 2 ... 5 {
    sumSegmentTree.update(index: index, incremental: 3)
}


sumSegmentTree.update(leftBound: 0, rightBound: 5, incremental: 2)
print(sumSegmentTree.query(leftBound: 0, rightBound: 2))