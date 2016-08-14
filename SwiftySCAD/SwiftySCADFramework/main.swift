



import Foundation

let ProjectPath = "/Users/jeff/Documents/Branch Computing/SwiftySCAD/SwiftySCAD"
let DestinationDirectoryPath = "/Users/jeff/Documents/OpenSCAD"


/// MAIN

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

let wellCurveWidth = TBody.smallBlockWidth*0.75
let wellCurveControlHeight = wellCurveWidth*0.25
let wellCurveStartHeight = TBody.smallBlockHeight*0.3
let wellStart = TBody.bigBlockWidth*0.8


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


let wellCurve = [bezierCurveSolid(p1: p(-wellCurveWidth,0), c1: p(-wellCurveWidth, wellCurveControlHeight), c2: p(0, wellCurveControlHeight), p2: p(0,0), focalPoint: p(0,0), height: TBody.width)]
    .hull()
    .rotate(x: 90, y: 0, z: 0)
    .translate(x: -wellStart, y: TBody.width, z: wellCurveStartHeight)

let wellSquare = cube(x: wellCurveWidth, y: TBody.width, z: wellCurveStartHeight)
    .translate(x: -(wellCurveWidth+wellStart), y: 0, z: 0)

let wellTriangleHeight = 5.0
let wellTriangle = polygon([p(0,0), p(0, wellTriangleHeight), p(-(wellTriangleHeight+2.5),0)])
    .linearExtrusion(height: TBody.width)
    .rotate(x: 90, y: 0, z: 0)
    .translate(x: -(wellStart+wellCurveWidth), y: TBody.width, z: 0)
let wellSliver = polygon([p(0,0), p(0,wellCurveStartHeight), p(wellCurveStartHeight*0.2,0)])
    .linearExtrusion(height: TBody.width)
    .rotate(x: 90, y: 0, z: 0)
    .translate(x: -(wellStart), y: TBody.width, z: 0)

let well = [wellCurve, wellSquare, wellTriangle, wellSliver].union()

let tireDiameter = wellCurveWidth*1.2
let tireWidth = tireDiameter*0.4
let tireLift = wellCurveWidth.half*0.8
let tireOutOverhang = tireWidth*0.5
let tire1 = cylinder(diameter: tireDiameter, height: tireWidth, center: false)
    .rotate(x: -90, y: 0, z: 0)
    .translate(x: -(wellCurveWidth.half+wellStart), y: -tireOutOverhang, z: -tireLift)
let tire2 = tire1
    .translate(x: 0, y: TBody.width-(tireWidth-tireOutOverhang*2.0), z: 0)
let tires = [tire1, tire2].union()
    .color(r: 0.3, g: 0.3, b: 0.3)

let backWindowWidth = TBody.bigBlockWidth*0.4
let windowBaseLine = TBody.smallBlockHeight+TBody.hoodP2.y
let windowFrameWidth = 3.0
let windowHeight = TBody.height-windowBaseLine-windowFrameWidth
let backWindowBlank = cube(x: backWindowWidth, y: TBody.width, z: windowHeight)
    .translate(x: -(windowFrameWidth+backWindowWidth), y: 0, z: TBody.height-(windowFrameWidth+windowHeight))

let frontWindowTopWidth = TBody.bigBlockWidth-(backWindowWidth+windowFrameWidth*2)
let frontWindowBottomWidth = frontWindowTopWidth+TBody.smallBlockWidth*0.28
let frontWindowBlank = polygon([
    p(0,0),
    p(0, windowHeight),
    p(-frontWindowTopWidth, windowHeight),
    p(-frontWindowBottomWidth,0)
    ])
    .linearExtrusion(height: TBody.width+big_epsilon)
    .rotate(x: 90, y: 0, z: 0)
    .translate(x: -(windowFrameWidth*2+backWindowWidth), y: TBody.width+big_epsilon, z: windowBaseLine)

let windows = [frontWindowBlank, backWindowBlank].union()



let truckBody = [bigBlock, littleBlock, windshieldCurve, hoodCurve, bumper].union()
let bodyWithWell = [truckBody, well].difference()

let bodyWithWindows = [bodyWithWell, windows].difference()
let bodyAndTires = [bodyWithWindows, tires].and()

bodyAndTires.exportAsOpenSCAD(destinationDirectoryPath: DestinationDirectoryPath, fileName: "flatbed", swiftySCADProjectPath: ProjectPath)






