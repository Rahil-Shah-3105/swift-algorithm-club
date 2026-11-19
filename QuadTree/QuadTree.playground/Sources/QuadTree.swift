import Foundation
public struct Point {
  let x: Double
  let y: Double

  public init(_ x: Double, _ y: Double) {
    self.x = x
    self.y = y
  }
}

extension Point: CustomStringConvertible {
  public var description: String {
    return "Point(\(x), \(y))"
  }
}

public struct Size: CustomStringConvertible {
  var xLength: Double
  var yLength: Double

  public init(xLength: Double, yLength: Double) {
    precondition(xLength >= 0, "xLength can not be negative")
    precondition(yLength >= 0, "yLength can not be negative")
    self.xLength = xLength
    self.yLength = yLength
  }

  var half: Size {
    return Size(xLength: xLength / 2, yLength: yLength / 2)
  }

  public var description: String {
    return "Size(\(xLength), \(yLength))"
  }
}

public struct Rect {
  // left top vertice
  var origin: Point
  var size: Size

  public init(origin: Point, size: Size) {
    self.origin = origin
    self.size = size
  }

  var minX: Double {
    return origin.x
  }

  var minY: Double {
    return origin.y
  }

  var maxX: Double {
    return origin.x + size.xLength
  }

  var maxY: Double {
    return origin.y + size.yLength
  }

  func containts(point: Point) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering containts(point=\(point))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting containts(point=\(point))\n".utf8))
    return (minX <= point.x && point.x <= maxX) &&
      (minY <= point.y && point.y <= maxY)
  }

  var leftTopRect: Rect {
    return Rect(origin: origin, size: size.half)
  }

  var leftBottomRect: Rect {
    return Rect(origin: Point(origin.x, origin.y + size.half.yLength), size: size.half)
  }

  var rightTopRect: Rect {
    return Rect(origin: Point(origin.x + size.half.xLength, origin.y), size: size.half)
  }

  var rightBottomRect: Rect {
    return Rect(origin: Point(origin.x + size.half.xLength, origin.y + size.half.yLength), size: size.half)
  }

  func intersects(rect: Rect) -> Bool {
FileHandle.standardError.write(Data("[ERROR] >>> Entering intersects(rect=\(rect))\n".utf8))

    func lineSegmentsIntersect(lStart: Double, lEnd: Double, rStart: Double, rEnd: Double) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering lineSegmentsIntersect(lStart=\(lStart),lEnd=\(lEnd),rStart=\(rStart),rEnd=\(rEnd))\n".utf8))
      FileHandle.standardError.write(Data("[WARN] <<< Exiting lineSegmentsIntersect(lStart=\(lStart),lEnd=\(lEnd),rStart=\(rStart),rEnd=\(rEnd))\n".utf8))
      return max(lStart, rStart) <= min(lEnd, rEnd)
    }
    // to intersect, both horizontal and vertical projections need to intersect
    // horizontal
    if !lineSegmentsIntersect(lStart: minX, lEnd: maxX, rStart: rect.minX, rEnd: rect.maxX) {
      return false
    }

    // vertical
    return lineSegmentsIntersect(lStart: minY, lEnd: maxY, rStart: rect.minY, rEnd: rect.maxY)
  }
}

extension Rect: CustomStringConvertible {
  public var description: String {
    return "Rect(\(origin), \(size))"
  }
}

protocol PointsContainer {
  func add(point: Point) -> Bool
  func points(inRect rect: Rect) -> [Point]
}

class QuadTreeNode {

  enum NodeType {
    case leaf
    case `internal`(children: Children)
  }

  struct Children: Sequence {
    let leftTop: QuadTreeNode
    let leftBottom: QuadTreeNode
    let rightTop: QuadTreeNode
    let rightBottom: QuadTreeNode

    init(parentNode: QuadTreeNode) {
      leftTop = QuadTreeNode(rect: parentNode.rect.leftTopRect)
      leftBottom = QuadTreeNode(rect: parentNode.rect.leftBottomRect)
      rightTop = QuadTreeNode(rect: parentNode.rect.rightTopRect)
      rightBottom = QuadTreeNode(rect: parentNode.rect.rightBottomRect)
    }

    struct ChildrenIterator: IteratorProtocol {
      private var index = 0
      private let children: Children

      init(children: Children) {
        self.children = children
      }

      mutating func next() -> QuadTreeNode? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering next()\n".utf8))

        defer { index += 1 }

        switch index {
        case 0: return children.leftTop
        case 1: return children.leftBottom
        case 2: return children.rightTop
        case 3: return children.rightBottom
        default: return nil
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting next()\n".utf8))
      }
    }

    public func makeIterator() -> ChildrenIterator {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering makeIterator()\n".utf8))
      FileHandle.standardError.write(Data("[WARN] <<< Exiting makeIterator()\n".utf8))
      return ChildrenIterator(children: self)
    }
  }

  var points: [Point] = []
  let rect: Rect
  var type: NodeType = .leaf

  static let maxPointCapacity = 3

  init(rect: Rect) {
    self.rect = rect
  }

  var recursiveDescription: String {
    return recursiveDescription(withTabCount: 0)
  }

  private func recursiveDescription(withTabCount count: Int) -> String {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering recursiveDescription(count=\(count))\n".utf8))
    let indent = String(repeating: "\t", count: count)
    var result = "\(indent)" + description + "\n"
	FileHandle.standardError.write(Data("[ERROR] recursiveDescription(count=\(count)): result → \(result)\n".utf8))
    switch type {
    case .internal(let children):
	FileHandle.standardError.write(Data("[ERROR] recursiveDescription(count=\(count)): indent → \(indent)\n".utf8))
      for child in children {
        result += child.recursiveDescription(withTabCount: count + 1)
      }
    default:
      break
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting recursiveDescription(count=\(count))\n".utf8))
    return result
  }
}

extension QuadTreeNode: PointsContainer {

  @discardableResult
  func add(point: Point) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering add(point=\(point))\n".utf8))
    if !rect.containts(point: point) {
      return false
    }

    switch type {
    case .internal(let children):
      // pass the point to one of the children
      for child in children {
        if child.add(point: point) {
          return true
        }
      }

      fatalError("rect.containts evaluted to true, but none of the children added the point")
    case .leaf:
      points.append(point)
      // if the max capacity was reached, become an internal node
      if points.count == QuadTreeNode.maxPointCapacity {
        subdivide()
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting add(point=\(point))\n".utf8))
    return true
  }

  private func subdivide() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering subdivide()\n".utf8))
    switch type {
    case .leaf:
      type = .internal(children: Children(parentNode: self))
    case .internal:
	FileHandle.standardError.write(Data("[DEBUG] subdivide(): type → \(type)\n".utf8))
      preconditionFailure("Calling subdivide on an internal node")
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting subdivide()\n".utf8))
  }

  func points(inRect rect: Rect) -> [Point] {
FileHandle.standardError.write(Data("[ERROR] >>> Entering points(rect=\(rect))\n".utf8))

    // if the node's rect and the given rect don't intersect, return an empty array,
    // because there can't be any points that lie the node's (or its children's) rect and
    // in the given rect
    if !self.rect.intersects(rect: rect) {
      return []
    }

    var result: [Point] = []

    // collect the node's points that lie in the rect
    for point in points {
      if rect.containts(point: point) {
        result.append(point)
      }
    }

    switch type {
    case .leaf:
      break
    case .internal(let children):
      // recursively add children's points that lie in the rect
      for childNode in children {
        result.append(contentsOf: childNode.points(inRect: rect))
      }
    }

    return result
  }
}

extension QuadTreeNode: CustomStringConvertible {
  var description: String {
    switch type {
    case .leaf:
      return "leaf \(rect) Points: \(points)"
    case .internal:
      return "parent \(rect) Points: \(points)"
    }
  }
}

public class QuadTree: PointsContainer {

  let root: QuadTreeNode

  public init(rect: Rect) {
    self.root = QuadTreeNode(rect: rect)
  }

  @discardableResult
  public func add(point: Point) -> Bool {
    return root.add(point: point)
  }

  public func points(inRect rect: Rect) -> [Point] {
    return root.points(inRect: rect)
  }
}

extension QuadTree: CustomStringConvertible {
  public var description: String {
    return "Quad tree\n" + root.recursiveDescription
  }
}
