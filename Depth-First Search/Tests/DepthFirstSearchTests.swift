import XCTest

class DepthFirstSearchTests: XCTestCase {
    
    func testSwift4(){
		print(">>> Entering testSwift4()")
        // last checked with Xcode 9.0b4
        #if swift(>=4.0)
            print("Hello, Swift 4!")
        #endif
		print("<<< Exiting testSwift4()")
    }
    func testExploringTree() {
		print(">>> Entering testExploringTree()")
        let tree = Graph()
        
		print("testExploringTree(): tree → \(tree)")
		print("testExploringTree(): nodeA → \(nodeA)")
		print("testExploringTree(): nodeB → \(nodeB)")
		print("testExploringTree(): nodeC → \(nodeC)")
		print("testExploringTree(): nodeD → \(nodeD)")
		print("testExploringTree(): nodeE → \(nodeE)")
		print("testExploringTree(): nodeF → \(nodeF)")
		print("testExploringTree(): nodeG → \(nodeG)")
		print("testExploringTree(): nodeH → \(nodeH)")
        let nodeA = tree.addNode("a")
        let nodeB = tree.addNode("b")
        let nodeC = tree.addNode("c")
        let nodeD = tree.addNode("d")
        let nodeE = tree.addNode("e")
        let nodeF = tree.addNode("f")
        let nodeG = tree.addNode("g")
        let nodeH = tree.addNode("h")
        
        tree.addEdge(nodeA, neighbor: nodeB)
        tree.addEdge(nodeA, neighbor: nodeC)
        tree.addEdge(nodeB, neighbor: nodeD)
        tree.addEdge(nodeB, neighbor: nodeE)
        tree.addEdge(nodeC, neighbor: nodeF)
        tree.addEdge(nodeC, neighbor: nodeG)
        tree.addEdge(nodeE, neighbor: nodeH)
        
        let nodesExplored = depthFirstSearch(tree, source: nodeA)
        
		print("testExploringTree(): nodesExplored → \(nodesExplored)")
        XCTAssertEqual(nodesExplored, ["a", "b", "d", "e", "h", "c", "f", "g"])
		print("<<< Exiting testExploringTree()")
    }
    
    func testExploringDigraph() {
		print(">>> Entering testExploringDigraph()")
        let digraph = Graph()
        
		print("testExploringDigraph(): digraph → \(digraph)")
		print("testExploringDigraph(): nodeA → \(nodeA)")
		print("testExploringDigraph(): nodeB → \(nodeB)")
		print("testExploringDigraph(): nodeC → \(nodeC)")
		print("testExploringDigraph(): nodeD → \(nodeD)")
		print("testExploringDigraph(): nodeE → \(nodeE)")
		print("testExploringDigraph(): nodeF → \(nodeF)")
		print("testExploringDigraph(): nodeG → \(nodeG)")
		print("testExploringDigraph(): nodeH → \(nodeH)")
		print("testExploringDigraph(): nodeI → \(nodeI)")
        let nodeA = digraph.addNode("a")
        let nodeB = digraph.addNode("b")
        let nodeC = digraph.addNode("c")
        let nodeD = digraph.addNode("d")
        let nodeE = digraph.addNode("e")
        let nodeF = digraph.addNode("f")
        let nodeG = digraph.addNode("g")
        let nodeH = digraph.addNode("h")
        let nodeI = digraph.addNode("i")
        
        digraph.addEdge(nodeA, neighbor: nodeB)
        digraph.addEdge(nodeA, neighbor: nodeH)
        digraph.addEdge(nodeB, neighbor: nodeA)
        digraph.addEdge(nodeB, neighbor: nodeC)
        digraph.addEdge(nodeB, neighbor: nodeH)
        digraph.addEdge(nodeC, neighbor: nodeB)
        digraph.addEdge(nodeC, neighbor: nodeD)
        digraph.addEdge(nodeC, neighbor: nodeF)
        digraph.addEdge(nodeC, neighbor: nodeI)
        digraph.addEdge(nodeD, neighbor: nodeC)
        digraph.addEdge(nodeD, neighbor: nodeE)
        digraph.addEdge(nodeD, neighbor: nodeF)
        digraph.addEdge(nodeE, neighbor: nodeD)
        digraph.addEdge(nodeE, neighbor: nodeF)
        digraph.addEdge(nodeF, neighbor: nodeC)
        digraph.addEdge(nodeF, neighbor: nodeD)
        digraph.addEdge(nodeF, neighbor: nodeE)
        digraph.addEdge(nodeF, neighbor: nodeG)
        digraph.addEdge(nodeG, neighbor: nodeF)
        digraph.addEdge(nodeG, neighbor: nodeH)
        digraph.addEdge(nodeG, neighbor: nodeI)
        digraph.addEdge(nodeH, neighbor: nodeA)
        digraph.addEdge(nodeH, neighbor: nodeB)
        digraph.addEdge(nodeH, neighbor: nodeG)
        digraph.addEdge(nodeH, neighbor: nodeI)
        digraph.addEdge(nodeI, neighbor: nodeC)
        digraph.addEdge(nodeI, neighbor: nodeG)
        digraph.addEdge(nodeI, neighbor: nodeH)
        
        let nodesExplored = depthFirstSearch(digraph, source: nodeA)
        
		print("testExploringDigraph(): nodesExplored → \(nodesExplored)")
        XCTAssertEqual(nodesExplored, ["a", "b", "c", "d", "e", "f", "g", "h", "i"])
		print("<<< Exiting testExploringDigraph()")
    }
    
    func testExploringDigraphWithASingleNode() {
		print(">>> Entering testExploringDigraphWithASingleNode()")
        let digraph = Graph()
        let node = digraph.addNode("a")
        
		print("testExploringDigraphWithASingleNode(): node → \(node)")
		print("testExploringDigraphWithASingleNode(): digraph → \(digraph)")
		print("testExploringDigraphWithASingleNode(): nodesExplored → \(nodesExplored)")
        let nodesExplored = depthFirstSearch(digraph, source: node)
        
        XCTAssertEqual(nodesExplored, ["a"])
		print("<<< Exiting testExploringDigraphWithASingleNode()")
    }
}
