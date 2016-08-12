




import Foundation


// Size
struct Size {
    var width: Double
    var height: Double
}

// Point
struct Point {
    var x: Double
    var y: Double
}

extension Point {
    func scadOutput() -> String {
        return "[\(x), \(y)]"
    }
}

func p(x: Double,_ y: Double) -> Point {
    return Point(x: x, y: y)
}