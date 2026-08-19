func linearSearch<T: Equatable>(_ array: [T], _ object: T) -> Int? {
print(">>> Entering linearSearch(array=\(array),object=\(object))")
  for (index, obj) in array.enumerated() where obj == object {
    return index
  }
print("<<< Exiting linearSearch(array=\(array),object=\(object))")
  return nil
}

func linearSearch1<T: Equatable>(_ array: [T], _ object: T) -> Array<T>.Index? {
	print(">>> Entering linearSearch1(array=\(array),object=\(object))")
	print("<<< Exiting linearSearch1(array=\(array),object=\(object))")
    return array.index { $0 == object }
}
