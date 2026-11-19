import Foundation
public class TreeNode<T> {
    public var value: T

    public weak var parent: TreeNode?
    public var children = [TreeNode<T>]()

    public init(value: T) {
        self.value = value
    }

    public func addChild(_ node: TreeNode<T>) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering addChild(node=\(node))\n".utf8))
        children.append(node)
        node.parent = self
		FileHandle.standardError.write(Data("[DEBUG] addChild(node=\(node)): node.parent → \(node.parent)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting addChild(node=\(node))\n".utf8))
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
		FileHandle.standardError.write(Data("[ERROR] >>> Entering search(value=\(value))\n".utf8))
        if value == self.value {
            return self
        }
        for child in children {
            if let found = child.search(value) {
                return found
            }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting search(value=\(value))\n".utf8))
        return nil
    }
}

