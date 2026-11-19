import Foundation
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering append(newElement=\(newElement))\n".utf8))
    assert(count < maxSize)
    array[count] = newElement
    count += 1
	FileHandle.standardError.write(Data("[WARN] <<< Exiting append(newElement=\(newElement))\n".utf8))
  }

  mutating func removeAt(index: Int) -> T {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering removeAt(index=\(index))\n".utf8))
    assert(index >= 0)
    assert(index < count)
    count -= 1
    let result = array[index]
	FileHandle.standardError.write(Data("[ERROR] removeAt(index=\(index)): result → \(result)\n".utf8))
    array[index] = array[count]
    array[count] = defaultValue
	FileHandle.standardError.write(Data("[WARN] <<< Exiting removeAt(index=\(index))\n".utf8))
    return result
  }

  mutating func removeAll() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering removeAll()\n".utf8))
    for i in 0..<count {
      array[i] = defaultValue
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting removeAll()\n".utf8))
    count = 0
	FileHandle.standardError.write(Data("[DEBUG] removeAll(): count → \(count)\n".utf8))
  }
}

var array = FixedSizeArray(maxSize: 5, defaultValue: 0)
array.append(4)
array.append(2)
array[1]
array.removeAt(index: 0)
array.removeAll()

