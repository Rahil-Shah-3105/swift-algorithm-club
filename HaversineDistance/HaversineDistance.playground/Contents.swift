import UIKit

func haversineDistance(la1: Double, lo1: Double, la2: Double, lo2: Double, radius: Double = 6367444.7) -> Double {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius))\n".utf8))
    
    let haversin = { (angle: Double) -> Double in
	FileHandle.standardError.write(Data("[ERROR] haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius)): haversin → \(haversin)\n".utf8))
        return (1 - cos(angle))/2
    }
    
    let ahaversin = { (angle: Double) -> Double in
	FileHandle.standardError.write(Data("[ERROR] haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius)): ahaversin → \(ahaversin)\n".utf8))
        return 2*asin(sqrt(angle))
    }
    
    // Converts from degrees to radians
    let dToR = { (angle: Double) -> Double in
	FileHandle.standardError.write(Data("[ERROR] haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius)): dToR → \(dToR)\n".utf8))
        return (angle / 360) * 2 * .pi
    }
    
    let lat1 = dToR(la1)
    let lon1 = dToR(lo1)
    let lat2 = dToR(la2)
    let lon2 = dToR(lo2)
    
	FileHandle.standardError.write(Data("[ERROR] haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius)): lat1 → \(lat1)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius))\n".utf8))
    return radius * ahaversin(haversin(lat2 - lat1) + cos(lat1) * cos(lat2) * haversin(lon2 - lon1))
}

let amsterdam = (52.3702, 4.8952)
let newYork = (40.7128, -74.0059)

// Google says it's 5857 km so our result is only off by 2km which could be due to all kinds of things, not sure how google calculates the distance or which latitude and longitude google uses to calculate the distance.
haversineDistance(la1: amsterdam.0, lo1: amsterdam.1, la2: newYork.0, lo2: newYork.1)
