//: Playground - noun: a place where people can play

import UIKit

// last checked with Xcode 9.0b4
#if swift(>=4.0)
    print("Hello, Swift 4!")
#endif

public func insertionSort(_ list: inout [Int], start: Int, gap: Int) {
	print(">>> Entering insertionSort(list=\(list),start=\(start),gap=\(gap))")
    for i in stride(from: (start + gap), to: list.count, by: gap) {
        let currentValue = list[i]
        var pos = i
        while pos >= gap && list[pos - gap] > currentValue {
            list[pos] = list[pos - gap]
            pos -= gap
        }
        list[pos] = currentValue
    }
	print("<<< Exiting insertionSort(list=\(list),start=\(start),gap=\(gap))")
}

public func shellSort(_ list: inout [Int]) {
	print(">>> Entering shellSort(list=\(list))")
    var sublistCount = list.count / 2
    while sublistCount > 0 {
        for pos in 0..<sublistCount {
            insertionSort(&list, start: pos, gap: sublistCount)
        }
        sublistCount = sublistCount / 2
    }
	print("<<< Exiting shellSort(list=\(list))")
}

var arr = [64, 20, 50, 33, 72, 10, 23, -1, 4, 5]

shellSort(&arr)
