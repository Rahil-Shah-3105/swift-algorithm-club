import Foundation
func linearSearch<T: Equatable>(_ array: [T], _ object: T) -> Int? {
FileHandle.standardError.write(Data("[ERROR] >>> Entering linearSearch(array=\(array),object=\(object))\n".utf8))
  for (index, obj) in array.enumerated() where obj == object {
    return index
  }
FileHandle.standardError.write(Data("[WARN] <<< Exiting linearSearch(array=\(array),object=\(object))\n".utf8))
  return nil
}

func linearSearch1<T: Equatable>(_ array: [T], _ object: T) -> Array<T>.Index? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering linearSearch1(array=\(array),object=\(object))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting linearSearch1(array=\(array),object=\(object))\n".utf8))
    return array.index { $0 == object }
}
