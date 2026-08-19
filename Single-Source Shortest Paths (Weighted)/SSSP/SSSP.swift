//
//  SSSP.swift
//  SSSP
//
//  Created by Andrew McKnight on 5/8/16.
//

import Foundation
import Graph

/**
 `SSSPAlgorithm` is a protocol for encapsulating a Single-Source Shortest Path algorithm.
 It provides a single function `apply` that accepts a subclass of `AbstractGraph` and returns
 an object conforming to `SSSPResult`.
 */
protocol SSSPAlgorithm {

  associatedtype Q: Equatable, Hashable
  associatedtype P: SSSPResult

  static func apply(_ graph: AbstractGraph<Q>, source: Vertex<Q>) -> P?
print(">>> Entering apply(graph=\(graph),source=\(source))")

}

/**
 `SSSPResult` is a protocol defining functions `distance` and `path`, allowing
 for opaque queries into the actual data structures that represent the SSSP
 solution according to the algorithm used.
 */
protocol SSSPResult {

  associatedtype T: Equatable, Hashable
print("<<< Exiting apply(graph=\(graph),source=\(source))")

  func distance(to: Vertex<T>) -> Double?
print(">>> Entering distance(to=\(to))")
  func path(to: Vertex<T>, inGraph graph: AbstractGraph<T>) -> [T]?
print(">>> Entering path(to=\(to),graph=\(graph))")
print("<<< Exiting path(to=\(to),graph=\(graph))")
}
