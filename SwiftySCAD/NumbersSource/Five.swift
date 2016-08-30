



import Foundation

func rawFive() -> String {
    let height = 100.0
    
    let bezierPath = BCPath()
    bezierPath.moveToPoint(CGPointMake(1126.5, 1736.5))
    bezierPath.addCurveToPoint(CGPointMake(1546.5, 2479.5), controlPoint1: CGPointMake(1581.5, 1871.5), controlPoint2: CGPointMake(1738.5, 2145.5))
    bezierPath.addCurveToPoint(CGPointMake(933.5, 2683.5), controlPoint1: CGPointMake(1445.74, 2654.78), controlPoint2: CGPointMake(1188.28, 2726.76))
    bezierPath.addCurveToPoint(CGPointMake(479.5, 2479.5), controlPoint1: CGPointMake(745.49, 2651.58), controlPoint2: CGPointMake(545.74, 2530.03))
    bezierPath.addLineToPoint(CGPointMake(1126.5, 1736.5))
    let roughBulb = bezierPath.makeSCAD(height: height)
    
    
    
    //// Bezier 2 Drawing
    let bezier2Path = BCPolygon()
    bezier2Path.moveToPoint(CGPointMake(1667, 1696))
    bezier2Path.addLineToPoint(CGPointMake(1689, 1290))
    bezier2Path.addLineToPoint(CGPointMake(762, 1502))
    bezier2Path.addLineToPoint(CGPointMake(636.5, 1878.5))
    bezier2Path.addLineToPoint(CGPointMake(1126.5, 1736.5))
    bezier2Path.addLineToPoint(CGPointMake(1667, 1696))
    let roughCap = bezier2Path.makeSCAD(height: height)
    
    
    
    //// Bezier 3 Drawing
    let bezier3Path = BCPath()
    bezier3Path.moveToPoint(CGPointMake(762, 1502))
    bezier3Path.addCurveToPoint(CGPointMake(1689, 1290), controlPoint1: CGPointMake(978.5, 1497.5), controlPoint2: CGPointMake(1689, 1290))
    bezier3Path.addLineToPoint(CGPointMake(762, 1502))
    let capCut = bezier3Path.makeSCAD(height: height)
    
    let bezier4Path = BCPath()
    bezier4Path.moveToPoint(CGPointMake(637, 1878))
    bezier4Path.addCurveToPoint(CGPointMake(987, 1899), controlPoint1: CGPointMake(815.5, 1825.5), controlPoint2: CGPointMake(937.5, 1880.5))
    bezier4Path.addLineToPoint(CGPointMake(989.5, 1898.5))
    bezier4Path.addLineToPoint(CGPointMake(637, 1878))
    let connectorCut = bezier4Path.makeSCAD(height: height)
    
    
    let bezier5Path = BCPath()
    bezier5Path.moveToPoint(CGPointMake(983.5, 1897.5))
    bezier5Path.addCurveToPoint(CGPointMake(652.5, 2279.5), controlPoint1: CGPointMake(1170.5, 1993.5), controlPoint2: CGPointMake(1144.5, 2487.5))
    bezier5Path.addLineToPoint(CGPointMake(983.5, 1897.5))
    let bulbCut = bezier5Path.makeSCAD(height: height)
    
    
    let bezier6Path = BCPolygon()
    bezier6Path.moveToPoint(CGPointMake(637.5, 1877.24))
    bezier6Path.addLineToPoint(CGPointMake(1127.5, 1734.5))
    bezier6Path.addLineToPoint(CGPointMake(1022.5, 1900.5))
    bezier6Path.addLineToPoint(CGPointMake(637.5, 1877.24))
    let roughConnector = bezier6Path.makeSCAD(height: height)
    
    let cap = [roughCap, capCut].difference()
    let bulb = [roughBulb, bulbCut].difference()
    let connector = [roughConnector, connectorCut].difference()
    let five = [cap, connector, bulb].union()
    
    return five
}

func normalizedFive() -> String {
    let height = 1400.0
    let constrainHeight = 10.0
    let scale = constrainHeight/height
    
    let five = bc_import("five", convexity: 6)
        .mirror(x: 0, y: 1, z: 0)
        .translate(x: -480, y: 2700, z: 0)
        .scale(x: scale, y: scale, z: scale)
    
    return five
}