



import Foundation

extension String {
    //
    // <term> {}
    //
    func aggregate(withTerm term: String) -> String {
        var string = "\(term) {\n\t"
        string += self
        string += "\n}"
        
        return string
    }
    
    //
    // translate([1,2,3]) {}
    //
    func translate(x x: Double = 0, y: Double = 0, z: Double = 0) -> String {
        let term = "translate([\(x), \(y), \(z)])"
        return self.aggregate(withTerm: term)
    }
    
    //
    // rotate([90, 0, 0]) {}
    //
    func rotate(x x: Double, y: Double, z: Double) -> String {
        let term = "rotate([\(x), \(y), \(z)])"
        return self.aggregate(withTerm: term)
    }
    
    //
    // scale([1, 2, 3]) {}
    //
    func scale(x x: Double, y: Double, z: Double) -> String {
        let term = "scale([\(x), \(y), \(z)])"
        return self.aggregate(withTerm: term)
    }
    
    func scale(factor: Double) -> String {
        return scale(x: factor, y: factor, z: factor)
    }
    
    //
    // rotate_extrude(angle = 360, convexity = 10, $fn = 100)
    //
    func rotate_extrude(angle: Int = 360, convexity: Int = 10, resolution: Int = 10) -> String {
        let term = "rotate_extrude(angle = \(angle), convexity = \(convexity), $fn = \(resolution))"
        return self.aggregate(withTerm: term)
    }
    
    //
    // mirror(v= [x, y, z] ) { ... }
    // x, y, z parameters used to contstruct normal vector for mirror plane through origin
    //
    func mirror(x x: Int, y: Int, z: Int) -> String {
        let term = "mirror(v = [\(x), \(y), \(z)])"
        return self.aggregate(withTerm: term)
    }
    
    //
    // color( [r, g, b, a] ) { ... }
    //
    func color(r r: Double, g: Double, b: Double, a: Double = 1) -> String {
        let term = "color([\(r), \(g), \(b), \(a)])"
        return self.aggregate(withTerm: term)
    }

    func radialArray(numCopies: Int) -> String {
        let angle = 360.0/Double(numCopies)
        var copies: [String] = []
        
        for i in 0..<numCopies {
            let copy = self.rotate(x: 0, y: 0, z: angle*Double(i))
            copies.append(copy)
        }
        
        return copies.and()
    }
    

    func skew(xOnY xOnY: Double = 0, xOnZ: Double = 0, yOnX: Double = 0, yOnZ: Double = 0, zOnX: Double = 0, zOnY: Double = 0) -> String {
        let matrix = ["matrix = [",
            "[ 1, \(xOnY)/45, \(xOnZ)/45, 0 ],",
            "[ \(yOnX)/45, 1, \(zOnX)/45, 0 ],",
            "[ \(zOnY)/45, \(yOnZ)/45, 1, 0 ],",
            "[ 0, 0, 0, 1 ]",
        "];"]
        
        let expression = "multmatrix(matrix) {\n" + self + "\n}"


        return matrix.joinWithSeparator("\n") + "\n" + expression
    }
    
    //
    // linear_extrude(height = \(thickness))
    //
    func linearExtrusion(height height: Double) -> String {
        let term = "linear_extrude(height = \(height))"
        return self.aggregate(withTerm: term)
    }
}










