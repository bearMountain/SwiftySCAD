



import Foundation

//
// cylinder(r = 3.5, h = 1, center = true, $fn = 32);
//
func cylinder(radius radius: CGFloat, height: CGFloat) -> String {
    return "cylinder(r = \(radius), h = \(height), center = true, $fn = 32);"
}

func cylinder(diameter diameter: CGFloat, height: CGFloat) -> String {
    return cylinder(radius: diameter/2.0, height: height)
}

//
// cylinder(h = height, r1 = BottomRadius, r2 = TopRadius, center = true/false);
//
func cylinder(topDiameter topDiameter: CGFloat, bottomDiameter: CGFloat, height: CGFloat) -> String {
    return "cylinder(h = \(height), r1 = \(bottomDiameter/2.0), r2 = \(topDiameter/2.0), center = false);"
}

//
// cube([width + height, length, height], center = true);
//
func cube(x x: CGFloat, y: CGFloat, z: CGFloat) -> String {
    return "cube([\(x), \(y), \(z)], center = true);"
}

//
// trapezoid
//
// module trapezoid(width_base, width_top,height,thickness)
//
func trapezoid(topWidth topWidth: CGFloat, bottomWidth: CGFloat, height: CGFloat, thickness: CGFloat) -> String {
    let halfBottom = bottomWidth/2.0
    let halfTop = topWidth/2.0
    
    let points = "points=[[\(halfBottom),0], [\(halfTop),\(height)], [\(-halfTop),\(height)], [\(-halfBottom),0]]"
    let layingTrap = "linear_extrude(height = \(thickness)) polygon(\(points), paths=[[0,1,2,3]]);"
    let verTrap = rotate(x: 90, y: 0, z: 0, shape: layingTrap)
    let centeredTrap = translate(x: 0, y: thickness/2.0, z: 0, shape: verTrap)
    
    return centeredTrap
}

//
// hexagon
//
// circle(20,$fn=6);
//
// width: flat-side to flat-side width measurement
//
func hexagon(width width: CGFloat, thickness: CGFloat) -> String {
    let circleRadius = width.half/(sqrt(3.0)*0.5)
    
    let circle = "linear_extrude(height = \(thickness)) circle(r= \(circleRadius), $fn=6);"
    
    return circle
}


















