



import Foundation

func rawSix() -> String {
    let height = 100.0
    
    let bezierPath = BCPath()
    bezierPath.moveToPoint(CGPointMake(450.5, 1851.5))
    bezierPath.addCurveToPoint(CGPointMake(577.5, 2316.5), controlPoint1: CGPointMake(392.13, 2004.37), controlPoint2: CGPointMake(480.36, 2216.95))
    bezierPath.addCurveToPoint(CGPointMake(1456.5, 2316.5), controlPoint1: CGPointMake(802.58, 2547.16), controlPoint2: CGPointMake(1310.24, 2492.96))
    bezierPath.addCurveToPoint(CGPointMake(1192.5, 1530.5), controlPoint1: CGPointMake(1766.5, 1942.5), controlPoint2: CGPointMake(1482.23, 1557.72))
    bezierPath.addCurveToPoint(CGPointMake(450.5, 1851.5), controlPoint1: CGPointMake(1043.5, 1516.5), controlPoint2: CGPointMake(513.5, 1686.5))
    let rawBulb = bezierPath.makeSCAD(height: height)
    
    
    
    //// Bezier 2 Drawing
    let bezier2Path = BCPath()
    bezier2Path.moveToPoint(CGPointMake(1124, 978))
    bezier2Path.addCurveToPoint(CGPointMake(431.5, 1936.5), controlPoint1: CGPointMake(922.5, 1061.5), controlPoint2: CGPointMake(450.5, 1467.5))
    bezier2Path.addLineToPoint(CGPointMake(884, 1591))
    bezier2Path.addLineToPoint(CGPointMake(1171, 1140))
    bezier2Path.addLineToPoint(CGPointMake(1124, 978))
    let rawStem = bezier2Path.makeSCAD(height: height)
    
    
    
    //// Bezier 3 Drawing
    let bezier3Path = BCPath()
    bezier3Path.moveToPoint(CGPointMake(1171.5, 1139.5))
    bezier3Path.addCurveToPoint(CGPointMake(884.5, 1590.5), controlPoint1: CGPointMake(1081.5, 1219.5), controlPoint2: CGPointMake(880.5, 1455.5))
    bezier3Path.addLineToPoint(CGPointMake(1171.5, 1139.5))
    let stemCut = bezier3Path.makeSCAD(height: height)
    
    
    
    //// Bezier 4 Drawing
    let bezier4Path = BCPath()
    bezier4Path.moveToPoint(CGPointMake(1140.5, 1863.5))
    bezier4Path.addCurveToPoint(CGPointMake(893, 1851), controlPoint1: CGPointMake(1066.5, 1743.5), controlPoint2: CGPointMake(902.5, 1829.5))
    bezier4Path.addCurveToPoint(CGPointMake(1028, 2099), controlPoint1: CGPointMake(872.51, 1897.37), controlPoint2: CGPointMake(973.5, 2094.5))
    bezier4Path.addCurveToPoint(CGPointMake(1140.5, 1863.5), controlPoint1: CGPointMake(1057.23, 2101.41), controlPoint2: CGPointMake(1226.09, 2002.29))
    let bulbCut = bezier4Path.makeSCAD(height: height)
    
    let stem = [rawStem, stemCut].difference()
    let bulb = [rawBulb, bulbCut].difference()
    let six = [stem, bulb].union()
    
    return six
}

func normalizedSix() -> String {
    let height = 1500.0
    let constrainHeight = 10.0
    let scale = constrainHeight/height
    
    let six = bc_import("six", convexity: 6)
        .mirror(x: 0, y: 1, z: 0)
        .translate(x: -430, y: 2470, z: 0)
        .scale(x: scale, y: scale, z: scale)
    
    return six
}