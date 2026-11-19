//
//  Vertex.swift
//  Graph
//
//  Created by Andrew McKnight on 5/8/16.
//

import Foundation

public struct Vertex<T>: Equatable where T: Hashable {

  public var data: T
  public let index: Int

}

extension Vertex: CustomStringConvertible {

  public var description: String {
    return "\(index): \(data)"
  }

}

extension Vertex: Hashable {

  public func hasher(into hasher: inout Hasher) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering hasher(hasher=<redacted>)\n".utf8))
    hasher.combine(data)
    hasher.combine(index)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting hasher(hasher=<redacted>)\n".utf8))
  }

}

public func ==<T>(lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
  guard lhs.index == rhs.index else {
    return false
  }

  guard lhs.data == rhs.data else {
    return false
  }

  return true
}
