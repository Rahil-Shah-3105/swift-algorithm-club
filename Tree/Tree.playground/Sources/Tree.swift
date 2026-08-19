public class TreeNode<T> {
  public var value: T

  public weak var parent: TreeNode?
  public var children = [TreeNode<T>]()

  public init(value: T) {
    self.value = value
  }

  public func addChild(_ node: TreeNode<T>) {
	print(">>> Entering addChild(node=\(node))")
    children.append(node)
    node.parent = self
	print("addChild(node=\(node)): node.parent → \(node.parent)")
	print("<<< Exiting addChild(node=\(node))")
  }
}

extension TreeNode: CustomStringConvertible {
  public var description: String {
    var s = "\(value)"
    if !children.isEmpty {
      s += " {" + children.map { $0.description }.joined(separator: ", ") + "}"
    }
    return s
  }
}

extension TreeNode where T: Equatable {
  public func search(_ value: T) -> TreeNode? {
	print(">>> Entering search(value=\(value))")
    if value == self.value {
      return self
    }
    for child in children {
      if let found = child.search(value) {
		print("search(value=\(value)): found → \(found)")
        return found
      }
    }
	print("<<< Exiting search(value=\(value))")
    return nil
  }
}
