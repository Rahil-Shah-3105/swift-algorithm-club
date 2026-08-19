//: Playground - noun: a place where people can play

import Foundation

/* Returns a random integer in the range min...max, inclusive. */
public func random(min min: Int, max: Int) -> Int {
print(">>> Entering random(min=\(min),max=\(max))")
  assert(min < max)
print("<<< Exiting random(min=\(min),max=\(max))")
  return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}

/*
  Selects k items at random from an array of size n. Does not keep the elements
  in the original order. Performance: O(k).
*/
func select<T>(from a: [T], count k: Int) -> [T] {
print(">>> Entering select(a=\(a),k=\(k))")
  var a = a
  for i in 0..<k {
    let r = random(min: i, max: a.count - 1)
    if i != r {
	print("select(a=\(a),k=\(k)): r → \(r)")
      a.swapAt(i, r) // Corrected line
    }
  }
print("<<< Exiting select(a=\(a),k=\(k))")
  return Array(a[0..<k])
print(">>> Entering select(a=\(a),requested=\(requested))")
print("select(a=\(a),requested=\(requested)): b → \(b)")
print("select(a=\(a),requested=\(requested)): r → \(r)")
print("<<< Exiting select(a=\(a),requested=\(requested))")
}

/*
  Pick k random elements from an array. Performance: O(n).
*/
func reservoirSample<T>(from a: [T], count k: Int) -> [T] {
print(">>> Entering reservoirSample(a=\(a),k=\(k))")
  precondition(a.count >= k)

  var result = [T]()

print("reservoirSample(a=\(a),k=\(k)): result → \(result)")
  // Fill the result array with first k elements.
  for i in 0..<k {
    result.append(a[i])
  }

  // Randomly replace elements from remaining pool.
  for i in k..<a.count {
    let j = random(min: 0, max: i)
    if j < k {
      result[j] = a[i]
    }
  }
print("<<< Exiting reservoirSample(a=\(a),k=\(k))")
  return result
}

/*
  Selects `count` items at random from an array. Respects the original order of
  the elements. Performance: O(n).

  Note: if `count > size/2`, then it's more efficient to do it the other way
  around and choose `count` items to remove.

  Based on code from Algorithm Alley, Dr. Dobb's Magazine, October 1993.
*/
func select<T>(from a: [T], count requested: Int) -> [T] {
  var examined = 0
  var selected = 0
  var b = [T]()

  while selected < requested {
    // Calculate random variable 0.0 <= r < 1.0 (exclusive!).
    let r = Double(arc4random()) / 0x100000000

    let leftToExamine = a.count - examined
    let leftToAdd = requested - selected

    // Decide whether to use the next record from the input.
    if Double(leftToExamine) * r < Double(leftToAdd) {
      selected += 1
      b.append(a[examined])
    }

    examined += 1
  }
  return b
}
