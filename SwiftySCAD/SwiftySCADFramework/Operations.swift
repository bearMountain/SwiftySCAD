


import Foundation




//
// translate([1,2,3]) {}
//
func translate(x x: Double, y: Double, z: Double, shapes: ()->(String)) -> String {
    let term = "translate([\(x), \(y), \(z)])"
    return aggregate(term: term, shapes: [shapes()])
}

func translate(x x: Double, y: Double, z: Double, shape: String) -> String {
    return translate(x: x, y: y, z: z) {
        return shape
    }
}


//
// difference() {}
//
func difference(shapes shapes:[String]) -> String {
    return aggregate(term: "difference()", shapes: shapes)
}

//
// union() {}
//
func union(shapes shapes:[String]) -> String {
    return aggregate(term: "union()", shapes: shapes)
}

//
// intersection() {}
//
func intersection(shapes shapes:[String]) -> String {
    return aggregate(term: "intersection()", shapes: shapes)
}

//
// rotate([90, 0, 0]) {}
//
func rotate(x x: Double, y: Double, z: Double, shape: String) -> String {
    let term = "rotate([\(x), \(y), \(z)])"
    return aggregate(term: term, shape: shape)
}

//
// hull() {}
//
func hull(shapes shapes:[String]) -> String {
    return aggregate(term: "hull()", shapes: shapes)
}

//
// scale([1, 2, 3]) {}
//
func scale(x x: Double, y: Double, z: Double, shape: String) -> String {
    let term = "scale([\(x), \(y), \(z)])"
    return aggregate(term: term, shape: shape)
}

//
// rotate_extrude(angle = 360, convexity = 10, $fn = 100)
//
func rotate_extrude(angle: Int = 360, convexity: Int = 10, resolution: Int = 10, shape: String) -> String {
    let term = "rotate_extrude(angle = \(angle), convexity = \(convexity), $fn = \(resolution))"
    return aggregate(term: term, shape: shape)
}

//
// mirror(v= [x, y, z] ) { ... }
// x, y, z parameters used to contstruct normal vector for mirror plane through origin
//
func mirror(x x: Int, y: Int, z: Int, shape: String) -> String {
    let term = "mirror(v = [\(x), \(y), \(z)])"
    return aggregate(term: term, shape: shape)
}



// ===========================================================================
// ===========================================================================

func aggregate(term term: String, shapes: [String]) -> String {
    var string = "\(term) {\n"
    string += (shapes.joinWithSeparator("\n"))
    string += "\n}"
    
    return string
}

func aggregate(term term: String, shape: String) -> String {
    var string = "\(term) {\n\t"
    string += shape
    string += "\n}"
    
    return string
}


extension String {
    func translate_(x x: Double, y: Double, z: Double) -> String {
        return translate(x: x, y: y, z: z, shape: self)
    }
    
    func rotate_(x x: Double, y: Double, z: Double) -> String {
        return rotate(x: x, y: y, z: z, shape: self)
    }
    
    func scale_(x x: Double, y: Double, z: Double) -> String {
        return scale(x: x, y: y, z: z, shape: self)
    }
}

func solidFrom(curve f: (Double)->(Double), maxX: Double = 1, resolution: Double = 10, displaySize: Size, seedObject: String) -> String
{
    let numericalStep = (maxX*2.0)/resolution
    let xVals = maxX.stride(to: -(maxX), by: -numericalStep)
    let yVals = xVals.map(f)
    let maxYVal = yVals.maxElement()
    let minYVal = yVals.minElement()
    let range = maxYVal! - minYVal!
    let displayStep = (displaySize.width*2.0)/resolution
    
    var placeholders: [String] = []
    var currentX = -displaySize.width
    for (i, _) in xVals.enumerate() {
        let yVal = (yVals[i]/range) * displaySize.height
        let obj = translate(x: currentX, y: 0, z: yVal, shape: seedObject)
        placeholders.append(obj)
        
        currentX += displayStep
    }
    
    return hull(shapes: placeholders)
}

extension String {
    func radialArray(numCopies: Int) -> String {
        let angle = 360.0/Double(numCopies)
        var copies: [String] = []
        
        for i in 0..<numCopies {
            let copy = self.rotate_(x: 0, y: 0, z: angle*Double(i))
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
        return aggregate(term: term, shape: self)
    }
}

extension SequenceType where Generator.Element == String {
    func and() -> String {
        return self.joinWithSeparator("\n")
    }
    
    func union_() -> String {
        if let array = self as? [String] {
            return union(shapes: array)
        } else {
            return ""
        }
    }
    
    func difference_() -> String {
        if let array = self as? [String] {
            return difference(shapes: array)
        } else {
            return ""
        }
    }
    
    func hull_() -> String {
        if let array = self as? [String] {
            return hull(shapes: array)
        } else {
            return ""
        }
    }
}







