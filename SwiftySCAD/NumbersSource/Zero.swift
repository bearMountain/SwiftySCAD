



import Foundation

private func zero() -> String {
    let bezierPath = BCPath()
    bezierPath.moveToPoint(CGPointMake(312.66, 1156.85))
    bezierPath.addCurveToPoint(CGPointMake(694.66, 18.85), controlPoint1: CGPointMake(-206.34, 977.85), controlPoint2: CGPointMake(-79.34, -159.15))
    bezierPath.addCurveToPoint(CGPointMake(312.66, 1156.85), controlPoint1: CGPointMake(1468.66, 196.85), controlPoint2: CGPointMake(831.66, 1335.85))
    
    let bezier2Path = BCPath()
    bezier2Path.moveToPoint(CGPointMake(382.5, 896.5))
    bezier2Path.addCurveToPoint(CGPointMake(502.5, 455.5), controlPoint1: CGPointMake(241.5, 829.5), controlPoint2: CGPointMake(285.5, 386.5))
    bezier2Path.addCurveToPoint(CGPointMake(382.5, 896.5), controlPoint1: CGPointMake(719.5, 524.5), controlPoint2: CGPointMake(523.5, 963.5))
    
    let zero = [bezierPath.makeSCAD(height: 20), bezier2Path.makeSCAD(height: 20)].difference()
    
    return zero
}