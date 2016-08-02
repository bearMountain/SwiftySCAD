



import Foundation


/// MAIN
let cylinderSquishRatio: CGFloat = 0.74
let wallThickness: CGFloat = 3
let clipHeight: CGFloat = 40
let tubeTopDiameter: CGFloat = 22.3
let tubeBottomDiameter: CGFloat = 20.8
let clipSpacerThickness: CGFloat = 5.3
let rotationAngle: CGFloat = 20.0
let tiltSlop: CGFloat = 0.75






func mainTube() -> String {
    let dist = distance(elipseWidth: 16.5, elipseHeight: tubeTopDiameter, angle: rotationAngle)
    
    
    let taperedCylinder = cylinder(topDiameter: tubeTopDiameter, bottomDiameter: tubeBottomDiameter, height: clipHeight)
        .scale_(x: cylinderSquishRatio, y: 1, z: 1)
    
    let trap = trapezoid(topWidth: 19.5, bottomWidth: 15.8, height: clipHeight, thickness: clipSpacerThickness)
        .rotate_(x: -1.1, y: 0, z: 0)
        .translate_(x: 0, y: clipSpacerThickness.half+dist-tiltSlop+2, z: 0)
        .rotate_(x: 0, y: 0, z: -rotationAngle)
    
    
    let blank = hull(shapes: [taperedCylinder, trap])
    
    let w = tubeBottomDiameter.half
    let scaleFactor = (wallThickness+w)/w
    
    let main = blank.scale_(x: scaleFactor, y: scaleFactor, z: 1)
    let scaledBlank = blank.scale_(x: 1, y: 1, z: 2)
        .translate_(x: 0, y: 0, z: -1)
    
    let tube = difference(shapes: [main, scaledBlank])
    
    let trapCutter = trapezoid(topWidth: 20, bottomWidth: 16, height: clipHeight+1, thickness: clipSpacerThickness)
        .rotate_(x: -1.1, y: 0, z: 0)
        .translate_(x: 0, y: clipSpacerThickness.half+dist-tiltSlop+2+3.5, z: 0)
        .rotate_(x: 0, y: 0, z: -rotationAngle)
        .scale_(x: scaleFactor, y: scaleFactor, z: 1)
        .translate_(x: 0, y: 0, z: -0.1)
    
    let piece = difference(shapes: [tube, trapCutter])
    
    return piece
}






//write(mainTube())


let bracketHeight: CGFloat = 16.0
let bracketWidth: CGFloat = 20.0
let bracketThickness: CGFloat = 0.75
let holeInset: CGFloat = 7.0
let boltDiameter: CGFloat = 2.7


func bracketWithHole() -> String {
    let bracket = cube(x: bracketWidth, y: wallThickness, z: bracketHeight)
                  .translate_(x: 0, y: 0, z: bracketHeight.half)
    let holeForm = cylinder(diameter: boltDiameter, height: wallThickness*2)
        .rotate_(x: 90, y: 0, z: 0)
        .translate_(x: bracketWidth.half-holeInset, y: 0, z: bracketHeight.half)
    
    let bracketWithHole = difference(shapes: [bracket, holeForm])
    
    return bracketWithHole
}

func bracketWithHex() -> String {
    let bracket = bracketWithHole()
    let hex = hexagon(width: 6.3, thickness: bracketThickness)
        .rotate_(x: -90, y: 0, z: 0)
        .translate_(x: bracketWidth.half-holeInset, y: wallThickness.half-bracketThickness+epsilon, z: bracketHeight.half)
    
    let piece = difference(shapes: [bracket, hex])
    
    return piece
}

//let
//
//

write(bracketWithHex())


















