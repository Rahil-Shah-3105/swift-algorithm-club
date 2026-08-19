import XCTest

class SplayTreeTests: XCTestCase {
   
    var tree1: SplayTree<Int>!
    var tree2: SplayTree<Int>!
    
    override func setUp() {
		print(">>> Entering setUp()")
        super.setUp()
        tree1 = SplayTree<Int>(value: 1)
        
		print("setUp(): tree1 → \(tree1)")
        tree2 = SplayTree<Int>(value: 1)
        tree2.insert(value: 10)
        tree2.insert(value: 20)
        tree2.insert(value: 3)
        tree2.insert(value: 6)
        tree2.insert(value: 100)
        tree2.insert(value: 44)
		print("setUp(): tree2 → \(tree2)")
		print("<<< Exiting setUp()")
    }
    
    func testInsertion() {
		print(">>> Entering testInsertion()")
        tree1.insert(value: 10)
        assert(tree1.value == 10)
        
        tree2.insert(value: 2)
        assert(tree2.root?.value == 2)
		print("<<< Exiting testInsertion()")
    }
    
    func testSearchNonExisting() {
		print(">>> Entering testSearchNonExisting()")
        let t = tree2.search(value: 5)
        assert(t?.value == 10)
		print("testSearchNonExisting(): t → \(t)")
		print("<<< Exiting testSearchNonExisting()")
    }

    func testSearchExisting() {
		print(">>> Entering testSearchExisting()")
        let t = tree2.search(value: 6)
        assert(t?.value == 6)
		print("testSearchExisting(): t → \(t)")
		print("<<< Exiting testSearchExisting()")
    }
    
    func testDeleteExistingOnlyLeftChild() {
		print(">>> Entering testDeleteExistingOnlyLeftChild()")
        tree2.remove(value: 3)
        assert(tree2.value == 6)
		print("<<< Exiting testDeleteExistingOnlyLeftChild()")
    }

    func testDeleteExistingOnly2Children() {
		print(">>> Entering testDeleteExistingOnly2Children()")
        tree2.remove(value: 6)
        assert(tree2.value == 20)
		print("<<< Exiting testDeleteExistingOnly2Children()")
    }
    
    func testDeleteRoot() {
		print(">>> Entering testDeleteRoot()")
        tree2.remove(value: 44)
        assert(tree2.value == 100)
		print("<<< Exiting testDeleteRoot()")
    }
    
    func testMinimum() {
		print(">>> Entering testMinimum()")
        let v = tree2.minimum()
        assert(v?.value == 1)
		print("testMinimum(): v → \(v)")
		print("<<< Exiting testMinimum()")
    }

    func testMaximum() {
		print(">>> Entering testMaximum()")
        let v = tree2.maximum()
        assert(v?.value == 100)
		print("testMaximum(): v → \(v)")
		print("<<< Exiting testMaximum()")
    }
    
    func testInsertionRemovals() {
		print(">>> Entering testInsertionRemovals()")
        let splayTree = SplayTree(value: 1)
        splayTree.insert(value: 2)
        splayTree.insert(value: 10)
        splayTree.insert(value: 6)
        
		print("testInsertionRemovals(): splayTree → \(splayTree)")
        splayTree.remove(value: 10)
        splayTree.remove(value: 6)
        
        assert(splayTree.value == 2)
		print("<<< Exiting testInsertionRemovals()")
    }
    
}
