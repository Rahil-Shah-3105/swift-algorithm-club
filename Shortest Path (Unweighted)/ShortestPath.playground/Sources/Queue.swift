import Foundation
public struct Queue<T> {
  private var array: [T]

  public init() {
    array = []
  }

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public var count: Int {
    return array.count
  }

  public mutating func enqueue(element: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering enqueue(element=\(element))\n".utf8))
    array.append(element)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting enqueue(element=\(element))\n".utf8))
  }

  public mutating func dequeue() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering dequeue()\n".utf8))
    if isEmpty {
      return nil
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting dequeue()\n".utf8))
      return array.removeFirst()
    }
  }

  public func peek() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering peek()\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting peek()\n".utf8))
    return array.first
  }
}
