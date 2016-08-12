



import Foundation

func solidFrom(curve f: (Double)->(Double), maxX: Double = 1, resolution: Double = 10, displaySize: Size, seedObject: String) -> String
{
    let numericalStep = (maxX*2.0)/resolution
    let xVals = maxX.stride(to: -(maxX), by: -numericalStep)
    let yVals = xVals.map(f)
    let maxYVal = yVals.maxElement()
    let minYVal = yVals.minElement()
    let range = maxYVal! - minYVal!
    let displayStep = (displaySize.width*2.0)/resolution
    
    var placeholders: [String] = []
    var currentX = -displaySize.width
    for (i, _) in xVals.enumerate() {
        let yVal = (yVals[i]/range) * displaySize.height
        let obj = seedObject.translate(x: currentX, y: 0, z: yVal)
        placeholders.append(obj)
        
        currentX += displayStep
    }
    
    return placeholders.hull()
}

func bezierCurveSolid(p1 p1: Point, c1: Point, c2: Point, p2: Point, focalPoint: Point, height: Double, resolution: Double = 15, displayPoints: Bool = false) -> String {
    return "BezQuadCurve( [[\(p1.x), \(p1.y)], [\(c1.x), \(c1.y)], [\(c2.x), \(c2.y)], [\(p2.x), \(p2.y)]], [\(focalPoint.x), \(focalPoint.y)], \(resolution), \(height), \(displayPoints));"
}

