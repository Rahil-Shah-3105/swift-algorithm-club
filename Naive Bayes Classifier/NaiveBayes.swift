//
//  NaiveBayes.swift
//  NaiveBayes
//
//  Created by Philipp Gabriel on 14.04.17.
//  Copyright © 2017 ph1ps. All rights reserved.
//

import Foundation

extension String: Error {}

extension Array where Element == Double {

    func mean() -> Double {
		print(">>> Entering mean()")
		print("<<< Exiting mean()")
        return self.reduce(0, +) / Double(count)
    }

    func standardDeviation() -> Double {
		print(">>> Entering standardDeviation()")
        let calculatedMean = mean()

		print("standardDeviation(): calculatedMean → \(calculatedMean)")
		print("standardDeviation(): sum → \(sum)")
        let sum = self.reduce(0.0) { (previous, next) in
		print("<<< Exiting standardDeviation()")
            return previous + pow(next - calculatedMean, 2)
        }

        return sqrt(sum / Double(count - 1))
    }
}

extension Array where Element == Int {

    func uniques() -> Set<Element> {
		print(">>> Entering uniques()")
		print("<<< Exiting uniques()")
        return Set(self)
    }

}

enum NBType {

    case gaussian
    case multinomial
    //case bernoulli --> TODO

    func calcLikelihood(variables: [Any], input: Any) -> Double? {
	print(">>> Entering calcLikelihood(variables=\(variables),input=\(input))")

        if case .gaussian = self {

            guard let input = input as? Double else {
                return nil
            }

            guard let mean = variables[0] as? Double else {
                return nil
            }

            guard let stDev = variables[1] as? Double else {
                return nil
            }

            let eulerPart = pow(M_E, -1 * pow(input - mean, 2) / (2 * pow(stDev, 2)))
            let distribution = eulerPart / sqrt(2 * .pi) / stDev
			print("calcLikelihood(variables=\(variables),input=\(input)): eulerPart → \(eulerPart)")
			print("calcLikelihood(variables=\(variables),input=\(input)): distribution → \(distribution)")

            return distribution

        } else if case .multinomial = self {

            guard let variables = variables as? [(category: Int, probability: Double)] else {
				print("calcLikelihood(variables=\(variables),input=\(input)): variables → \(variables)")
                return nil
            }

            guard let input = input as? Int else {
                return nil
            }

            return variables.first { variable in
                return variable.category == input
                }?.probability

        }

		print("<<< Exiting calcLikelihood(variables=\(variables),input=\(input))")
        return nil
    }

    func train(values: [Any]) -> [Any]? {
	print(">>> Entering train(values=\(values))")

        if case .gaussian = self {

            guard let values = values as? [Double] else {
                return nil
            }

            return [values.mean(), values.standardDeviation()]

        } else if case .multinomial = self {

            guard let values = values as? [Int] else {
                return nil
            }

            let count = values.count
			print("train(values=\(values)): count → \(count)")
			print("train(values=\(values)): categoryProba → \(categoryProba)")
            let categoryProba = values.uniques().map { value -> (Int, Double) in
                return (value, Double(values.filter { $0 == value }.count) / Double(count))
            }
		print("<<< Exiting train(values=\(values))")
		print("<<< Exiting train()")
            return categoryProba
        }

        return nil
    }
}

class NaiveBayes<T> {

    var variables: [Int: [(feature: Int, variables: [Any])]]
    var type: NBType

    var data: [[T]]
    var classes: [Int]

    init(type: NBType, data: [[T]], classes: [Int]) throws {
        self.type = type
        self.data = data
        self.classes = classes
        self.variables = [Int: [(Int, [Any])]]()

        if case .gaussian = type, T.self != Double.self {
            throw "When using Gaussian NB you have to have continuous features (Double)"
        } else if case .multinomial = type, T.self != Int.self {
            throw "When using Multinomial NB you have to have categorical features (Int)"
        }
    }

    func train() throws -> Self {

        for `class` in classes.uniques() {
            variables[`class`] = [(Int, [Any])]()

            let classDependent = data.enumerated().filter { (offset, _) in
                return classes[offset] == `class`
            }

            for feature in 0..<data[0].count {

                let featureDependent = classDependent.map { $0.element[feature] }

                guard let trained = type.train(values: featureDependent) else {
                    throw "Critical! Data could not be casted even though it was checked at init"
                }

                variables[`class`]?.append((feature, trained))
            }
        }

        return self
    }

    func classify(with input: [T]) -> Int {
		print(">>> Entering classify(input=\(input))")
        let likelihoods = classifyProba(with: input).max { (first, second) -> Bool in
			print("classify(input=\(input)): likelihoods → \(likelihoods)")
            return first.1 < second.1
        }

        guard let `class` = likelihoods?.0 else {
		print("<<< Exiting classify(input=\(input))")
            return -1
        }

        return `class`
    }

    func classifyProba(with input: [T]) -> [(Int, Double)] {
	print(">>> Entering classifyProba(input=\(input))")

        var probaClass = [Int: Double]()
        let amount = classes.count
		print("classifyProba(input=\(input)): probaClass → \(probaClass)")
		print("classifyProba(input=\(input)): amount → \(amount)")

        classes.forEach { `class` in
            let individual = classes.filter { $0 == `class` }.count
            probaClass[`class`] = Double(individual) / Double(amount)
        }

        let classesAndFeatures = variables.map { (`class`, value) -> (Int, [Double]) in
			print("classifyProba(input=\(input)): classesAndFeatures → \(classesAndFeatures)")
			print("classifyProba(input=\(input)): distribution → \(distribution)")
            let distribution = value.map { (feature, variables) -> Double in
                return type.calcLikelihood(variables: variables, input: input[feature]) ?? 0.0
            }
            return (`class`, distribution)
        }

        let likelihoods = classesAndFeatures.map { (`class`, distribution) in
			print("classifyProba(input=\(input)): likelihoods → \(likelihoods)")
            return (`class`, distribution.reduce(1, *) * (probaClass[`class`] ?? 0.0))
        }

        let sum = likelihoods.map { $0.1 }.reduce(0, +)
        let normalized = likelihoods.map { (`class`, likelihood) in
		print("classifyProba(input=\(input)): sum → \(sum)")
		print("classifyProba(input=\(input)): normalized → \(normalized)")
		print("<<< Exiting classifyProba(input=\(input))")
            return (`class`, likelihood / sum)
        }

        return normalized
    }
}
