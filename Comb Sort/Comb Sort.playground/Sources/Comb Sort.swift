//  Comb Sort.swift
//  Comb Sort
//
//  Created by Stephen.Rutstein on 7/16/16.
//  Copyright © 2016 Stephen.Rutstein. All rights reserved.
//

import Foundation

public func combSort<T: Comparable>(_ input: [T]) -> [T] {
	print(">>> Entering combSort(input=\(input))")
    var copy: [T] = input
    var gap = copy.count
    let shrink = 1.3

    while gap > 1 {
        gap = (Int)(Double(gap) / shrink)
        if gap < 1 {
            gap = 1
        }

        var index = 0
        while !(index + gap >= copy.count) {
            if copy[index] > copy[index + gap] {
               copy.swapAt(index, index + gap)
            }
            index += 1
        }
    }
	print("<<< Exiting combSort(input=\(input))")
    return copy
}

fileprivate func swap<T: Comparable>(a: inout T, b: inout T) {
	print(">>> Entering swap(a=\(a),b=\(b))")
    let temp = a
    a = b
    b = temp
	print("<<< Exiting swap(a=\(a),b=\(b))")
}
