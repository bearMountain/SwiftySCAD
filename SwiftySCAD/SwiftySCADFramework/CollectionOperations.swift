



import Foundation

extension SequenceType where Generator.Element == String {
    //
    // Hack to get around the inability to extend [String] directly
    //
    func execute(f: ([String])->(String)) -> String {
        if let array = self as? [String] {
            return f(array)
        } else {
            assertionFailure("Error: function should only be used on String type")
            return ""
        }
    }
    
    //
    // <term> {}
    //
    func aggregate(withTerm term: String) -> String {
        return execute {
            var string = "\(term) {\n"
            string += ($0.joinWithSeparator("\n"))
            string += "\n}"
            
            return string
        }
    }
    
    //
    // "s1\ns2\ns3"
    //
    func and() -> String {
        return self.joinWithSeparator("\n")
    }
    
    //
    // union() {}
    //
    func union() -> String {
        return execute{$0.aggregate(withTerm: "union()")}
    }
    
    //
    // difference() {}
    //
    func difference() -> String {
        return execute{$0.aggregate(withTerm: "difference()")}
    }
    
    //
    // intersection() {}
    //
    func intersection() -> String {
        return execute{$0.aggregate(withTerm: "intersection()")}
    }
    
    //
    // hull() {}
    //
    func hull() -> String {
        return execute{$0.aggregate(withTerm: "hull()")}
    }
    
    func distributeOnCircle(radius radius: Double) -> String {
        return execute({ (shapes) -> (String) in
            let angleInterval = 360.0/Double(shapes.count)
            var distributedShapes: [String] = []
            
            for (i, shape) in shapes.enumerate() {
                let currentAngle = Double(i) * angleInterval
                let distributedShape = shape
                    .rotate(x: 0, y: 0, z: -currentAngle)
                    .translate(x: radius, y: 0, z: 0)
                    .rotate(x: 0, y: 0, z: currentAngle)
                distributedShapes.append(distributedShape)
            }
            
            return distributedShapes.and()
        })
    }
}













