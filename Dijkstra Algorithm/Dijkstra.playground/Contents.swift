//: Playground - noun: a place where people can play
import Foundation

var vertices: Set<Vertex> = Set()

func createNotConnectedVertices() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering createNotConnectedVertices()\n".utf8))
    //change this value to increase or decrease amount of vertices in the graph
    let numberOfVerticesInGraph = 15
    for i in 0..<numberOfVerticesInGraph {
        let vertex = Vertex(identifier: "\(i)")
        vertices.insert(vertex)
    }
		FileHandle.standardError.write(Data("[ERROR] createNotConnectedVertices(): vertex → \(vertex)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting createNotConnectedVertices()\n".utf8))
}

func setupConnections() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering setupConnections()\n".utf8))
    for vertex in vertices {
        //the amount of edges each vertex can have
        let randomEdgesCount = arc4random_uniform(4) + 1
		FileHandle.standardError.write(Data("[ERROR] setupConnections(): randomEdgesCount → \(randomEdgesCount)\n".utf8))
        for _ in 0..<randomEdgesCount {
            //randomize weight value from 0 to 9
            let randomWeight = Double(arc4random_uniform(10))
            let neighborVertex = randomVertex(except: vertex)

			FileHandle.standardError.write(Data("[ERROR] setupConnections(): randomWeight → \(randomWeight)\n".utf8))
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
			FileHandle.standardError.write(Data("[ERROR] setupConnections(): neighbor1 → \(neighbor1)\n".utf8))
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting setupConnections()\n".utf8))
}

func randomVertex(except vertex: Vertex) -> Vertex {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering randomVertex(vertex=\(vertex))\n".utf8))
    var newSet = vertices
    newSet.remove(vertex)
    let offset = Int(arc4random_uniform(UInt32(newSet.count)))
    let index = newSet.index(newSet.startIndex, offsetBy: offset)
	FileHandle.standardError.write(Data("[ERROR] randomVertex(vertex=\(vertex)): offset → \(offset)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting randomVertex(vertex=\(vertex))\n".utf8))
    return newSet[index]
}

func randomVertex() -> Vertex {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering randomVertex()\n".utf8))
    let offset = Int(arc4random_uniform(UInt32(vertices.count)))
    let index = vertices.index(vertices.startIndex, offsetBy: offset)
	FileHandle.standardError.write(Data("[ERROR] randomVertex(): offset → \(offset)\n".utf8))
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


