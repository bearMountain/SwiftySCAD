



import Foundation


/// MAIN

// convert everything to dot notation

// Dimensions
let WheelDiameter: Float = 39.84
let WheelWidth: Float = 21.84
let HubDiameter: Float = 17.25
let WheelTopChamferDiameter: Float = (WheelDiameter-HubDiameter)/2.0

// Construction
let cOffset = WheelDiameter.half-WheelTopChamferDiameter.half

let c1 = circle(WheelTopChamferDiameter)
    .translate_(x: cOffset, y: 5, z: 0)
let c2 = mirror(x: 0, y: 1, z: 0, shape: c1)

let raceTrack = [c1, c2]
    .hull_()
let raceTrackTorus = rotate_extrude(resolution: 100, shape: raceTrack)

let internalCylinderHeight = WheelWidth.half-WheelTopChamferDiameter.half
let internalCylinder = cylinder(diameter: WheelDiameter-WheelTopChamferDiameter*2.0, height: internalCylinderHeight)
    .translate_(x: 0, y: 0, z: internalCylinderHeight.half)

let wheelWithInternalCylinder = [raceTrackTorus, internalCylinder].union_()


openSCADExport(wheelWithInternalCylinder, directoryPath: "/Users/jeff/Documents/OpenSCAD", fileName: "wheel")



















