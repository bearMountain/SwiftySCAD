



import Foundation

func rawThree() -> String {
    let height = 100.0
    
    let bezierPath = BCPolygon()
    bezierPath.moveToPoint(CGPointMake(1213.5, 1103.5))
    bezierPath.addLineToPoint(CGPointMake(413, 1392))
    bezierPath.addLineToPoint(CGPointMake(434, 1767))
    bezierPath.addLineToPoint(CGPointMake(1153.5, 1391.5))
    bezierPath.addLineToPoint(CGPointMake(942.5, 1659.5))
    bezierPath.addLineToPoint(CGPointMake(1281.5, 1529.5))
    bezierPath.addLineToPoint(CGPointMake(1524.5, 1234.5))
    bezierPath.addLineToPoint(CGPointMake(1213.5, 1103.5))
    let top = bezierPath.makeSCAD(height: height)
    
    let bezier2Path = BCPath()
    bezier2Path.moveToPoint(CGPointMake(1281.5, 1528.5))
    bezier2Path.addCurveToPoint(CGPointMake(1790.5, 1981.5), controlPoint1: CGPointMake(1546.26, 1594.69), controlPoint2: CGPointMake(1769.42, 1787.03))
    bezier2Path.addCurveToPoint(CGPointMake(906.5, 2413.5), controlPoint1: CGPointMake(1824.51, 2295.31), controlPoint2: CGPointMake(1465.86, 2614.15))
    bezier2Path.addLineToPoint(CGPointMake(942.5, 1659.5))
    bezier2Path.addLineToPoint(CGPointMake(1281.5, 1528.5))
    let roughBody = bezier2Path.makeSCAD(height: height)
    
    let bezier3Path = BCPath()
    bezier3Path.moveToPoint(CGPointMake(942.5, 1659.5))
    bezier3Path.addCurveToPoint(CGPointMake(1336.5, 1875.5), controlPoint1: CGPointMake(1177.5, 1631.5), controlPoint2: CGPointMake(1298.9, 1731.28))
    bezier3Path.addCurveToPoint(CGPointMake(1011.5, 2241.5), controlPoint1: CGPointMake(1379.08, 2038.8), controlPoint2: CGPointMake(1352.5, 2278.5))
    bezier3Path.addLineToPoint(CGPointMake(942.5, 1659.5))
    let roundCut = bezier3Path.makeSCAD(height: height)
    
    let bezier4Path = BCPolygon()
    bezier4Path.moveToPoint(CGPointMake(936.5, 1616.5))
    bezier4Path.addLineToPoint(CGPointMake(1027.5, 2214.5))
    bezier4Path.addLineToPoint(CGPointMake(886.5, 2446.5))
    bezier4Path.addLineToPoint(CGPointMake(936.5, 1616.5))
    let triangleCut = bezier4Path.makeSCAD(height: height)
    
    let rough = [top, roughBody].union()
    let three = [rough, roundCut, triangleCut].difference()
    
    return three
}

func normalizedThree() -> String {
    let height = 1400.0
    let constrainHeight = 10.0
    let scale = constrainHeight/height
    
    let three = bc_import("three", convexity: 6)
        .mirror(x: 0, y: 1, z: 0)
        .translate(x: -410, y: 2480, z: 0)
        .scale(x: scale, y: scale, z: scale)
    
    return three
}