


import Foundation




//
// translate([1,2,3]) {}
//
func translate(x x: CGFloat, y: CGFloat, z: CGFloat, shapes: ()->(String)) -> String {
    let term = "translate([\(x), \(y), \(z)])"
    return aggregate(term: term, shapes: [shapes()])
}

func translate(x x: CGFloat, y: CGFloat, z: CGFloat, shape: String) -> String {
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
func rotate(x x: CGFloat, y: CGFloat, z: CGFloat, shape: String) -> String {
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
func scale(x x: CGFloat, y: CGFloat, z: CGFloat, shape: String) -> String {
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
    func translate_(x x: CGFloat, y: CGFloat, z: CGFloat) -> String {
        return translate(x: x, y: y, z: z, shape: self)
    }
    
    func rotate_(x x: CGFloat, y: CGFloat, z: CGFloat) -> String {
        return rotate(x: x, y: y, z: z, shape: self)
    }
    
    func scale_(x x: CGFloat, y: CGFloat, z: CGFloat) -> String {
        return scale(x: x, y: y, z: z, shape: self)
    }
}