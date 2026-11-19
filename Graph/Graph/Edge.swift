//
//  Edge.swift
//  Graph
//
//  Created by Andrew McKnight on 5/8/16.
//

import Foundation

public struct Edge<T>: Equatable where T: Hashable {

  public let from: Vertex<T>
  public let to: Vertex<T>

  public let weight: Double?

}

extension Edge: CustomStringConvertible {

  public var description: String {
    guard let unwrappedWeight = weight else {
      return "\(from.description) -> \(to.description)"
    }
    return "\(from.description) -(\(unwrappedWeight))-> \(to.description)"
  }

}

extension Edge: Hashable {

  public func hash(into hasher: inout Hasher) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering hash(hasher=<redacted>)\n".utf8))
    hasher.combine(from)
    hasher.combine(to)
    if weight != nil {
      hasher.combine(weight)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting hash(hasher=<redacted>)\n".utf8))
  }

}

public func == <T>(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
  guard lhs.from == rhs.from else {
    return false
  }

  guard lhs.to == rhs.to else {
    return false
  }

  guard lhs.weight == rhs.weight else {
    return false
  }

  return true
}
