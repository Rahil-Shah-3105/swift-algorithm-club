// The MIT License (MIT)

// Copyright (c) 2016 Mike Taghavi (mitghi[at]me.com)

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

// Stack from : https://github.com/raywenderlich/swift-algorithm-club/tree/master/Stack
public struct Stack<T> {
  fileprivate var array: [T] = []

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

  public func peek() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering peek()\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting peek()\n".utf8))
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

private func coinFlip() -> Bool {
FileHandle.standardError.write(Data("[ERROR] >>> Entering coinFlip()\n".utf8))
  FileHandle.standardError.write(Data("[WARN] <<< Exiting coinFlip()\n".utf8))
  return arc4random_uniform(2) == 1
}

public class DataNode<Key: Comparable, Payload> {
  public typealias Node = DataNode<Key, Payload>

  var data: Payload?
  fileprivate var key: Key?
  var next: Node?
  var down: Node?

  public init(key: Key, data: Payload) {
    self.key  = key
    self.data = data
  }

  public init(asHead head: Bool) {}

}

open class SkipList<Key: Comparable, Payload> {
  public typealias Node = DataNode<Key, Payload>

  fileprivate(set) var head: Node?

  public init() {}

}

// MARK: - Search lanes for a node with a given key

extension SkipList {

  func findNode(key: Key) -> Node? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering findNode(key=\(key))\n".utf8))
    var currentNode: Node? = head
    var isFound: Bool = false

    while !isFound {
      if let node = currentNode {

        switch node.next {
        case .none:

          currentNode = node.down
        case .some(let value) where value.key != nil:

          if value.key == key {
            isFound = true
            break
          } else {
            if key < value.key! {
              currentNode = node.down
            } else {
              currentNode = node.next
            }
          }

        default:
          continue
        }

      } else {
        break
      }
    }

    if isFound {
      return currentNode
    } else {
      return nil
    }

  }

  func search(key: Key) -> Payload? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering search(key=\(key))\n".utf8))
    guard let node = findNode(key: key) else {
      return nil
    }

    return node.next!.data
  }

}

// MARK: - Insert a node into lanes depending on skip list status ( bootstrap base-layer if head is empty / start insertion from current head ).

extension SkipList {
  private func bootstrapBaseLayer(key: Key, data: Payload) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering bootstrapBaseLayer(key=\(key),data=\(data))\n".utf8))
    head       = Node(asHead: true)
    var node   = Node(key: key, data: data)

	FileHandle.standardError.write(Data("[ERROR] bootstrapBaseLayer(key=\(key),data=\(data)): node → \(node)\n".utf8))
	FileHandle.standardError.write(Data("[DEBUG] bootstrapBaseLayer(key=\(key),data=\(data)): head → \(head)\n".utf8))
    head!.next = node

    var currentTopNode = node
	FileHandle.standardError.write(Data("[WARN] <<< Exiting bootstrapBaseLayer(key=\(key),data=\(data))\n".utf8))

    while coinFlip() {
      let newHead    = Node(asHead: true)
      node           = Node(key: key, data: data)
      node.down      = currentTopNode
      newHead.next   = node
      newHead.down   = head
      head           = newHead
      currentTopNode = node
    }

  }

  private func insertItem(key: Key, data: Payload) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insertItem(key=\(key),data=\(data))\n".utf8))
    var stack              = Stack<Node>()
    var currentNode: Node? = head
	FileHandle.standardError.write(Data("[ERROR] insertItem(key=\(key),data=\(data)): stack → \(stack)\n".utf8))

    while currentNode != nil {

      if let nextNode = currentNode!.next {
        if nextNode.key! > key {
          stack.push(currentNode!)
          currentNode = currentNode!.down
        } else {
          currentNode = nextNode
        }

      } else {
        stack.push(currentNode!)
        currentNode = currentNode!.down
      }

    }

    let itemAtLayer    = stack.pop()
    var node           = Node(key: key, data: data)
    node.next          = itemAtLayer!.next
	FileHandle.standardError.write(Data("[ERROR] insertItem(key=\(key),data=\(data)): itemAtLayer → \(itemAtLayer)\n".utf8))
    itemAtLayer!.next  = node
    var currentTopNode = node
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insertItem(key=\(key),data=\(data))\n".utf8))

    while coinFlip() {
      if stack.isEmpty {
        let newHead    = Node(asHead: true)

        node           = Node(key: key, data: data)
        node.down      = currentTopNode
        newHead.next   = node
        newHead.down   = head
        head           = newHead
        currentTopNode = node

      } else {
        let nextNode  = stack.pop()

        node           = Node(key: key, data: data)
        node.down      = currentTopNode
        node.next      = nextNode!.next
        nextNode!.next = node
        currentTopNode = node
      }
    }
  }

  public func insert(key: Key, data: Payload) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(key=\(key),data=\(data))\n".utf8))
    if head != nil {
      if let node = findNode(key: key) {
        // replace, in case of key already exists.
        var currentNode = node.next
        while currentNode != nil && currentNode!.key == key {
          currentNode!.data = data
          currentNode       = currentNode!.down
        }
      } else {
        insertItem(key: key, data: data)
      }

    } else {
      bootstrapBaseLayer(key: key, data: data)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(key=\(key),data=\(data))\n".utf8))
  }

}

// MARK: - Remove a node with a given key. First, find its position in layers at the top, then remove it from each lane by traversing down to the base layer.

extension SkipList {
  public func remove(key: Key) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(key=\(key))\n".utf8))
    guard let item = findNode(key: key) else {
      return
    }

    var currentNode = Optional(item)

	FileHandle.standardError.write(Data("[ERROR] remove(key=\(key)): currentNode → \(currentNode)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(key=\(key))\n".utf8))
    while currentNode != nil {
      let node   = currentNode!.next

      if node!.key != key {
        currentNode = node
        continue
      }

      let nextNode      = node!.next

      currentNode!.next = nextNode
      currentNode       = currentNode!.down

    }

  }
}

// MARK: - Get associated payload from a node with a given key.

extension SkipList {

  public func get(key: Key) -> Payload? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering get(key=\(key))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting get(key=\(key))\n".utf8))
    return search(key: key)
  }
}
