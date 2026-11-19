//: Playground - noun: a place where people can play

import UIKit

// last checked with Xcode 9.0b4
#if swift(>=4.0)
    print("Hello, Swift 4!")
#endif

public func insertionSort(_ list: inout [Int], start: Int, gap: Int) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insertionSort(list=\(list),start=\(start),gap=\(gap))\n".utf8))
    FileHandle.standardError.write(Data("[ERROR] >>> Entering insertionSort(list=\(list),start=\(start),gap=\(gap))\n".utf8))
    for i in stride(from: (start + gap), to: list.count, by: gap) {
        let currentValue = list[i]
        var pos = i
        while pos >= gap && list[pos - gap] > currentValue {
            list[pos] = list[pos - gap]
            pos -= gap
        }
        list[pos] = currentValue
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insertionSort(list=\(list),start=\(start),gap=\(gap))\n".utf8))
}

public func shellSort(_ list: inout [Int]) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering shellSort(list=\(list))\n".utf8))
    var sublistCount = list.count / 2
    while sublistCount > 0 {
        for pos in 0..<sublistCount {
            insertionSort(&list, start: pos, gap: sublistCount)
        }
        sublistCount = sublistCount / 2
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting shellSort(list=\(list))\n".utf8))
}

var arr = [64, 20, 50, 33, 72, 10, 23, -1, 4, 5]

shellSort(&arr)
