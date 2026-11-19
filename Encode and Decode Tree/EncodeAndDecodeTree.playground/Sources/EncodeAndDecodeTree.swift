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

  // MARK: Private

  private let separator: Character = ","
  private let nilNode = "X"

  private func decode<T>(from array: inout [String]) -> BinaryNode<T>? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering decode(array=\(array))\n".utf8))
    guard !array.isEmpty else {
      return nil
    }

    let value = array.removeLast()

	FileHandle.standardError.write(Data("[ERROR] decode(array=\(array)): value → \(value)\n".utf8))
    guard value != nilNode, let val = value as? T else {
      return nil
    }

    let node = BinaryNode<T>(val)
    node.left = decode(from: &array)
    node.right = decode(from: &array)

	FileHandle.standardError.write(Data("[ERROR] decode(array=\(array)): node → \(node)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting decode(array=\(array))\n".utf8))
    return node
  }

  // MARK: Public

  public init() {}

  public func encode<T>(_ node: BinaryNode<T>?) throws -> String {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering encode(node=\(node))\n".utf8))
    var str = ""
    node?.preOrderTraversal { data in
	FileHandle.standardError.write(Data("[ERROR] encode(node=\(node)): str → \(str)\n".utf8))
      if let data = data {
        let string = String(describing: data)
        str.append(string)
      } else {
		FileHandle.standardError.write(Data("[ERROR] encode(node=\(node)): string → \(string)\n".utf8))
        str.append(nilNode)
      }
      str.append(separator)
    }

	FileHandle.standardError.write(Data("[WARN] <<< Exiting encode(node=\(node))\n".utf8))
    return str
  }

  public func decode<T>(from string: String) -> BinaryNode<T>? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering decode(string=\(string))\n".utf8))
    var components = string.split(separator: separator).reversed().map(String.init)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting decode(string=\(string))\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] decode(string=\(string)): components → \(components)\n".utf8))
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering preOrderTraversal(visit=\(visit))\n".utf8))
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
	FileHandle.standardError.write(Data("[WARN] <<< Exiting preOrderTraversal(visit=\(visit))\n".utf8))
  }
}
