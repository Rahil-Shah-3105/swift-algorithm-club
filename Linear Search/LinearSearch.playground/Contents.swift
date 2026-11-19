import Foundation
//: Playground - noun: a place where people can play

func linearSearch<T: Equatable>(_ array: [T], _ object: T) -> Int? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering linearSearch(array=\(array),object=\(object))\n".utf8))
    for (index, obj) in array.enumerated() where obj == object {
        return index
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting linearSearch(array=\(array),object=\(object))\n".utf8))
    return nil
}

let array = [5, 2, 4, 7]
linearSearch(array, 2) 	// returns 1
linearSearch(array, 3) 	// returns nil
