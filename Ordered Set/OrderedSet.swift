import Foundation
public class OrderedSet<T: Hashable> {
  private var objects: [T] = []
  private var indexOfKey: [T: Int] = [:]
  
  public init() {}
  
  // O(1)
  public func add(_ object: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering add(object=\(object))\n".utf8))
    guard indexOfKey[object] == nil else {
      return
    }
    
    objects.append(object)
    indexOfKey[object] = objects.count - 1
	FileHandle.standardError.write(Data("[WARN] <<< Exiting add(object=\(object))\n".utf8))
  }
  
  // O(n)
  public func insert(_ object: T, at index: Int) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(object=\(object),index=\(index))\n".utf8))
    assert(index < objects.count, "Index should be smaller than object count")
    assert(index >= 0, "Index should be bigger than 0")
    
    guard indexOfKey[object] == nil else {
      return
    }
    
    objects.insert(object, at: index)
    indexOfKey[object] = index
    for i in index+1..<objects.count {
      indexOfKey[objects[i]] = i
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(object=\(object),index=\(index))\n".utf8))
  }
  
  // O(1)
  public func object(at index: Int) -> T {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering object(index=\(index))\n".utf8))
    assert(index < objects.count, "Index should be smaller than object count")
    assert(index >= 0, "Index should be bigger than 0")
    
	FileHandle.standardError.write(Data("[WARN] <<< Exiting object(index=\(index))\n".utf8))
    return objects[index]
  }
  
  // O(1)
  public func set(_ object: T, at index: Int) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering set(object=\(object),index=\(index))\n".utf8))
    assert(index < objects.count, "Index should be smaller than object count")
    assert(index >= 0, "Index should be bigger than 0")
    
    guard indexOfKey[object] == nil else {
      return
    }
    
    indexOfKey.removeValue(forKey: objects[index])
    indexOfKey[object] = index
    objects[index] = object
	FileHandle.standardError.write(Data("[WARN] <<< Exiting set(object=\(object),index=\(index))\n".utf8))
  }
  
  // O(1)
  public func indexOf(_ object: T) -> Int {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering indexOf(object=\(object))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting indexOf(object=\(object))\n".utf8))
    return indexOfKey[object] ?? -1
  }
  
  // O(n)
  public func remove(_ object: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(object=\(object))\n".utf8))
    guard let index = indexOfKey[object] else {
      return
    }
    
    indexOfKey.removeValue(forKey: object)
    objects.remove(at: index)
    for i in index..<objects.count {
      indexOfKey[objects[i]] = i
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(object=\(object))\n".utf8))
  }
  
  public func all() -> [T] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering all()\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting all()\n".utf8))
    return objects
  }
}

