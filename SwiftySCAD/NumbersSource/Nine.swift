//
//  Nine.swift
//  SwiftySCAD
//
//  Created by Jeffrey Camealy on 8/24/16.
//  Copyright © 2016 Branch Computing. All rights reserved.
//

import Foundation

func nine() -> String {
    let bezierPath = BCPath()
    bezierPath.moveToPoint(CGPointMake(748.5, 520.5))
    bezierPath.addCurveToPoint(CGPointMake(732.5, 1016.5), controlPoint1: CGPointMake(748.5, 520.5), controlPoint2: CGPointMake(750.5, 974.5))
    bezierPath.addCurveToPoint(CGPointMake(843.5, 1650.5), controlPoint1: CGPointMake(714.5, 1058.5), controlPoint2: CGPointMake(724.5, 1497.5))
    bezierPath.addLineToPoint(CGPointMake(1003.5, 1530.5))
    bezierPath.addLineToPoint(CGPointMake(835.5, 514.5))
    bezierPath.addLineToPoint(CGPointMake(748.5, 520.5))
    
    let bezier2Path = BCPath()
    bezier2Path.moveToPoint(CGPointMake(835.5, 513.5))
    bezier2Path.addCurveToPoint(CGPointMake(1003.5, 1530.5), controlPoint1: CGPointMake(828.5, 931.5), controlPoint2: CGPointMake(862.5, 1346.5))
    bezier2Path.addLineToPoint(CGPointMake(835.5, 513.5))
    
    let bezier3Path = BCPath()
    bezier3Path.moveToPoint(CGPointMake(749, 604))
    bezier3Path.addCurveToPoint(CGPointMake(255, 844), controlPoint1: CGPointMake(529, 414), controlPoint2: CGPointMake(264.81, 646.17))
    bezier3Path.addCurveToPoint(CGPointMake(733, 1016), controlPoint1: CGPointMake(244.54, 1054.99), controlPoint2: CGPointMake(461, 1262))
    bezier3Path.addLineToPoint(CGPointMake(749, 604))
    
    let bezier4Path = BCPath()
    bezier4Path.moveToPoint(CGPointMake(744.5, 722.5))
    bezier4Path.addCurveToPoint(CGPointMake(537.5, 770.5), controlPoint1: CGPointMake(654.5, 638.5), controlPoint2: CGPointMake(546.5, 679.5))
    bezier4Path.addCurveToPoint(CGPointMake(741, 805), controlPoint1: CGPointMake(526.67, 880.05), controlPoint2: CGPointMake(667.5, 926.5))
    bezier4Path.addLineToPoint(CGPointMake(744.5, 722.5))
    
    
    let height = 2.0
    
    let roughShaft = bezierPath.makeSCAD(height: height)
    let shaftCurveCutout = bezier2Path.makeSCAD(height: height)
    
    let roughBulb = bezier3Path.makeSCAD(height: height)
    let bulbCutout = bezier4Path.makeSCAD(height: height)
    let bulb = [roughBulb, bulbCutout].difference()
    
    let shaft = [roughShaft, shaftCurveCutout].difference()
    let nine = [bulb, shaft].union()
    
    return nine
}