import Foundation
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
		FileHandle.standardError.write(Data("[ERROR] >>> Entering isRight(line=\(line))\n".utf8))
        switch line.slope {
        case .finite:
            let y = line.y(at: self.x)
            switch line.direction {
			FileHandle.standardError.write(Data("[ERROR] isRight(line=\(line)): y → \(y)\n".utf8))
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
				FileHandle.standardError.write(Data("[WARN] <<< Exiting isRight(line=\(line))\n".utf8))
                return self.x <= offset
            }
        }
    }
    
    func isLeft(of line: Line2D) -> Bool {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering isLeft(line=\(line))\n".utf8))
        FileHandle.standardError.write(Data("[WARN] <<< Exiting isLeft(line=\(line))\n".utf8))
        return !self.isRight(of: line)
    }
}
