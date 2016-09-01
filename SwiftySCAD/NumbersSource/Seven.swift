



import Foundation

func normalizedSeven() -> String {
    let bezierPath = BCPolygon()
    bezierPath.moveToPoint(CGPointMake(818.5, 1410.5))
    bezierPath.addLineToPoint(CGPointMake(1767.5, 1036.5))
    bezierPath.addLineToPoint(CGPointMake(1575.5, 2712.5))
    bezierPath.addLineToPoint(CGPointMake(1174.5, 2821.5))
    bezierPath.addLineToPoint(CGPointMake(1523.5, 1410.5))
    bezierPath.addLineToPoint(CGPointMake(732.5, 1920.5))
    bezierPath.addLineToPoint(CGPointMake(818.5, 1410.5))
    let seven = bezierPath.makeSCAD(height: 2, normalize: true)
    
    return seven
}
