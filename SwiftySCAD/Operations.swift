


import Foundation




//
// translate([1,2,3]) {}
//
func translate(x x: Float, y: Float, z: Float, shapes: ()->(String)) -> String {
    let term = "translate([\(x), \(y), \(z)])"
    return aggregate(term: term, shapes: [shapes()])
}

func translate(x x: Float, y: Float, z: Float, shape: String) -> String {
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
func rotate(x x: Float, y: Float, z: Float, shape: String) -> String {
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
func scale(x x: Float, y: Float, z: Float, shape: String) -> String {
    let term = "scale([\(x), \(y), \(z)])"
    return aggregate(term: term, shape: shape)
}



// ===========================================================================
// ===========================================================================

func aggregate(term term: String, shapes: [String]) -> String {
    var string = "\(term) {\n\t"
    string += (shapes.joinWithSeparator("\n\t"))
    string += "\n}\n"
    
    return string
}

func aggregate(term term: String, shape: String) -> String {
    var string = "\(term) {\n\t"
    string += shape
    string += "\n}\n"
    
    return string
}


extension String {
    func translate_(x x: Float, y: Float, z: Float) -> String {
        return translate(x: x, y: y, z: z, shape: self)
    }
    
    func rotate_(x x: Float, y: Float, z: Float) -> String {
        return rotate(x: x, y: y, z: z, shape: self)
    }
    
    func scale_(x x: Float, y: Float, z: Float) -> String {
        return scale(x: x, y: y, z: z, shape: self)
    }
}

func solidFrom(curve f: (Float)->(Float), maxX: Float = 1, resolution: Float = 10, displaySize: Size, seedObject: String) -> String
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
}







