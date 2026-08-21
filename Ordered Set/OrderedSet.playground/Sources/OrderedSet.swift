public class OrderedSet<T: Hashable> {
  private var objects: [T] = []
  private var indexOfKey: [T: Int] = [:]
  
  public init() {}
  
  // O(1)
  public func add(_ object: T) {
	print(">>> Entering add(object=\(object))")
    guard indexOfKey[object] == nil else {
      return
    }
    
    objects.append(object)
    indexOfKey[object] = objects.count - 1
	print("<<< Exiting add(object=\(object))")
  }
  
  // O(n)
  public func insert(_ object: T, at index: Int) {
	print(">>> Entering insert(object=\(object),index=\(index))")
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
	print("<<< Exiting insert(object=\(object),index=\(index))")
  }
  
  // O(1)
  public func object(at index: Int) -> T {
	print(">>> Entering object(index=\(index))")
    assert(index < objects.count, "Index should be smaller than object count")
    assert(index >= 0, "Index should be bigger than 0")
    
	print("<<< Exiting object(index=\(index))")
    return objects[index]
  }
  
  // O(1)
  public func set(_ object: T, at index: Int) {
	print(">>> Entering set(object=\(object),index=\(index))")
    assert(index < objects.count, "Index should be smaller than object count")
    assert(index >= 0, "Index should be bigger than 0")
    
    guard indexOfKey[object] == nil else {
      return
    }
    
    indexOfKey.removeValue(forKey: objects[index])
    indexOfKey[object] = index
    objects[index] = object
	print("<<< Exiting set(object=\(object),index=\(index))")
  }
  
  // O(1)
  public func indexOf(_ object: T) -> Int {
	print(">>> Entering indexOf(object=\(object))")
    return indexOfKey[object] ?? -1
  }
  
  // O(n)
  public func remove(_ object: T) {
	print(">>> Entering remove(object=\(object))")
    guard let index = indexOfKey[object] else {
      return
    }
    
    indexOfKey.removeValue(forKey: object)
    objects.remove(at: index)
    for i in index..<objects.count {
      indexOfKey[objects[i]] = i
    }
	print("<<< Exiting remove(object=\(object))")
  }
  
  public func all() -> [T] {
	print(">>> Entering all()")
    return objects
  }
}
