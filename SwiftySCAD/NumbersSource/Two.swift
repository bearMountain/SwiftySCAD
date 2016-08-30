



import Foundation

func rawTwo() -> String {
    let height = 100.0
    
    // Base
    let bezierPath = BCPolygon()
    bezierPath.moveToPoint(CGPointMake(780.5, 2526.5))
    bezierPath.addLineToPoint(CGPointMake(1701.5, 2086.5))
    bezierPath.addLineToPoint(CGPointMake(1701.5, 1828.5))
    bezierPath.addLineToPoint(CGPointMake(780.5, 2119.5))
    bezierPath.addLineToPoint(CGPointMake(780.5, 2526.5))
    let base = bezierPath.makeSCAD(height: height)
    
    // Rough Top
    let bezier2Path = BCPath()
    bezier2Path.moveToPoint(CGPointMake(781.5, 1575.5))
    bezier2Path.addCurveToPoint(CGPointMake(1033.5, 1191.5), controlPoint1: CGPointMake(776.5, 1431.5), controlPoint2: CGPointMake(864.64, 1288.81))
    bezier2Path.addCurveToPoint(CGPointMake(1477.5, 1224.5), controlPoint1: CGPointMake(1065.26, 1173.2), controlPoint2: CGPointMake(1377.21, 1012.25))
    bezier2Path.addCurveToPoint(CGPointMake(1198.5, 1987.5), controlPoint1: CGPointMake(1563.5, 1406.5), controlPoint2: CGPointMake(1195.5, 1802.5))
    bezier2Path.addLineToPoint(CGPointMake(781.5, 2119.5))
    bezier2Path.addLineToPoint(CGPointMake(781.5, 1575.5))
    let roughTop = bezier2Path.makeSCAD(height: height)
    
    let bezier3Path = BCPath()
    bezier3Path.moveToPoint(CGPointMake(781, 1579))
    bezier3Path.addLineToPoint(CGPointMake(1072, 1664))
    bezier3Path.addCurveToPoint(CGPointMake(781, 2120), controlPoint1: CGPointMake(1050, 1773), controlPoint2: CGPointMake(774, 2068))
    bezier3Path.addLineToPoint(CGPointMake(781, 1579))
    let mainCut = bezier3Path.makeSCAD(height: height)
    
    let bezier4Path = BCPath()
    bezier4Path.moveToPoint(CGPointMake(1072, 1666))
    bezier4Path.addCurveToPoint(CGPointMake(958, 1631), controlPoint1: CGPointMake(1115.5, 1525.5), controlPoint2: CGPointMake(941.5, 1577.5))
    bezier4Path.addLineToPoint(CGPointMake(1072, 1666))
    let smallCut = bezier4Path.makeSCAD(height: height)
    
    let rough = [base, roughTop].union()
    let two = [rough, mainCut, smallCut].difference()
    
    return two
}

func normalizeRawTwo() -> String {
    let constraintHeight = 10.0
    let rawheight = 1430.0
    let scale = constraintHeight/rawheight
    
    return "import(\"two.stl\", convexity=6);"
        .mirror(x: 0, y: 1, z: 0)
        .translate(x: -780, y: 2530, z: 0)
        .scale(x: scale, y: scale, z: scale)
}