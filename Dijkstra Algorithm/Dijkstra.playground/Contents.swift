//: Playground - noun: a place where people can play
import Foundation

var vertices: Set<Vertex> = Set()

func createNotConnectedVertices() {
	print(">>> Entering createNotConnectedVertices()")
    //change this value to increase or decrease amount of vertices in the graph
    let numberOfVerticesInGraph = 15
    for i in 0..<numberOfVerticesInGraph {
        let vertex = Vertex(identifier: "\(i)")
        vertices.insert(vertex)
    }
		print("createNotConnectedVertices(): vertex → \(vertex)")
	print("<<< Exiting createNotConnectedVertices()")
}

func setupConnections() {
	print(">>> Entering setupConnections()")
    for vertex in vertices {
        //the amount of edges each vertex can have
        let randomEdgesCount = arc4random_uniform(4) + 1
		print("setupConnections(): randomEdgesCount → \(randomEdgesCount)")
        for _ in 0..<randomEdgesCount {
            //randomize weight value from 0 to 9
            let randomWeight = Double(arc4random_uniform(10))
            let neighborVertex = randomVertex(except: vertex)

			print("setupConnections(): randomWeight → \(randomWeight)")
			print("setupConnections(): neighborVertex → \(neighborVertex)")
            //we need this check to set only one connection between two equal pairs of vertices
            if vertex.neighbors.contains(where: { $0.0 == neighborVertex }) {
                continue
            }
            //creating neighbors and setting them
            let neighbor1 = (neighborVertex, randomWeight)
            let neighbor2 = (vertex, randomWeight)
            vertex.neighbors.append(neighbor1)
            neighborVertex.neighbors.append(neighbor2)
        }
			print("setupConnections(): neighbor1 → \(neighbor1)")
			print("setupConnections(): neighbor2 → \(neighbor2)")
    }
	print("<<< Exiting setupConnections()")
}

func randomVertex(except vertex: Vertex) -> Vertex {
	print(">>> Entering randomVertex(vertex=\(vertex))")
    var newSet = vertices
    newSet.remove(vertex)
    let offset = Int(arc4random_uniform(UInt32(newSet.count)))
    let index = newSet.index(newSet.startIndex, offsetBy: offset)
	print("randomVertex(vertex=\(vertex)): offset → \(offset)")
    return newSet[index]
	print(">>> Entering randomVertex()")
	print("randomVertex(): offset → \(offset)")
	print("<<< Exiting randomVertex()")
}

func randomVertex() -> Vertex {
    let offset = Int(arc4random_uniform(UInt32(vertices.count)))
    let index = vertices.index(vertices.startIndex, offsetBy: offset)
    return vertices[index]
}

//initialize random graph
createNotConnectedVertices()
setupConnections()

//initialize Dijkstra algorithm with graph vertices
let dijkstra = Dijkstra(vertices: vertices)

//decide which vertex will be the starting one
let startVertex = randomVertex()

let startTime = Date()

//ask algorithm to find shortest paths from start vertex to all others
dijkstra.findShortestPaths(from: startVertex)

let endTime = Date()

print("calculation time is = \((endTime.timeIntervalSince(startTime))) sec")

//printing results
let destinationVertex = randomVertex(except: startVertex)
print(destinationVertex.pathLengthFromStart)
var pathVerticesFromStartString: [String] = []
for vertex in destinationVertex.pathVerticesFromStart {
    pathVerticesFromStartString.append(vertex.identifier)
}

print(pathVerticesFromStartString.joined(separator: "->"))


