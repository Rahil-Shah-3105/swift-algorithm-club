import UIKit

func haversineDistance(la1: Double, lo1: Double, la2: Double, lo2: Double, radius: Double = 6367444.7) -> Double {
	print(">>> Entering haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius))")
    
    let haversin = { (angle: Double) -> Double in
	print("haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius)): haversin → \(haversin)")
        return (1 - cos(angle))/2
    }
    
    let ahaversin = { (angle: Double) -> Double in
	print("haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius)): ahaversin → \(ahaversin)")
        return 2*asin(sqrt(angle))
    }
    
    // Converts from degrees to radians
    let dToR = { (angle: Double) -> Double in
	print("haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius)): dToR → \(dToR)")
        return (angle / 360) * 2 * .pi
    }
    
    let lat1 = dToR(la1)
    let lon1 = dToR(lo1)
    let lat2 = dToR(la2)
    let lon2 = dToR(lo2)
    
	print("haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius)): lat1 → \(lat1)")
	print("haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius)): lon1 → \(lon1)")
	print("haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius)): lat2 → \(lat2)")
	print("haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius)): lon2 → \(lon2)")
	print("<<< Exiting haversineDistance(la1=\(la1),lo1=\(lo1),la2=\(la2),lo2=\(lo2),radius=\(radius))")
    return radius * ahaversin(haversin(lat2 - lat1) + cos(lat1) * cos(lat2) * haversin(lon2 - lon1))
}

let amsterdam = (52.3702, 4.8952)
let newYork = (40.7128, -74.0059)

// Google says it's 5857 km so our result is only off by 2km which could be due to all kinds of things, not sure how google calculates the distance or which latitude and longitude google uses to calculate the distance.
haversineDistance(la1: amsterdam.0, lo1: amsterdam.1, la2: newYork.0, lo2: newYork.1)
