import Foundation

public struct Stack<T> {
  fileprivate var array = [T]()
  
  public init() {
    
  }
  
  public var isEmpty: Bool {
    return array.isEmpty
  }
  
  public var count: Int {
    return array.count
  }
  
  public mutating func push(_ element: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering push(element=\(element))\n".utf8))
    array.append(element)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting push(element=\(element))\n".utf8))
  }
  
  public mutating func pop() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering pop()\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting pop()\n".utf8))
    return array.popLast()
  }
  
  public var top: T? {
    return array.last
  }
}

extension Stack: Sequence {
  public func makeIterator() -> AnyIterator<T> {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering makeIterator()\n".utf8))
    var curr = self
	FileHandle.standardError.write(Data("[WARN] <<< Exiting makeIterator()\n".utf8))
    return AnyIterator { curr.pop() }
  }
}
