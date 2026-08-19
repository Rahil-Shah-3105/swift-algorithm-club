//: Playground - noun: a place where people can play

/*
 An unordered array with a maximum size.
 
 Performance is always O(1).
 */
struct FixedSizeArray<T> {
  private var maxSize: Int
  private var defaultValue: T
  private var array: [T]
  private (set) var count = 0

  init(maxSize: Int, defaultValue: T) {
    self.maxSize = maxSize
    self.defaultValue = defaultValue
    self.array = [T](repeating: defaultValue, count: maxSize)
  }

  subscript(index: Int) -> T {
    assert(index >= 0)
    assert(index < count)
    return array[index]
  }

  mutating func append(_ newElement: T) {
	print(">>> Entering append(newElement=\(newElement))")
    assert(count < maxSize)
    array[count] = newElement
    count += 1
	print("<<< Exiting append(newElement=\(newElement))")
  }

  mutating func removeAt(index: Int) -> T {
	print(">>> Entering removeAt(index=\(index))")
    assert(index >= 0)
    assert(index < count)
    count -= 1
    let result = array[index]
	print("removeAt(index=\(index)): result → \(result)")
    array[index] = array[count]
    array[count] = defaultValue
	print("<<< Exiting removeAt(index=\(index))")
    return result
  }

  mutating func removeAll() {
	print(">>> Entering removeAll()")
    for i in 0..<count {
      array[i] = defaultValue
    }
    count = 0
	print("removeAll(): count → \(count)")
	print("<<< Exiting removeAll()")
  }
}

var array = FixedSizeArray(maxSize: 5, defaultValue: 0)
array.append(4)
array.append(2)
array[1]
array.removeAt(index: 0)
array.removeAll()

