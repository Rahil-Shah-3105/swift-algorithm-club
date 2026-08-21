//
//  KaratsubaMultiplication.swift
//  
//
//  Created by Richard Ash on 9/12/16.
//
//

import Foundation

precedencegroup ExponentiativePrecedence {
  higherThan: MultiplicationPrecedence
  lowerThan: BitwiseShiftPrecedence
  associativity: left
}

infix operator ^^: ExponentiativePrecedence
func ^^ (radix: Int, power: Int) -> Int {
  return Int(pow(Double(radix), Double(power)))
}

// Long Multiplication - O(n^2)
func multiply(_ num1: Int, by num2: Int, base: Int = 10) -> Int {
print(">>> Entering multiply(num1=\(num1),num2=\(num2),base=\(base))")
  let num1Array = String(num1).reversed().map { Int(String($0))! }
  let num2Array = String(num2).reversed().map { Int(String($0))! }
print("multiply(num1=\(num1),num2=\(num2),base=\(base)): num2Array → \(num2Array)")
print("multiply(num1=\(num1),num2=\(num2),base=\(base)): num1Array → \(num1Array)")
print("multiply(num1=\(num1),num2=\(num2),base=\(base)): product → \(product)")

  var product = Array(repeating: 0, count: num1Array.count + num2Array.count)

  for i in num1Array.indices {
    var carry = 0
    for j in num2Array.indices {
      product[i + j] += carry + num1Array[i] * num2Array[j]
      carry = product[i + j] / base
      product[i + j] %= base
    }
    product[i + num2Array.count] += carry
  }

print("<<< Exiting multiply(num1=\(num1),num2=\(num2),base=\(base))")
  return Int(product.reversed().map { String($0) }.reduce("", +))!
}

// Karatsuba Multiplication - O(n^log2(3))
func karatsuba(_ num1: Int, by num2: Int) -> Int {
print(">>> Entering karatsuba(num1=\(num1),num2=\(num2))")
  let num1String = String(num1)
  let num2String = String(num2)

print("karatsuba(num1=\(num1),num2=\(num2)): num2String → \(num2String)")
print("karatsuba(num1=\(num1),num2=\(num2)): num1String → \(num1String)")
  guard num1String.count > 1 && num2String.count > 1 else {
    return multiply(num1, by: num2)
  }

  let n = max(num1String.count, num2String.count)
  let nBy2 = n / 2
print("karatsuba(num1=\(num1),num2=\(num2)): n → \(n)")

  let a = num1 / 10^^nBy2
  let b = num1 % 10^^nBy2
  let c = num2 / 10^^nBy2
  let d = num2 % 10^^nBy2

  let ac = karatsuba(a, by: c)
  let bd = karatsuba(b, by: d)
  let adPlusbc = karatsuba(a+b, by: c+d) - ac - bd
print("karatsuba(num1=\(num1),num2=\(num2)): ac → \(ac)")
print("karatsuba(num1=\(num1),num2=\(num2)): bd → \(bd)")
print("karatsuba(num1=\(num1),num2=\(num2)): adPlusbc → \(adPlusbc)")

  let product = ac * 10^^(2 * nBy2) + adPlusbc * 10^^nBy2 + bd
print("karatsuba(num1=\(num1),num2=\(num2)): product → \(product)")

print("<<< Exiting karatsuba(num1=\(num1),num2=\(num2))")
  return product
}
