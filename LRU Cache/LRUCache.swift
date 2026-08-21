//
//  LRUCache.swift
//
//
//  Created by Kai Chen on 16/07/2017.
//
//

import Foundation

public class LRUCache<KeyType: Hashable> {
  private let maxSize: Int
  private var cache: [KeyType: Any] = [:]
  private var priority: LinkedList<KeyType> = LinkedList<KeyType>()
  private var key2node: [KeyType: LinkedList<KeyType>.LinkedListNode<KeyType>] = [:]
  
  public init(_ maxSize: Int) {
    self.maxSize = maxSize
  }
  
  public func get(_ key: KeyType) -> Any? {
	print(">>> Entering get(key=\(key))")
    guard let val = cache[key] else {
      return nil
    }
    
    remove(key)
    insert(key, val: val)
    
	print("<<< Exiting get(key=\(key))")
    return val
  }
  
  public func set(_ key: KeyType, val: Any) {
	print(">>> Entering set(key=\(key),val=\(val))")
    if cache[key] != nil {
      remove(key)
    } else if priority.count >= maxSize, let keyToRemove = priority.last?.value {
      remove(keyToRemove)
    }
    
    insert(key, val: val)
	print("<<< Exiting set(key=\(key),val=\(val))")
  }
  
  private func remove(_ key: KeyType) {
	print(">>> Entering remove(key=\(key))")
    cache.removeValue(forKey: key)
    guard let node = key2node[key] else {
      return
    }
    priority.remove(node: node)
    key2node.removeValue(forKey: key)
	print("<<< Exiting remove(key=\(key))")
  }
  
  private func insert(_ key: KeyType, val: Any) {
	print(">>> Entering insert(key=\(key),val=\(val))")
    cache[key] = val
    priority.insert(key, atIndex: 0)
    guard let first = priority.first else {
      return
    }
    key2node[key] = first
	print("<<< Exiting insert(key=\(key),val=\(val))")
  }
}
