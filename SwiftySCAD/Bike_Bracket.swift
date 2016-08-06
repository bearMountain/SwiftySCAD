




import Foundation

// MainTube Constants
private let cylinderSquishRatio: CGFloat = 0.74
private let wallThickness: CGFloat = 3
private let clipHeight: CGFloat = 40
private let tubeTopDiameter: CGFloat = 22.3
private let tubeBottomDiameter: CGFloat = 20.8
private let tubeDepthDiameter: CGFloat = 16.5
private let clipSpacerThickness: CGFloat = 5.3
private let rotationAngle: CGFloat = 20.0
private let tiltSlop: CGFloat = 0.75

// Bracket Constants
private let bracketHeight: CGFloat = 16.0
private let bracketWidth: CGFloat = 20.0
private let bracketThickness: CGFloat = 0.75
private let bracketGap: CGFloat = tubeDepthDiameter+2
private let holeInset: CGFloat = 7.0
private let boltDiameter: CGFloat = 2.7
private let curveSlop: CGFloat = 1

// Parts
private func mainTube() -> String {
    let dist = distance(elipseWidth: tubeDepthDiameter, elipseHeight: tubeTopDiameter, angle: rotationAngle)
    
    
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
    let hex = hexagon(width: 6.3, thickness: bracketThickness)
        .rotate_(x: -90, y: 0, z: 0)
        .translate_(x: bracketWidth.half-holeInset, y: wallThickness.half-bracketThickness+epsilon, z: bracketHeight.half)
    
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