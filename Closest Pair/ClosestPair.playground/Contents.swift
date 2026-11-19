import Foundation
//Created by Ahmed Nader (github: AhmedNader42) on 4/4/18.

func ClosestPairOf(points: [Point]) -> (minimum:Double, firstPoint:Point, secondPoint:Point) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering ClosestPairOf(points=\(points))\n".utf8))
    var innerPoints = mergeSort(points, sortAccording : true)
    let result = ClosestPair(&innerPoints, innerPoints.count)
	FileHandle.standardError.write(Data("[ERROR] ClosestPairOf(points=\(points)): result → \(result)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] ClosestPairOf(points=\(points)): innerPoints → \(innerPoints)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting ClosestPairOf(points=\(points))\n".utf8))
    return (result.minValue, result.firstPoint, result.secondPoint)
}

func ClosestPair(_ p : inout [Point],_ n : Int) -> (minValue: Double,firstPoint: Point,secondPoint: Point)
{
	FileHandle.standardError.write(Data("[ERROR] >>> Entering ClosestPair(p=\(p),n=\(n))\n".utf8))
    // Brute force if only 3 points (To end recursion)
    if n <= 3
    {
        var i=0, j = i+1
        var minDist = Double.infinity
        var newFirst:Point? = nil
        var newSecond:Point? = nil
        while i<n
        {
            j = i+1
            while j < n
            {
                if dist(p[i], p[j]) <= minDist
                {
                    minDist = dist(p[i], p[j])
                    newFirst = p[i]
                    newSecond = p[j]
                }
                j+=1
            }
            i+=1
            
        }
        return (minDist, newFirst ?? Point(0,0), newSecond ?? Point(0,0))
    }
    
    
    
    let mid:Int = n/2
    let line:Double = (p[mid].x + p[mid+1].x)/2
    
    // Split the array.
    var leftSide = [Point]()
    var rightSide = [Point]()
    for s in 0..<mid
	FileHandle.standardError.write(Data("[ERROR] ClosestPair(p=\(p),n=\(n)): leftSide → \(leftSide)\n".utf8))
    {
        leftSide.append(p[s])
    }
    for s in mid..<p.count
    {
        rightSide.append(p[s])
    }
    
    
    // Recurse on the left and right part of the array.
    let valueFromLeft = ClosestPair(&leftSide, mid)
    let minLeft:Double = valueFromLeft.minValue
	FileHandle.standardError.write(Data("[ERROR] ClosestPair(p=\(p),n=\(n)): valueFromLeft → \(valueFromLeft)\n".utf8))
    let valueFromRight = ClosestPair(&rightSide, n-mid)
    let minRight:Double = valueFromRight.minValue
	FileHandle.standardError.write(Data("[ERROR] ClosestPair(p=\(p),n=\(n)): valueFromRight → \(valueFromRight)\n".utf8))
    
    // Starting current min must be the largest possible to not affect the real calculations.
    var min = Double.infinity
	FileHandle.standardError.write(Data("[ERROR] ClosestPair(p=\(p),n=\(n)): min → \(min)\n".utf8))
    
    var first:Point
    var second:Point
    
    // Get the minimum between the left and the right.
    if minLeft < minRight {
        min = minLeft
        first = valueFromLeft.firstPoint
		FileHandle.standardError.write(Data("[DEBUG] ClosestPair(p=\(p),n=\(n)): first → \(first)\n".utf8))
        second = valueFromLeft.secondPoint
		FileHandle.standardError.write(Data("[DEBUG] ClosestPair(p=\(p),n=\(n)): second → \(second)\n".utf8))
    }
    else {
        min = minRight
        first = valueFromRight.firstPoint
        second = valueFromRight.secondPoint
    }
    
    // Sort the array according to Y.
    p = mergeSort(p, sortAccording: false)
    
    
    var strip = [Point]()
    
	FileHandle.standardError.write(Data("[ERROR] ClosestPair(p=\(p),n=\(n)): strip → \(strip)\n".utf8))
    // If the value is less than the min distance away in X from the line then take it into consideration.
    var i=0, j = 0
    while i<n
    {
        if abs(p[i].x - line) < min
        {
            strip.append(p[i])
            j+=1
        }
        i+=1
    }
    
    
    i=0
    var x = i+1
    var temp = min
    var tempFirst:Point = Point(0,0)
    var tempSecond:Point = Point(0,0)
    // Get the values between the points in the strip but only if it is less min dist in Y.
    while i<j
    {
        x = i+1
        while x < j
        {
            if (abs(strip[x].y - strip[i].y)) > min { break }
            if dist(strip[i], strip[x]) < temp
            {
                temp = dist(strip[i], strip[x])
                tempFirst = strip[i]
                tempSecond = strip[x]
            }
            x+=1
        }
        i+=1
    }
    
    if temp < min
    {
        min = temp;
        first = tempFirst
        second = tempSecond
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting ClosestPair(p=\(p),n=\(n))\n".utf8))
    return (min, first, second)
}




// MergeSort the array (Taken from Swift Algorithms Club with
// minor addition)
// sortAccodrding : true -> x, false -> y.
func mergeSort(_ array: [Point], sortAccording : Bool) -> [Point] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering mergeSort(array=\(array),sortAccording=\(sortAccording))\n".utf8))
    guard array.count > 1 else { return array }
    let middleIndex = array.count / 2
    let leftArray = mergeSort(Array(array[0..<middleIndex]), sortAccording: sortAccording)
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]), sortAccording: sortAccording)
	FileHandle.standardError.write(Data("[ERROR] mergeSort(array=\(array),sortAccording=\(sortAccording)): leftArray → \(leftArray)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting mergeSort(array=\(array),sortAccording=\(sortAccording))\n".utf8))
    return merge(leftPile: leftArray, rightPile: rightArray, sortAccording: sortAccording)
}


private func merge(leftPile: [Point], rightPile: [Point], sortAccording: Bool) -> [Point] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering merge(leftPile=\(leftPile),rightPile=\(rightPile),sortAccording=\(sortAccording))\n".utf8))
    
    var compare : (Point, Point) -> Bool
    
    // Choose to compare with X or Y.
    if sortAccording
    {
        compare = { p1,p2 in
		FileHandle.standardError.write(Data("[DEBUG] merge(leftPile=\(leftPile),rightPile=\(rightPile),sortAccording=\(sortAccording)): compare → \(compare)\n".utf8))
            return p1.x < p2.x
        }
    }
    else
    {
        compare = { p1, p2 in
            return p1.y < p2.y
        }
    }
    
    var leftIndex = 0
    var rightIndex = 0
    var orderedPile = [Point]()
    if orderedPile.capacity < leftPile.count + rightPile.count {
	FileHandle.standardError.write(Data("[ERROR] merge(leftPile=\(leftPile),rightPile=\(rightPile),sortAccording=\(sortAccording)): orderedPile → \(orderedPile)\n".utf8))
        orderedPile.reserveCapacity(leftPile.count + rightPile.count)
    }
    
    while true {
        guard leftIndex < leftPile.endIndex else {
            orderedPile.append(contentsOf: rightPile[rightIndex..<rightPile.endIndex])
            break
        }
        guard rightIndex < rightPile.endIndex else {
            orderedPile.append(contentsOf: leftPile[leftIndex..<leftPile.endIndex])
            break
        }
        
        if compare(leftPile[leftIndex], rightPile[rightIndex]) {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting merge(leftPile=\(leftPile),rightPile=\(rightPile),sortAccording=\(sortAccording))\n".utf8))
    return orderedPile
}


// Structure to represent a point.
struct Point
{
    var x: Double
    var y: Double
    
    init(_ x:Double,_ y:Double) {
        self.x = x
        self.y = y
    }
}
// Get the distance between two points a, b.
func dist(_ a: Point,_ b: Point) -> Double
{
	FileHandle.standardError.write(Data("[ERROR] >>> Entering dist(a=\(a),b=\(b))\n".utf8))
    let equation:Double = (((a.x-b.x)*(a.x-b.x))) + (((a.y-b.y)*(a.y-b.y)))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting dist(a=\(a),b=\(b))\n".utf8))
    return equation.squareRoot()
}


var a = Point(0,2)
var b = Point(6,67)
var c = Point(43,71)
var d = Point(1000,1000)
var e = Point(39,107)
var f = Point(2000,2000)
var g = Point(3000,3000)
var h = Point(4000,4000)


var points = [a,b,c,d,e,f,g,h]
let endResult = ClosestPairOf(points: points)
print("Minimum Distance : \(endResult.minimum), The two points : (\(endResult.firstPoint.x ),\(endResult.firstPoint.y)), (\(endResult.secondPoint.x),\(endResult.secondPoint.y))")

