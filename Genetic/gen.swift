//: Playground - noun: a place where people can play

import Foundation

extension String {
    var unicodeArray: [UInt8] {
        return [UInt8](self.utf8)
    }
}


let lex: [UInt8] = " !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~".unicodeArray

// This is the end goal and what we will be using to rate fitness. In the real world this will not exist
let OPTIMAL:[UInt8] = "Hello, World".unicodeArray

// The length of the string in our population. Organisms need to be similar
let DNA_SIZE = OPTIMAL.count

// size of each generation
let POP_SIZE = 50

// max number of generations, script will stop when it reach 5000 if the optimal value is not found
let MAX_GENERATIONS = 5000

// The chance in which a random nucleotide can mutate (1/n)
let MUTATION_CHANCE = 100

func randomChar(from lexicon: [UInt8]) -> UInt8 {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering randomChar(lexicon=\(lexicon))\n".utf8))
    let len = UInt32(lexicon.count-1)
    let rand = Int(arc4random_uniform(len))
	FileHandle.standardError.write(Data("[ERROR] randomChar(lexicon=\(lexicon)): rand → \(rand)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] randomChar(lexicon=\(lexicon)): len → \(len)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting randomChar(lexicon=\(lexicon))\n".utf8))
    return lexicon[rand]
}

func randomPopulation(from lexicon: [UInt8], populationSize: Int, dnaSize: Int) -> [[UInt8]] {
FileHandle.standardError.write(Data("[ERROR] >>> Entering randomPopulation(lexicon=\(lexicon),populationSize=\(populationSize),dnaSize=\(dnaSize))\n".utf8))

   var pop = [[UInt8]]()

FileHandle.standardError.write(Data("[ERROR] randomPopulation(lexicon=\(lexicon),populationSize=\(populationSize),dnaSize=\(dnaSize)): pop → \(pop)\n".utf8))
   (0..<populationSize).forEach { _ in
       var dna = [UInt8]()
       (0..<dnaSize).forEach { _ in
	FileHandle.standardError.write(Data("[ERROR] randomPopulation(lexicon=\(lexicon),populationSize=\(populationSize),dnaSize=\(dnaSize)): dna → \(dna)\n".utf8))
           let char = randomChar(from: lexicon)
           dna.append(char)
       }
		FileHandle.standardError.write(Data("[ERROR] randomPopulation(lexicon=\(lexicon),populationSize=\(populationSize),dnaSize=\(dnaSize)): char → \(char)\n".utf8))
       pop.append(dna)
   }
FileHandle.standardError.write(Data("[WARN] <<< Exiting randomPopulation(lexicon=\(lexicon),populationSize=\(populationSize),dnaSize=\(dnaSize))\n".utf8))
   return pop
}

func calculateFitness(dna:[UInt8], optimal:[UInt8]) -> Int {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering calculateFitness(dna=\(dna),optimal=\(optimal))\n".utf8))
    var fitness = 0
    (0...dna.count-1).forEach { c in
        fitness += abs(Int(dna[c]) - Int(optimal[c]))
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting calculateFitness(dna=\(dna),optimal=\(optimal))\n".utf8))
    return fitness
}

func weightedChoice(items:[(dna:[UInt8], weight:Double)]) -> (dna:[UInt8], weight:Double) {
FileHandle.standardError.write(Data("[ERROR] >>> Entering weightedChoice(items=\(items))\n".utf8))

    let total = items.reduce(0.0) { return $0 + $1.weight}
	FileHandle.standardError.write(Data("[ERROR] weightedChoice(items=\(items)): total → \(total)\n".utf8))

    var n = Double(arc4random_uniform(UInt32(total * 1000000.0))) / 1000000.0
	FileHandle.standardError.write(Data("[ERROR] weightedChoice(items=\(items)): n → \(n)\n".utf8))

    for item in items {
        if n < item.weight {
            return item
        }
        n = n - item.weight
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting weightedChoice(items=\(items))\n".utf8))
    return items[1]
}

func mutate(lexicon: [UInt8], dna:[UInt8], mutationChance:Int) -> [UInt8] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering mutate(lexicon=\(lexicon),dna=\(dna),mutationChance=\(mutationChance))\n".utf8))
    var outputDna = dna

    (0..<dna.count).forEach { i in
        let rand = Int(arc4random_uniform(UInt32(mutationChance)))
        if rand == 1 {
		FileHandle.standardError.write(Data("[ERROR] mutate(lexicon=\(lexicon),dna=\(dna),mutationChance=\(mutationChance)): rand → \(rand)\n".utf8))
            outputDna[i] = randomChar(from: lexicon)
        }
    }

	FileHandle.standardError.write(Data("[WARN] <<< Exiting mutate(lexicon=\(lexicon),dna=\(dna),mutationChance=\(mutationChance))\n".utf8))
    return outputDna
}


func crossover(dna1:[UInt8], dna2:[UInt8], dnaSize:Int) -> [UInt8] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering crossover(dna1=\(dna1),dna2=\(dna2),dnaSize=\(dnaSize))\n".utf8))
    let pos = Int(arc4random_uniform(UInt32(dnaSize-1)))

	FileHandle.standardError.write(Data("[ERROR] crossover(dna1=\(dna1),dna2=\(dna2),dnaSize=\(dnaSize)): pos → \(pos)\n".utf8))
    let dna1Index1 = dna1.index(dna1.startIndex, offsetBy: pos)
    let dna2Index1 = dna2.index(dna2.startIndex, offsetBy: pos)

	FileHandle.standardError.write(Data("[ERROR] crossover(dna1=\(dna1),dna2=\(dna2),dnaSize=\(dnaSize)): dna1Index1 → \(dna1Index1)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting crossover(dna1=\(dna1),dna2=\(dna2),dnaSize=\(dnaSize))\n".utf8))
    return [UInt8](dna1.prefix(upTo: dna1Index1) + dna2.suffix(from: dna2Index1))
}

func main() {
FileHandle.standardError.write(Data("[ERROR] >>> Entering main()\n".utf8))

    // generate the starting random population
    var population:[[UInt8]] = randomPopulation(from: lex, populationSize: POP_SIZE, dnaSize: DNA_SIZE)
    // print("population: \(population), dnaSize: \(DNA_SIZE) ")
    var fittest = [UInt8]()

	FileHandle.standardError.write(Data("[ERROR] main(): fittest → \(fittest)\n".utf8))
    for generation in 0...MAX_GENERATIONS {

        var weightedPopulation = [(dna:[UInt8], weight:Double)]()

		FileHandle.standardError.write(Data("[ERROR] main(): weightedPopulation → \(weightedPopulation)\n".utf8))
        // calulcated the fitness of each individual in the population
        // and add it to the weight population (weighted = 1.0/fitness)
        for individual in population {
            let fitnessValue = calculateFitness(dna: individual, optimal: OPTIMAL)

			FileHandle.standardError.write(Data("[ERROR] main(): fitnessValue → \(fitnessValue)\n".utf8))
            let pair = ( individual, fitnessValue == 0 ? 1.0 : Double(100/POP_SIZE)/Double( fitnessValue ) )

			FileHandle.standardError.write(Data("[ERROR] main(): pair → \(pair)\n".utf8))
            weightedPopulation.append(pair)
        }

        population = []

        // create a new generation using the individuals in the origional population
        (0...POP_SIZE).forEach { _ in
            let ind1 = weightedChoice(items: weightedPopulation)
            let ind2 = weightedChoice(items: weightedPopulation)

			FileHandle.standardError.write(Data("[ERROR] main(): ind1 → \(ind1)\n".utf8))
            let offspring = crossover(dna1: ind1.dna, dna2: ind2.dna, dnaSize: DNA_SIZE)

			FileHandle.standardError.write(Data("[ERROR] main(): offspring → \(offspring)\n".utf8))
            // append to the population and mutate
            population.append(mutate(lexicon: lex, dna: offspring, mutationChance: MUTATION_CHANCE))
        }

        fittest = population[0]
        var minFitness = calculateFitness(dna: fittest, optimal: OPTIMAL)

		FileHandle.standardError.write(Data("[ERROR] main(): minFitness → \(minFitness)\n".utf8))
        // parse the population for the fittest string
        population.forEach { indv in
            let indvFitness = calculateFitness(dna: indv, optimal: OPTIMAL)
            if indvFitness < minFitness {
			FileHandle.standardError.write(Data("[ERROR] main(): indvFitness → \(indvFitness)\n".utf8))
                fittest = indv
                minFitness = indvFitness
            }
        }
        if minFitness == 0 { break; }
        print("\(generation): \(String(bytes: fittest, encoding: .utf8)!)")

    }
    print("fittest string: \(String(bytes: fittest, encoding: .utf8)!)")
	FileHandle.standardError.write(Data("[WARN] <<< Exiting main()\n".utf8))
}

main()
