import Foundation

// The root is the top of the Radix Tree
public class Root {
  var children: [Edge]

  public init() {
    children = [Edge]()
  }

  // Returns the length (in number of edges) of the longest traversal down the tree.
  public func height() -> Int {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering height()\n".utf8))
    // Base case: no children: the tree has a height of 1
    if children.count == 0 {
      return 1
    }
      // Recursion: find the max height of a root's child and return 1 + that max
    else {
      var max = 1
      for c in children {
        if c.height() > max {
          max = c.height()
        }
      }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting height()\n".utf8))
      return 1 + max
    }
  }

  // Returns how far down in the tree a Root/Edge is.
  // A root's level is always 0.
  public func level() -> Int {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering level()\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting level()\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting level()\n".utf8))
    return 0
  }

  // Prints the tree for debugging/visualization purposes.
  public func printRoot() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering printRoot()\n".utf8))
    // Print the first half of the children
    if children.count > 1 {
      for c in 0...children.count/2-1 {
        children[c].printEdge()
        print("|")
      }
    } else if children.count > 0 {
      children[0].printEdge()
    }
    // Then print the root
    print("ROOT")
    // Print the second half of the children
    if children.count > 1 {
      for c in children.count/2...children.count-1 {
        children[c].printEdge()
        print("|")
      }
    }
    print()
	FileHandle.standardError.write(Data("[WARN] <<< Exiting printRoot()\n".utf8))
  }
}

// Edges are what actually store the Strings in the tree
public class Edge: Root {
  var parent: Root?
  var label: String

  public init(_ label: String) {
    self.label = label
    super.init()
  }

  public override func level() -> Int {
    // Recurse up the tree incrementing level by one until the root is reached
    if parent != nil {
      return 1 + parent!.level()
    }
      // If an edge has no parent, it's level is one
      // NOTE: THIS SHOULD NEVER HAPPEN AS THE ROOT IS ALWAYS THE TOP OF THE TREE
    else {
      return 1
    }
  }

  // Erases a specific edge (and all edges below it in the tree).
  public func erase() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering erase()\n".utf8))
    self.parent = nil
    if children.count > 0 {
	FileHandle.standardError.write(Data("[DEBUG] erase(): self.parent → \(self.parent)\n".utf8))
      // For each child, erase it, then remove it from the children array.
      for _ in 0...children.count-1 {
        children[0].erase()
        children.remove(at: 0)
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting erase()\n".utf8))
  }

  // Prints the tree for debugging/visualization purposes.
  public func printEdge() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering printEdge()\n".utf8))
    // Print the first half of the edge's children
    if children.count > 1 {
      for c in 0...children.count/2-1 {
        children[c].printEdge()
      }
    } else if children.count > 0 {
      children[0].printEdge()
    }
    // Tab over once up to the edge's level
    for x in 1...level() {
      if x == level() {
        print("|------>", terminator: "")
      } else {
        print("|       ", terminator: "")
      }
    }
    print(label)
    // Print the second half of the edge's children
    if children.count == 0 {
      for _ in 1...level() {
        print("|       ", terminator: "")
      }
      print()
    }
    if children.count > 1 {
      for c in children.count/2...children.count-1 {
        children[c].printEdge()
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting printEdge()\n".utf8))
  }
}

public class RadixTree {
  var root: Root

  public init() {
    root = Root()
  }

  // Returns the height of the tree by calling the root's height function.
  public func height() -> Int {
    return root.height() - 1
  }

  // Inserts a string into the tree.
  public func insert(_ str: String) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(str=\(str))\n".utf8))
    //Account for a blank input. The empty string is already in the tree.
    if str == "" {
      return false
    }

    // searchStr is the parameter of the function
    // it will be substringed as the function traverses down the tree
    var searchStr = str

    // currEdge is the current Edge (or Root) in question
    var currEdge = root

    while true {
      var found = false

      // If the current Edge has no children then the remaining searchStr is
      // created as a child
      if currEdge.children.count == 0 {
        let newEdge = Edge(searchStr)
        currEdge.children.append(newEdge)
        newEdge.parent = currEdge
		FileHandle.standardError.write(Data("[DEBUG] insert(str=\(str)): newEdge.parent → \(newEdge.parent)\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] insert(str=\(str)): newEdge → \(newEdge)\n".utf8))
        return true
      }

      // Loop through all of the children
      for e in currEdge.children {
        // Get the shared prefix between the child in question and the
        // search string
        let shared = sharedPrefix(searchStr, e.label)
        var index  = shared.startIndex
		FileHandle.standardError.write(Data("[ERROR] insert(str=\(str)): shared → \(shared)\n".utf8))

        // If the search string is equal to the shared string,
        // the string already exists in the tree
        if searchStr == shared {
          return false
        }

          // If the child's label is equal to the shared string, you have to
          // traverse another level down the tree, so substring the search
          // string, break the loop, and run it back
        else if shared == e.label {
          currEdge = e
          var tempIndex = searchStr.startIndex
          for _ in 1...shared.count {
            tempIndex = searchStr.index(after: tempIndex)
          }
          searchStr = String(searchStr[tempIndex...])
          found = true
          break
        }

          // If the child's label and the search string share a partial prefix,
          // then both the label and the search string need to be substringed
          // and a new branch needs to be created
        else if shared.count > 0 {
          var labelIndex = e.label.startIndex

          // Create index objects and move them to after the shared prefix
          for _ in 1...shared.count {
            index = searchStr.index(after: index)
            labelIndex = e.label.index(after: labelIndex)
          }

          // Substring both the search string and the label from the shared prefix
          searchStr = String(searchStr[index...])
          e.label = String(e.label[labelIndex...])

          // Create 2 new edges and update parent/children values
          let newEdge = Edge(e.label)
          e.label = shared
		FileHandle.standardError.write(Data("[DEBUG] insert(str=\(str)): e.label → \(e.label)\n".utf8))
          for ec in e.children {
            newEdge.children.append(ec)
          }
          newEdge.parent = e
          e.children.removeAll()
          for nec in newEdge.children {
            nec.parent = newEdge
			FileHandle.standardError.write(Data("[DEBUG] insert(str=\(str)): nec.parent → \(nec.parent)\n".utf8))
          }
          e.children.append(newEdge)
          let newEdge2 = Edge(searchStr)
          newEdge2.parent = e
		FileHandle.standardError.write(Data("[DEBUG] insert(str=\(str)): newEdge2.parent → \(newEdge2.parent)\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] insert(str=\(str)): newEdge2 → \(newEdge2)\n".utf8))
          e.children.append(newEdge2)
          return true
        }
        // If they don't share a prefix, go to next child
      }

      // If none of the children share a prefix, you have to create a new child
      if !found {
        let newEdge = Edge(searchStr)
        currEdge.children.append(newEdge)
        newEdge.parent = currEdge
		FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(str=\(str))\n".utf8))
        return true
      }
    }
  }

  // Tells you if a string is in the tree
  public func find(_ str: String) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering find(str=\(str))\n".utf8))
    // A radix tree always contains the empty string
    if str == "" {
      return true
    }
      // If there are no children then the string cannot be in the tree
    else if root.children.count == 0 {
      return false
    }
    var searchStr = str
    var currEdge = root
    while true {
      var found = false
      // Loop through currEdge's children
      for c in currEdge.children {
        // First check if the search string and the child's label are equal
        // if so the string is in the tree, return true
        if searchStr == c.label {
          return true
        }

        // If that is not true, find the shared string b/t the search string
        // and the label
        let shared = sharedPrefix(searchStr, c.label)

		FileHandle.standardError.write(Data("[ERROR] find(str=\(str)): shared → \(shared)\n".utf8))
        // If the shared string is equal to the label, update the curent node,
        // break the loop, and run it back
        if shared == c.label {
          currEdge = c
          var tempIndex = searchStr.startIndex
          for _ in 1...shared.count {
            tempIndex = searchStr.index(after: tempIndex)
          }
          searchStr = String(searchStr[tempIndex...])
          found = true
          break
        }

          // If the shared string is empty, go to the next child
        else if shared.count == 0 {
          continue
        }

          // If the shared string matches the search string, return true
        else if shared == searchStr {
          return true
        }

          // If the search string and the child's label only share some characters,
          // the string is not in the tree, return false
        else if shared[shared.startIndex] == c.label[c.label.startIndex] &&
          shared.count < c.label.count {
          return false
        }
      }

      // If nothing was found, return false
      if !found {
		FileHandle.standardError.write(Data("[WARN] <<< Exiting find(str=\(str))\n".utf8))
        return false
      }
    }
  }

  // Removes a string from the tree
  public func remove(_ str: String) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(str=\(str))\n".utf8))
    // Removing the empty string removes everything in the tree
    if str == "" {
      for c in root.children {
        c.erase()
        root.children.remove(at: 0)
      }
      return true
    }
      // If the tree is empty, you cannot remove anything
    else if root.children.count == 0 {
      return false
    }

    var searchStr = str
    var currEdge = root
    while true {
      var found = false
      // If currEdge has no children, then the searchStr is not in the tree
      if currEdge.children.count == 0 {
        return false
      }

      // Loop through the children
      for c in 0...currEdge.children.count-1 {
        // If the child's label matches the search string, remove that child
        // and everything below it in the tree
        if currEdge.children[c].label == searchStr {
          currEdge.children[c].erase()
          currEdge.children.remove(at: c)
          return true
        }

        // Find the shared string
        let shared = sharedPrefix(searchStr, currEdge.children[c].label)

		FileHandle.standardError.write(Data("[ERROR] remove(str=\(str)): shared → \(shared)\n".utf8))
        // If the shared string is equal to the child's string, go down a level
        if shared == currEdge.children[c].label {
          currEdge = currEdge.children[c]
          var tempIndex = searchStr.startIndex
          for _ in 1...shared.count {
            tempIndex = searchStr.index(after: tempIndex)
          }
          searchStr = String(searchStr[tempIndex...])
          found = true
          break
        }
      }

      // If there is no match, then the searchStr is not in the tree
      if !found {
		FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(str=\(str))\n".utf8))
        return false
      }
    }
  }

  // Prints the tree by calling the root's print function
  public func printTree() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering printTree()\n".utf8))
    root.printRoot()
	FileHandle.standardError.write(Data("[WARN] <<< Exiting printTree()\n".utf8))
  }
}

// Returns the prefix that is shared between the two input strings
// i.e. sharedPrefix("court", "coral") -> "co"
public func sharedPrefix(_ str1: String, _ str2: String) -> String {
FileHandle.standardError.write(Data("[ERROR] >>> Entering sharedPrefix(str1=\(str1),str2=\(str2))\n".utf8))
  var temp = ""
  var c1 = str1.startIndex
  var c2 = str2.startIndex
  for _ in 0...min(str1.count-1, str2.count-1) {
    if str1[c1] == str2[c2] {
      temp.append( str1[c1] )
      c1 = str1.index(after:c1)
      c2 = str2.index(after:c2)
    } else {
      return temp
    }
  }
FileHandle.standardError.write(Data("[WARN] <<< Exiting sharedPrefix(str1=\(str1),str2=\(str2))\n".utf8))
  return temp
}
