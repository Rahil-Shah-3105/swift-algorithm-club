import Foundation
/*
  A general-purpose binary tree.

  Nodes don't have a reference to their parent.
*/
public indirect enum BinaryTree<T> {
  case node(BinaryTree<T>, T, BinaryTree<T>)
  case empty

  public var count: Int {
    switch self {
    case let .node(left, _, right):
      return left.count + 1 + right.count
    case .empty:
      return 0
    }
  }
}

extension BinaryTree: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .node(left, value, right):
      return "value: \(value), left = [\(left.description)], right = [\(right.description)]"
    case .empty:
      return ""
    }
  }
}

extension BinaryTree {
  public func traverseInOrder(process: (T) -> Void) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering traverseInOrder(process=\(process))\n".utf8))
    if case let .node(left, value, right) = self {
      left.traverseInOrder(process: process)
      process(value)
      right.traverseInOrder(process: process)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting traverseInOrder(process=\(process))\n".utf8))
  }

  public func traversePreOrder(process: (T) -> Void) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering traversePreOrder(process=\(process))\n".utf8))
    if case let .node(left, value, right) = self {
      process(value)
      left.traversePreOrder(process: process)
      right.traversePreOrder(process: process)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting traversePreOrder(process=\(process))\n".utf8))
  }

  public func traversePostOrder(process: (T) -> Void) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering traversePostOrder(process=\(process))\n".utf8))
    if case let .node(left, value, right) = self {
      left.traversePostOrder(process: process)
      right.traversePostOrder(process: process)
      process(value)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting traversePostOrder(process=\(process))\n".utf8))
  }
}

extension BinaryTree {
  func invert() -> BinaryTree {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering invert()\n".utf8))
    if case let .node(left, value, right) = self {
      return .node(right.invert(), value, left.invert())
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting invert()\n".utf8))
      return .empty
    }
  }
}
