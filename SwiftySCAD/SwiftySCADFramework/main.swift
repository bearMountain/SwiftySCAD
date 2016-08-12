



import Foundation

let ProjectPath = "/Users/jeff/Documents/Branch Computing/SwiftySCAD/SwiftySCAD"
let DestinationDirectoryPath = "/Users/jeff/Documents/OpenSCAD"


/// MAIN

// convert everything to dot notation and Double

//joinfactor = 0.125;
//
//gFocalPoint = [0,0];
//gSteps = 20;
//gHeight = 4;
//
//BezQuadCurve( [[0, 15],[5,5],[10,25],[15,15]], [7.5, 0], gSteps, gHeight);
//
// module BezQuadCurve(c, focalPoint, steps=gSteps, height=gHeight)
//

struct Point {
    var x: Float
    var y: Float
}

func p(x: Float,_ y: Float) -> Point {
    return Point(x: x, y: y)
}

func bezierCurveSolid(p1 p1: Point, c1: Point, c2: Point, p2: Point, focalPoint: Point, height: Float, resolution: Float = 15, displayPoints: Bool = false) -> String {
    return "BezQuadCurve( [[\(p1.x), \(p1.y)], [\(c1.x), \(c1.y)], [\(c2.x), \(c2.y)], [\(p2.x), \(p2.y)]], [\(focalPoint.x), \(focalPoint.y)], \(resolution), \(height), \(displayPoints));"
}

let curve = bezierCurveSolid(p1: p(0,0), c1: p(0,10), c2: p(20,5), p2: p(20,0), focalPoint: p(0,0), height: 10, resolution: 25, displayPoints: true)
    .translate_(x: 10, y: 10, z: 0)
//let j = linearex



let c = cylinder(radius: 10, height: 210)

curve.exportAsOpenSCAD(destinationDirectoryPath: DestinationDirectoryPath, fileName: "flatbed", swiftySCADProjectPath: ProjectPath)



















