



import Foundation


struct Line {
    let start: Point
    let end: Point
}

struct BCBezier {
    let start: Point
    let end: Point
    let controlPoint1: Point
    let controlPoint2: Point
}

class BCPolygon {
    func moveToPoint(point: CGPoint) {
        points.append(Point(point))
    }
    
    func addLineToPoint(point: CGPoint) {
        points.append(Point(point))
    }
    
    func makeSCAD(height height: Double, normalize: Bool = false) -> String {
        if (normalize) {
            normalizePoints()
        }
        
        let j = Array(points[0..<points.count-1])
        return polygon(j).linearExtrusion(height: height)
    }
    
    //
    // Constrian to 10mm high
    //
    private func normalizePoints() {
        let constraintHeight = 10.0
        
        var minY: Double = Double.max
        var maxY: Double = Double.min
        
        var minX: Double = Double.max
        
        // Extract Min and Max
        points.forEach { point in
            if (point.y < minY) {
                minY = point.y
            }
            
            if (point.y > maxY) {
                maxY = point.y
            }
            
            if (point.x < minX) {
                minX = point.x
            }
        }
        
        // Zero and constrain
        let range = maxY - minY
        let scale = constraintHeight/range
        
        points = points.map { point in
            let x = (point.x-minX) * scale
            let y = (-(point.y-minY) * scale) + (range*scale)
            return Point(x:x, y:y)
        }
    }
    
    private var points: [Point] = []
}


class BCPath {
    func moveToPoint(point: CGPoint) {
        currentPoint = Point(point)
    }
    
    func addCurveToPoint(point: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
        segments.append(
            BCBezier(start: currentPoint, end: Point(point), controlPoint1: Point(controlPoint1), controlPoint2: Point(controlPoint2))
        )
        currentPoint = Point(point)
    }
    
    func addLineToPoint(point: CGPoint) {
        segments.append(
            Line(start: currentPoint, end: Point(point))
        )
        currentPoint = Point(point)
    }
    
    func makeSCAD(height height: Double) -> String {
        var shape: [String] = []
        var startPoint: Point?
        
        for segment in segments {
            if let line = segment as? Line {
                if (startPoint == nil) {
                    startPoint = line.start
                }
                let poly = polygon([startPoint!, line.start, line.end])
                    .linearExtrusion(height: height)
                shape.append(poly)
            }
            
            if let bezier = segment as? BCBezier {
                if (startPoint == nil) {
                    startPoint = bezier.start
                }
                let bez = bezierCurveSolid(p1: bezier.start, c1: bezier.controlPoint1, c2: bezier.controlPoint2, p2: bezier.end, focalPoint: startPoint!, height: height, resolution: 20, hull: true, displayPoints: false)
                shape.append(bez)
            }
        }
        
        return shape.hull()
    }
    
    private var currentPoint: Point = Point(x:0, y:0)
    private var segments: [Any] = []
}