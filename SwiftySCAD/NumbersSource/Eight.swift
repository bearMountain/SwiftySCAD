



import Foundation


func rawEight() -> String {
    let height = 100.0
    
    let bezierPath = BCPath()
    bezierPath.moveToPoint(CGPointMake(1194.5, 1523.5))
    bezierPath.addCurveToPoint(CGPointMake(887.5, 1966.5), controlPoint1: CGPointMake(1097.5, 1653.5), controlPoint2: CGPointMake(1011.7, 1790.77))
    bezierPath.addCurveToPoint(CGPointMake(673.5, 2439.5), controlPoint1: CGPointMake(773, 2128.5), controlPoint2: CGPointMake(624.5, 2279.5))
    bezierPath.addCurveToPoint(CGPointMake(1396.5, 2289.5), controlPoint1: CGPointMake(775.65, 2773.07), controlPoint2: CGPointMake(1396.5, 2801.5))
    bezierPath.addCurveToPoint(CGPointMake(1352.5, 1728.5), controlPoint1: CGPointMake(1396.5, 1777.5), controlPoint2: CGPointMake(1352.5, 1728.5))
    bezierPath.addLineToPoint(CGPointMake(1194.5, 1523.5))
    let rawBulb = bezierPath.makeSCAD(height: height)
    
    
    //// Bezier 2 Drawing
    let bezier2Path = BCPath()
    bezier2Path.moveToPoint(CGPointMake(1501, 1962))
    bezier2Path.addCurveToPoint(CGPointMake(1353, 1725), controlPoint1: CGPointMake(1490.24, 1827.21), controlPoint2: CGPointMake(1353, 1725))
    bezier2Path.addLineToPoint(CGPointMake(1155, 1923))
    bezier2Path.addCurveToPoint(CGPointMake(1397, 2273), controlPoint1: CGPointMake(1182, 1955), controlPoint2: CGPointMake(1362.5, 2045.5))
    bezier2Path.addCurveToPoint(CGPointMake(1501, 1962), controlPoint1: CGPointMake(1415.52, 2395.11), controlPoint2: CGPointMake(1513.46, 2118.17))
    let bulbCut = bezier2Path.makeSCAD(height: height, hull: false)
    
    let bezier3Path = BCPath()
    bezier3Path.moveToPoint(CGPointMake(873.5, 2267.5))
    bezier3Path.addCurveToPoint(CGPointMake(1058.5, 2374.5), controlPoint1: CGPointMake(819.71, 2448.44), controlPoint2: CGPointMake(990.7, 2476.58))
    bezier3Path.addCurveToPoint(CGPointMake(1030, 2062), controlPoint1: CGPointMake(1147.5, 2240.5), controlPoint2: CGPointMake(1030, 2062))
    bezier3Path.addCurveToPoint(CGPointMake(873.5, 2267.5), controlPoint1: CGPointMake(1030, 2062), controlPoint2: CGPointMake(906.5, 2156.5))
    let bulbCenterCut = bezier3Path.makeSCAD(height: height)
    
    let bezier4Path = BCPath()
    bezier4Path.moveToPoint(CGPointMake(1147, 1588))
    bezier4Path.addCurveToPoint(CGPointMake(833, 1508), controlPoint1: CGPointMake(1156, 1545), controlPoint2: CGPointMake(1006, 1398))
    bezier4Path.addCurveToPoint(CGPointMake(888, 1966), controlPoint1: CGPointMake(660, 1618), controlPoint2: CGPointMake(672, 1862))
    bezier4Path.addLineToPoint(CGPointMake(1147, 1588))
    let roughTop = bezier4Path.makeSCAD(height: height)
    
    
    //// Bezier 5 Drawing
    let bezier5Path = BCPath()
    bezier5Path.moveToPoint(CGPointMake(978.5, 1660.5))
    bezier5Path.addCurveToPoint(CGPointMake(964.5, 1795.5), controlPoint1: CGPointMake(891.5, 1652.5), controlPoint2: CGPointMake(890.5, 1790.5))
    bezier5Path.addCurveToPoint(CGPointMake(978.5, 1660.5), controlPoint1: CGPointMake(1038.5, 1800.5), controlPoint2: CGPointMake(1065.5, 1668.5))
    let topCut = bezier5Path.makeSCAD(height: height)
    
    let bottom = [rawBulb, bulbCut, bulbCenterCut].difference()
    let top = [roughTop, topCut].difference()
    let eight = [bottom, top].union()
    
    return eight
}

func normalizedEight() -> String {
    let height = 1220.0
    let constrainHeight = 10.0
    let scale = constrainHeight/height
    
    let eight = bc_import("eight", convexity: 6)
        .mirror(x: 0, y: 1, z: 0)
        .translate(x: -660, y: 2685, z: 0)
        .scale(x: scale, y: scale, z: scale)
    
    return eight
}