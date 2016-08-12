



import Foundation

let ProjectPath = "/Users/jeff/Documents/Branch Computing/SwiftySCAD/SwiftySCAD"
let DestinationDirectoryPath = "/Users/jeff/Documents/OpenSCAD"


/// MAIN

// convert everything to dot notation and Double

func p(x: Double,_ y: Double) -> Point {
    return Point(x: x, y: y)
}

func bezierCurveSolid(p1 p1: Point, c1: Point, c2: Point, p2: Point, focalPoint: Point, height: Double, resolution: Double = 15, displayPoints: Bool = false) -> String {
    return "BezQuadCurve( [[\(p1.x), \(p1.y)], [\(c1.x), \(c1.y)], [\(c2.x), \(c2.y)], [\(p2.x), \(p2.y)]], [\(focalPoint.x), \(focalPoint.y)], \(resolution), \(height), \(displayPoints));"
}

let curve = bezierCurveSolid(p1: p(0,0), c1: p(0,10), c2: p(20,5), p2: p(20,0), focalPoint: p(0,0), height: 10, resolution: 25, displayPoints: true)
    .translate(x: 10, y: 10, z: 0)

// ================================================================================================
// Constants
// ================================================================================================

let defaultCurveResolution = 20.0

// Truck Body
struct TBody {
    static let height = 52.5
    static let width = 52.0
    static let bigBlockWidth = 30.0
    static let smallBlockWidth = 35.0
    static let smallBlockHeight = TBody.height-20
    
    // Windshield Curve
    static let windshieldP1 = p(-15.5, 0)
    static let windshieldP2 = p(0, TBody.height-TBody.smallBlockHeight)
    static let windshieldC1 = p(-14.5, 9)
    static let windshieldC2 = p(-6.5, TBody.height-TBody.smallBlockHeight-2.0)
    
    // Hood Curve
    static let hoodP1 = p(-(TBody.smallBlockWidth+TBody.windshieldP1.x+3.0), 0.0)
    static let hoodP2 = p(0, 6)
    static let hoodC1 = p(TBody.hoodP1.x+3.5, 3.5)
    static let hoodC2 = p(-3.5, TBody.hoodP2.y-0.5)
}

let bumperWidth = 5.0
let bumperPoints = [p(0,0), p(0, 17.5), p(-bumperWidth, 12.5), p(-bumperWidth, 4), p(-(bumperWidth-3.0), 0)]


// ================================================================================================
// Construction
// ================================================================================================

let bigBlock = cube(x: TBody.bigBlockWidth, y: TBody.width, z: TBody.height)
    .translate(x: -TBody.bigBlockWidth, y: 0, z: 0)

let littleBlock = cube(x: TBody.smallBlockWidth, y: TBody.width, z: TBody.smallBlockHeight)
    .translate(x: -(TBody.bigBlockWidth+TBody.smallBlockWidth), y: 0, z: 0)


let windshieldCurve = bezierCurveSolid(p1: TBody.windshieldP1, c1: TBody.windshieldC1, c2: TBody.windshieldC2, p2: TBody.windshieldP2, focalPoint: p(0,0), height: TBody.width, resolution: defaultCurveResolution, displayPoints: false)
    .rotate(x: 90, y: 0, z: 0)
    .translate(x: -TBody.bigBlockWidth, y: TBody.width, z: TBody.smallBlockHeight)

let hoodCurve = bezierCurveSolid(p1: TBody.hoodP1, c1: TBody.hoodC1, c2: TBody.hoodC2, p2: TBody.hoodP2, focalPoint: p(0, 0), height: TBody.width, resolution: defaultCurveResolution, displayPoints: false)
    .rotate(x: 90, y: 0, z: 0)
    .translate(x: -(TBody.bigBlockWidth)-(TBody.smallBlockWidth+TBody.hoodP1.x), y: TBody.width, z: TBody.smallBlockHeight)



let bumper = polygon(bumperPoints)
    .linearExtrusion(height: TBody.width)
    .rotate(x: 90, y: 0, z: 0)
    .translate(x: -(TBody.bigBlockWidth+TBody.smallBlockWidth), y: TBody.width, z: 0)




let truckBody = [bigBlock, littleBlock, windshieldCurve, hoodCurve, bumper].union()
truckBody.exportAsOpenSCAD(destinationDirectoryPath: DestinationDirectoryPath, fileName: "flatbed", swiftySCADProjectPath: ProjectPath)


testEverything()






