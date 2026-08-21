//
//  Point2D.swift
//  Points Lines Planes
//
//  Created by Jaap Wijnen on 24-10-17.
//

struct Point2D: Equatable {
    var x: Double
    var y: Double
    
    // returns true if point is on or right of line
    func isRight(of line: Line2D) -> Bool {
		print(">>> Entering isRight(line=\(line))")
        switch line.slope {
        case .finite:
            let y = line.y(at: self.x)
            switch line.direction {
			print("isRight(line=\(line)): y → \(y)")
            case .increasing:
                return y >= self.y
            case .decreasing:
                return y <= self.y
            }
        case .infinite(let offset):
            switch line.direction {
            case .increasing:
                return self.x >= offset
            case .decreasing:
				print("<<< Exiting isRight(line=\(line))")
                return self.x <= offset
            }
        }
    }
    
    func isLeft(of line: Line2D) -> Bool {
		print(">>> Entering isLeft(line=\(line))")
        return !self.isRight(of: line)
    }
}
