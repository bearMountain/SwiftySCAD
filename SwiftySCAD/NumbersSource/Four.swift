



import Foundation


func rawFour() -> String {
    let height = 100.0
    
    let bezierPath = BCPath()
    bezierPath.moveToPoint(CGPointMake(1279.5, 984.5))
    bezierPath.addCurveToPoint(CGPointMake(1331, 2651), controlPoint1: CGPointMake(1305, 1145), controlPoint2: CGPointMake(1414.5, 1900.5))
    bezierPath.addLineToPoint(CGPointMake(1331.5, 2661.5))
    bezierPath.addLineToPoint(CGPointMake(1279.5, 984.5))
    let curveCut = bezierPath.makeSCAD(height: height)
    
    
    
    //// Bezier 2 Drawing
    let bezier2Path = BCPolygon()
    bezier2Path.moveToPoint(CGPointMake(712, 1099))
    bezier2Path.addLineToPoint(CGPointMake(642, 1982))
    bezier2Path.addLineToPoint(CGPointMake(905.5, 2102.5))
    bezier2Path.addLineToPoint(CGPointMake(1712, 1571))
    bezier2Path.addLineToPoint(CGPointMake(1689, 1316))
    bezier2Path.addLineToPoint(CGPointMake(905.5, 1758.5))
    bezier2Path.addLineToPoint(CGPointMake(935.5, 1011.5))
    bezier2Path.addLineToPoint(CGPointMake(712, 1099))
    let crookedPoly = bezier2Path.makeSCAD(height: height)
    
    
    
    //// Bezier 3 Drawing
    let bezier3Path = BCPolygon()
    bezier3Path.moveToPoint(CGPointMake(1280.5, 983.5))
    bezier3Path.addLineToPoint(CGPointMake(1488.5, 938.5))
    bezier3Path.addLineToPoint(CGPointMake(1649.5, 2495.5))
    bezier3Path.addLineToPoint(CGPointMake(1331.5, 2650.5))
    bezier3Path.addLineToPoint(CGPointMake(1280.5, 983.5))
    let roughShaft = bezier3Path.makeSCAD(height: height)
    
    let shaft = [roughShaft, curveCut].difference()
    let four = [crookedPoly, shaft].union()
    
    return four
}

func normalizedFour() -> String {
    let height = 1710.0
    let constrainHeight = 10.0
    let scale = constrainHeight/height
    
    let four = bc_import("four", convexity: 6)
        .mirror(x: 0, y: 1, z: 0)
        .translate(x: -640, y: 2650, z: 0)
        .scale(x: scale, y: scale, z: scale)
    
    return four
}