



import Foundation

let ProjectPath = "/Users/jeff/Documents/Branch Computing/SwiftySCAD/SwiftySCAD"
let DestinationDirectoryPath = "/Users/jeff/Documents/OpenSCAD"


/// MAIN
let height = 100.0
let resolution = 30.0

let littleBottom = p(382.5, 896.5)
let littleTop = p(502.5, 455.5)
let littleLeft = bezierCurveSolid(p1: littleBottom, c1: p(241.5, 829.5), c2: p(285.5, 386.5), p2: littleTop, focalPoint: littleBottom, height: height, resolution: resolution, hull: true)
let littleRight = bezierCurveSolid(p1: littleTop, c1: p(719.5, 524.5), c2: p(523.5, 963.5), p2: littleBottom, focalPoint: littleBottom, height: height, resolution: resolution, hull: true)

let hole = [littleLeft, littleRight].union()


let bigBottom = p(312.66, 1156.85)
let bigTop = p(694.66, 18.85)

let left = bezierCurveSolid(p1: bigBottom, c1: p(-206.34, 977.85), c2: p(-79.34, -159.15), p2: bigTop, focalPoint: bigBottom, height: height, resolution: resolution, hull: true)
let right = bezierCurveSolid(p1: bigTop, c1: p(1468.66, 196.85), c2: p(831.66, 1335.85), p2: bigBottom, focalPoint: bigBottom, height: height, resolution: resolution, hull: true)

let o = [left, right].union()

let fullO = [o, hole].difference()

fullO.exportAsOpenSCAD(destinationDirectoryPath: DestinationDirectoryPath, fileName: "fin", swiftySCADProjectPath: ProjectPath)





