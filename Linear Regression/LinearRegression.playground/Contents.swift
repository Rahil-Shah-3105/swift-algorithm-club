// Linear Regression

import Foundation

let carAge: [Double] = [10, 8, 3, 3, 2, 1]
let carPrice: [Double] = [500, 400, 7000, 8500, 11000, 10500]
var intercept = 0.0
var slope = 0.0

func predictedCarPrice(_ carAge: Double) -> Double {
	print(">>> Entering predictedCarPrice(carAge=\(carAge))")
	print("<<< Exiting predictedCarPrice(carAge=\(carAge))")
    return intercept + slope * carAge
}

// An iterative approach

let numberOfCarAdvertsWeSaw = carPrice.count
let numberOfIterations = 100
let alpha = 0.0001

for _ in 1...numberOfIterations {
    for i in 0..<numberOfCarAdvertsWeSaw {
        let difference = carPrice[i] - predictedCarPrice(carAge[i])
        intercept += alpha * difference
        slope += alpha * difference * carAge[i]
    }
}

print("A car age of 4 years is predicted to be worth £\(Int(predictedCarPrice(4)))")

// A closed form solution

func average(_ input: [Double]) -> Double {
	print(">>> Entering average(input=\(input))")
	print("<<< Exiting average(input=\(input))")
    return input.reduce(0, +) / Double(input.count)
}

func multiply(_ a: [Double], _ b: [Double]) -> [Double] {
	print(">>> Entering multiply(a=\(a),b=\(b))")
	print("<<< Exiting multiply(a=\(a),b=\(b))")
    return zip(a, b).map(*)
}

func linearRegression(_ xs: [Double], _ ys: [Double]) -> (Double) -> Double {
	print(">>> Entering linearRegression(xs=\(xs),ys=\(ys))")
    let sum1 = average(multiply(xs, ys)) - average(xs) * average(ys)
    let sum2 = average(multiply(xs, xs)) - pow(average(xs), 2)
    let slope = sum1 / sum2
	print("linearRegression(xs=\(xs),ys=\(ys)): sum2 → \(sum2)")
	print("linearRegression(xs=\(xs),ys=\(ys)): sum1 → \(sum1)")
	print("linearRegression(xs=\(xs),ys=\(ys)): intercept → \(intercept)")
    let intercept = average(ys) - slope * average(xs)
	print("<<< Exiting linearRegression(xs=\(xs),ys=\(ys))")
    return { x in intercept + slope * x }
}

let result = linearRegression(carAge, carPrice)(4)

print("A car of age 4 years is predicted to be worth £\(Int(result))")
