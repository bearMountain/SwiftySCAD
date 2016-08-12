




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
        .scale(x: cylinderSquishRatio, y: 1, z: 1)
    
    let trap = trapezoid(topWidth: trapTopWidth+trapSlop,
                      bottomWidth: trapBottomWith+trapSlop,
                           height: clipHeight,
                        thickness: clipSpacerThickness)
        .rotate(x: -1.1, y: 0, z: 0)
        .translate(x: 0, y: clipSpacerThickness.half+dist-tiltSlop+2, z: 0)
        .rotate(x: 0, y: 0, z: -rotationAngle)
    
    
    let blank = [taperedCylinder, trap].hull()
    
    let w = tubeBottomDiameter.half
    let scaleFactor = (wallThickness+w)/w
    
    let main = blank.scale(x: scaleFactor, y: scaleFactor, z: 1)
    let scaledBlank = blank.scale(x: 1, y: 1, z: 2)
        .translate(x: 0, y: 0, z: -1)
    
    let tube = [main, scaledBlank].difference()
    
    let trapCutter = trapezoid(topWidth: 20, bottomWidth: 16, height: clipHeight+1, thickness: clipSpacerThickness)
        .rotate(x: -1.1, y: 0, z: 0)
        .translate(x: 0, y: clipSpacerThickness.half+dist-tiltSlop+2+3.5, z: 0)
        .rotate(x: 0, y: 0, z: -rotationAngle)
        .scale(x: scaleFactor, y: scaleFactor, z: 1)
        .translate(x: 0, y: 0, z: -0.1)
    
    let piece = [tube, trapCutter].difference()
    
    return piece
}

private func bracketWithHole() -> String {
    let bracket = cube(x: bracketWidth, y: wallThickness, z: bracketHeight)
        .translate(x: 0, y: 0, z: bracketHeight.half)
    let holeForm = cylinder(diameter: boltDiameter, height: wallThickness*2)
        .rotate(x: 90, y: 0, z: 0)
        .translate(x: bracketWidth.half-holeInset, y: 0, z: bracketHeight.half)
    
    let bracketWithHole = [bracket, holeForm].difference()
    
    return bracketWithHole
}

private func bracketWithHex() -> String {
    let bracket = bracketWithHole()
    let hex = hexagon(width: 6.3, thickness: hexThickness)
        .rotate(x: -90, y: 0, z: 0)
        .translate(x: bracketWidth.half-holeInset, y: wallThickness.half-hexThickness+epsilon, z: bracketHeight.half)
    
    let piece = [bracket, hex].difference()
    
    return piece
}

private func brackets() -> String {
    let bHexBottom = bracketWithHex()
        .rotate(x: 180, y: 0, z: 0)
        .translate(x: 0, y: 0, z: bracketHeight)
    let bHexTop = bHexBottom
        .translate(x: 0, y: 0, z: clipHeight-bracketHeight)
    
    let bHoleBottom = bracketWithHole()
        .translate(x: 0, y: bracketGap, z: 0)
    
    let bHoleTop = bHoleBottom
        .translate(x: 0, y: 0, z: clipHeight-bracketHeight)
    
    return [bHexBottom, bHexTop, bHoleBottom, bHoleTop].and()
}

private func uncutBracket() -> String {
    let tube = mainTube()
    let brackets_ = brackets()
        .translate(x: bracketWidth-curveSlop, y: -5, z: 0)
        .rotate(x: 0, y: 0, z: -rotationAngle)
    
    let bracket = [brackets_, tube].union()
    
    return bracket
}

func cutBracket() -> String {
    let splitBlank = cube(x: wallThickness*2.0, y: bracketGap-wallThickness, z: clipHeight+big_epsilon)
        .translate(x: 0, y: 0, z: clipHeight.half)
        .translate(x: 10, y: 4.2, z: 0)
        .rotate(x: 0, y: 0, z: -rotationAngle)
    
    let cutBracket = [uncutBracket(), splitBlank].difference()
    
    return cutBracket
}