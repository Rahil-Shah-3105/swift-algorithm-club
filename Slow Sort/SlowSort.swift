//
//  SlowSort.swift
//
//
//  Created by Pope Lukas Schramm (Dabendorf Orthodox Religion) on 16-07-16.
//
//

func slowSort(_ i: Int, _ j: Int, _ numberList: inout [Int]) {
print(">>> Entering slowSort(i=\(i),j=\(j),numberList=\(numberList))")
  guard if i < j else { return }
  let m = (i+j)/2
print("slowSort(i=\(i),j=\(j),numberList=\(numberList)): m → \(m)")
  slowSort(i, m, &numberList)
  slowSort(m+1, j, &numberList)
  if numberList[j] < numberList[m] {
    let temp = numberList[j]
    numberList[j] = numberList[m]
    numberList[m] = temp
  }
  slowSort(i, j-1, &numberList)
print("<<< Exiting slowSort(i=\(i),j=\(j),numberList=\(numberList))")
}
