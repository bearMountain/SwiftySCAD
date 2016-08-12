




import Foundation

// MainTube Constants
private let cylinderSquishRatio: Double = 0.74
private let wallThickness: Double = 3
private let clipHeight: Double = 40
private let tubeTopDiameter: Double = 22.3
private let tubeBottomDiameter: Double = 20.8
private let tubeDepthDiameter: Double = 16.5
private let clipSpacerThickness: Double = 5.3
private let rotationAngle: Double = 20.0
private let tiltSlop: Double = 0.75
private let trapTopWidth: Double = 19.5
private let trapBottomWith: Double = 15.8
private let trapSlop: Double = 0.2

// Bracket Constants
private let bracketHeight: Double = 16.0
private let bracketWidth: Double = 18.0
private let hexThickness: Double = 1
private let bracketGap: Double = tubeDepthDiameter+2
private let holeInset: Double = 5.0
private let boltDiameter: Double = 2.7
private let curveSlop: Double = 0

// Parts
private func mainTube() -> String {
    let dist = distance(elipseWidth: tubeDepthDiameter, elipseHeight: tubeTopDiameter, angle: rotationAngle)
    
    
    let taperedCylinder = cylinder(topDiameter: tubeTopDiameter, bottomDiameter: tubeBottomDiameter, height: clipHeight)
        .scale_(x: cylinderSquishRatio, y: 1, z: 1)
    
    let trap = trapezoid(topWidth: trapTopWidth+trapSlop,
                      bottomWidth: trapBottomWith+trapSlop,
                           height: clipHeight,
                        thickness: clipSpacerThickness)
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

private func bracketWithHole() -> String {
    let bracket = cube(x: bracketWidth, y: wallThickness, z: bracketHeight)
        .translate_(x: 0, y: 0, z: bracketHeight.half)
    let holeForm = cylinder(diameter: boltDiameter, height: wallThickness*2)
        .rotate_(x: 90, y: 0, z: 0)
        .translate_(x: bracketWidth.half-holeInset, y: 0, z: bracketHeight.half)
    
    let bracketWithHole = difference(shapes: [bracket, holeForm])
    
    return bracketWithHole
}

private func bracketWithHex() -> String {
    let bracket = bracketWithHole()
    let hex = hexagon(width: 6.3, thickness: hexThickness)
        .rotate_(x: -90, y: 0, z: 0)
        .translate_(x: bracketWidth.half-holeInset, y: wallThickness.half-hexThickness+epsilon, z: bracketHeight.half)
    
    let piece = difference(shapes: [bracket, hex])
    
    return piece
}

private func brackets() -> String {
    let bHexBottom = bracketWithHex()
        .rotate_(x: 180, y: 0, z: 0)
        .translate_(x: 0, y: 0, z: bracketHeight)
    let bHexTop = bHexBottom
        .translate_(x: 0, y: 0, z: clipHeight-bracketHeight)
    
    let bHoleBottom = bracketWithHole()
        .translate_(x: 0, y: bracketGap, z: 0)
    
    let bHoleTop = bHoleBottom
        .translate_(x: 0, y: 0, z: clipHeight-bracketHeight)
    
    return [bHexBottom, bHexTop, bHoleBottom, bHoleTop].and()
}

private func uncutBracket() -> String {
    let tube = mainTube()
    let brackets_ = brackets()
        .translate_(x: bracketWidth-curveSlop, y: -5, z: 0)
        .rotate_(x: 0, y: 0, z: -rotationAngle)
    
    let bracket = [brackets_, tube].union_()
    
    return bracket
}

func cutBracket() -> String {
    let splitBlank = cube(x: wallThickness*2.0, y: bracketGap-wallThickness, z: clipHeight+big_epsilon)
        .translate_(x: 0, y: 0, z: clipHeight.half)
        .translate_(x: 10, y: 4.2, z: 0)
        .rotate_(x: 0, y: 0, z: -rotationAngle)
    
    let cutBracket = [uncutBracket(), splitBlank].difference_()
    
    return cutBracket
}