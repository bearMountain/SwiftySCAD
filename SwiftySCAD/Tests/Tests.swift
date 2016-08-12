




import Foundation

func testEverything() {
    // Cube
    let basicCube = cube(x: 1.1, y: 2, z: 3)
    assert(basicCube == "cube([1.1, 2.0, 3.0], center = false);")
    
    // Tapered Cylinder
    let taperedCylinder = cylinder(topDiameter: 10, bottomDiameter: 5, height: 4)
    assert(taperedCylinder == "cylinder(h = 4.0, r1 = 2.5, r2 = 5.0, center = false);")
    
    // Elipse Distance
    let dist = distance(elipseWidth: 6, elipseHeight: 4, angle: 90)
    assert(dist == 2.0)
    
//    // Formatting1
//    _ = {
//        let unformatted = "rotate([0.0, 0.0, 342.0]) {\ncube([3.0, 13.5, 3.0], center = true);\n}\n"
//        let formatted = formatOutput(unformatted)
//        print(formatted)
//    }()
//    
//    // Formatting2
//    _ = {
//        let unformatted = "rotate([0.0, 0.0, 342.0]) {\ntranslate([0.0, 19.92, 0.0]) {\ncube([3.0, 13.5, 3.0], center = true);\n}\n}\n"
//        let formatted = formatOutput(unformatted)
//        print(formatted)
//    }()
//    
//    // Formatting3
//    _ = {
//        let unformatted = "rotate([0.0, 0.0, 342.0]) {\ntranslate([0.0, 19.92, 0.0]) {\nrotate([90.0, 0.0, 0.0]) {\nmatrix = [\n[ 1, 20.0/45, 0.0/45, 0 ],\n[ 0.0/45, 1, 0.0/45, 0 ],\n[ 0.0/45, 0.0/45, 1, 0 ],\n[ 0, 0, 0, 1 ]\n];\nmultmatrix(matrix) {\ntranslate([0.0, 6.75, 0.0]) {\ncube([3.0, 13.5, 3.0], center = true);\n}\n}\n}\n}\n}"
//        let formatted = formatOutput(unformatted)
//        print(formatted)
//    }()
    
    // Polygon
    _ = {
        let points = [p(0,0), p(100,0), p(130,50), p(30,50)]
        let poly = polygon(points)
        assert(poly == "polygon(points=[[0.0, 0.0], [100.0, 0.0], [130.0, 50.0], [30.0, 50.0]]);")
    }()
}









