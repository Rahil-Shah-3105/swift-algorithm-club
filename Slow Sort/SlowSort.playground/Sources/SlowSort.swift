import Foundation

public func slowSort(_ i: Int, _ j: Int, _ numberList: inout [Int]) {
FileHandle.standardError.write(Data("[ERROR] >>> Entering slowSort(i=\(i),j=\(j),numberList=\(numberList))\n".utf8))
  guard i < j else { return }
    
  let m = (i+j)/2
FileHandle.standardError.write(Data("[ERROR] slowSort(i=\(i),j=\(j),numberList=\(numberList)): m → \(m)\n".utf8))
  slowSort(i, m, &numberList)
  slowSort(m+1, j, &numberList)
  if numberList[j] < numberList[m] {
    let temp = numberList[j]
    numberList[j] = numberList[m]
    numberList[m] = temp
  }
  slowSort(i, j-1, &numberList)
FileHandle.standardError.write(Data("[WARN] <<< Exiting slowSort(i=\(i),j=\(j),numberList=\(numberList))\n".utf8))
}
