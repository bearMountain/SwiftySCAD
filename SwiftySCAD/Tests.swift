




import Foundation

func testEverything() {
    // Cube
    let basicCube = cube(x: 1.1, y: 2, z: 3)
    assert(basicCube == "cube([1.1, 2.0, 3.0], center = true);")
    
    // Tapered Cylinder
    let taperedCylinder = cylinder(topDiameter: 10, bottomDiameter: 5, height: 4)
    assert(taperedCylinder == "cylinder(h = 4.0, r1 = 2.5, r2 = 5.0, center = false);")
    
    // Elipse Distance
    let dist = distance(elipseWidth: 6, elipseHeight: 4, angle: 90)
    assert(dist == 4)
}
