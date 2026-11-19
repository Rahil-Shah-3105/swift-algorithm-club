import Foundation
extension Heap {
  public mutating func sort() -> [T] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering sort()\n".utf8))
    for i in stride(from: (nodes.count - 1), through: 1, by: -1) {
      nodes.swapAt(0, i)
      shiftDown(from: 0, until: i)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting sort()\n".utf8))
    return nodes
  }
}

/*
 Sorts an array using a heap.
 Heapsort can be performed in-place, but it is not a stable sort.
 */
public func heapsort<T>(_ a: [T], _ sort: @escaping (T, T) -> Bool) -> [T] {
FileHandle.standardError.write(Data("[ERROR] >>> Entering heapsort(a=\(a),sort=\(sort))\n".utf8))
  let reverseOrder = { i1, i2 in sort(i2, i1) }
FileHandle.standardError.write(Data("[WARN] <<< Exiting heapsort(a=\(a),sort=\(sort))\n".utf8))
  var h = Heap(array: a, sort: reverseOrder)
FileHandle.standardError.write(Data("[ERROR] heapsort(a=\(a),sort=\(sort)): h → \(h)\n".utf8))
FileHandle.standardError.write(Data("[ERROR] heapsort(a=\(a),sort=\(sort)): reverseOrder → \(reverseOrder)\n".utf8))
  return h.sort()
}
