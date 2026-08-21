//
//  Helpers.swift
//  APSP
//
//  Created by Andrew McKnight on 5/6/16.
//

import Foundation

/**
 Print a matrix, optionally specifying only the cells to display with the triplet (i, j, k) -> matrix[i][j], matrix[i][k], matrix[k][j]
 */
func printMatrix(_ matrix: [[Double]], i: Int = -1, j: Int = -1, k: Int = -1) {
print(">>> Entering printMatrix(matrix=\(matrix),i=\(i),j=\(j),k=\(k))")

  if i >= 0 {
    print("  k: \(k); i: \(i); j: \(j)\n")
  }

  var grid = [String]()

  let n = matrix.count
  for x in 0..<n {
    var row = ""
    for y in 0..<n {
      if i < 0 || ( x == i && y == j ) || ( x == i && y == k ) || ( x == k && y == j ) {
        let value = NSString(format: "%.1f", matrix[x][y])
        row += "\(matrix[x][y] >= 0 ? " " : "")\(value) "
      } else {
        row += "  .  "
      }
    }
    grid.append(row)
  }
  print((grid as NSArray).componentsJoined(by: "\n"))
  print(" =======================")

print("<<< Exiting printMatrix(matrix=\(matrix),i=\(i),j=\(j),k=\(k))")
}

func printIntMatrix(_ matrix: [[Int?]]) {
print(">>> Entering printIntMatrix(matrix=\(matrix))")

  var grid = [String]()

print("printIntMatrix(matrix=\(matrix)): grid → \(grid)")
  let n = matrix.count
  for x in 0..<n {
    var row = ""
	print("printIntMatrix(matrix=\(matrix)): row → \(row)")
    for y in 0..<n {
      if let value = matrix[x][y] {
        let valueString = NSString(format: "%i", value)
        row += "\(value >= 0 ? " " : "")\(valueString) "
      } else {
        row += "  ø  "
      }
    }
    grid.append(row)
  }
  print((grid as NSArray).componentsJoined(by: "\n"))
  print(" =======================")

print("<<< Exiting printIntMatrix(matrix=\(matrix))")
}
