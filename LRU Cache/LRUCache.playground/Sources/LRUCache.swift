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
		FileHandle.standardError.write(Data("[ERROR] >>> Entering get(key=\(key))\n".utf8))
        guard let val = cache[key] else {
            return nil
        }

        remove(key)
        insert(key, val: val)

		FileHandle.standardError.write(Data("[WARN] <<< Exiting get(key=\(key))\n".utf8))
        return val
    }

    public func set(_ key: KeyType, val: Any) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering set(key=\(key),val=\(val))\n".utf8))
        if cache[key] != nil {
            remove(key)
        } else if priority.count >= maxSize, let keyToRemove = priority.last?.value {
            remove(keyToRemove)
        }

        insert(key, val: val)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting set(key=\(key),val=\(val))\n".utf8))
    }

    private func remove(_ key: KeyType) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(key=\(key))\n".utf8))
        cache.removeValue(forKey: key)
        guard let node = key2node[key] else {
            return
        }
        priority.remove(node: node)
        key2node.removeValue(forKey: key)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(key=\(key))\n".utf8))
    }

    private func insert(_ key: KeyType, val: Any) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(key=\(key),val=\(val))\n".utf8))
        cache[key] = val
        priority.insert(key, atIndex: 0)
        guard let first = priority.first else {
            return
        }
        key2node[key] = first
		FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(key=\(key),val=\(val))\n".utf8))
    }
}
