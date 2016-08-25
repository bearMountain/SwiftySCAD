



import Foundation

private func zero() -> String {
    let bezierPath = BCPolygon()
    bezierPath.moveToPoint(CGPointMake(1068, 2121))
    bezierPath.addLineToPoint(CGPointMake(682, 2208))
    bezierPath.addLineToPoint(CGPointMake(699, 2534))
    bezierPath.addLineToPoint(CGPointMake(1659, 2121))
    bezierPath.addLineToPoint(CGPointMake(1643, 2001))
    bezierPath.addLineToPoint(CGPointMake(1267, 2085))
    bezierPath.addLineToPoint(CGPointMake(1305, 1351))
    bezierPath.addLineToPoint(CGPointMake(1068, 1351))
    bezierPath.addLineToPoint(CGPointMake(884, 1507))
    bezierPath.addLineToPoint(CGPointMake(1035, 1657))
    bezierPath.addLineToPoint(CGPointMake(1096, 1604))
    bezierPath.addLineToPoint(CGPointMake(1068, 2121))
    
    return bezierPath.makeSCAD(height: 29)
}

