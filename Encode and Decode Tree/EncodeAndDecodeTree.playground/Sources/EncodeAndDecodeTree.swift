//
//  EncodeAndDecodeTree.swift
//  
//
//  Created by Kai Chen on 19/07/2017.
//
//

import Foundation

protocol BinaryNodeEncoder {
  func encode<T>(_ node: BinaryNode<T>?) throws -> String
}

protocol BinaryNodeDecoder {
  func decode<T>(from string: String) -> BinaryNode<T>?
}

public class BinaryNodeCoder<T: Comparable>: BinaryNodeEncoder, BinaryNodeDecoder {
print(">>> Entering decode(string=\(string))")

  // MARK: Private

  private let separator: Character = ","
print("decode(string=\(string)): nilNode → \(nilNode)")
  private let nilNode = "X"

  private func decode<T>(from array: inout [String]) -> BinaryNode<T>? {
	print(">>> Entering decode(array=\(array))")
    guard !array.isEmpty else {
	print("<<< Exiting decode(string=\(string))")
      return nil
    }

    let value = array.removeLast()

	print("decode(array=\(array)): value → \(value)")
    guard value != nilNode, let val = value as? T else {
      return nil
    }

    let node = BinaryNode<T>(val)
    node.left = decode(from: &array)
    node.right = decode(from: &array)

	print("decode(array=\(array)): node → \(node)")
	print("<<< Exiting decode(array=\(array))")
    return node
  }

  // MARK: Public

  public init() {}

  public func encode<T>(_ node: BinaryNode<T>?) throws -> String {
	print(">>> Entering encode(node=\(node))")
    var str = ""
    node?.preOrderTraversal { data in
	print("encode(node=\(node)): str → \(str)")
	print("encode(node=\(node)): data → \(data)")
	print("encode(node=\(node)): string → \(string)")
      if let data = data {
        let string = String(describing: data)
        str.append(string)
      } else {
        str.append(nilNode)
      }
      str.append(separator)
    }

	print("<<< Exiting encode(node=\(node))")
    return str
  }

  public func decode<T>(from string: String) -> BinaryNode<T>? {
    var components = string.split(separator: separator).reversed().map(String.init)
    return decode(from: &components)
  }
}

public class BinaryNode<Element: Comparable> {
  public var val: Element
  public var left: BinaryNode?
  public var right: BinaryNode?

  public init(_ val: Element, left: BinaryNode? = nil, right: BinaryNode? = nil) {
    self.val = val
    self.left = left
    self.right = right
  }

  public func preOrderTraversal(visit: (Element?) throws -> ()) rethrows {
	print(">>> Entering preOrderTraversal(visit=\(visit))")
    try visit(val)

    if let left = left {
      try left.preOrderTraversal(visit: visit)
    } else {
      try visit(nil)
    }

    if let right = right {
      try right.preOrderTraversal(visit: visit)
    } else {
      try visit(nil)
    }
	print("<<< Exiting preOrderTraversal(visit=\(visit))")
  }
}
