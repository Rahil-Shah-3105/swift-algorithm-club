//: Playground - noun: a place where people can play

func linearSearch<T: Equatable>(_ array: [T], _ object: T) -> Int? {
	print(">>> Entering linearSearch(array=\(array),object=\(object))")
    for (index, obj) in array.enumerated() where obj == object {
        return index
    }
	print("<<< Exiting linearSearch(array=\(array),object=\(object))")
    return nil
}

let array = [5, 2, 4, 7]
linearSearch(array, 2) 	// returns 1
linearSearch(array, 3) 	// returns nil
