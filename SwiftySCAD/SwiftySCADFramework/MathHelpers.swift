




import Foundation


extension Double {
    var half: Double {
        get {
            return self/2.0
        }
    }
}

func distance(elipseWidth elipseWidth: Double, elipseHeight: Double, angle: Double) -> Double {
    let radians = (Double(M_PI) * angle) / 180.0
    
    let x = elipseWidth.half*cos(radians)
    let y = elipseHeight.half*sin(radians)
    let dist = sqrt(pow(x, 2) + pow(y, 2))
    
    return dist
}

func getXY(elipseWidth elipseWidth: Double, elipseHeight: Double, angle: Double) -> (Double, Double) {
    let radians = (Double(M_PI) * angle) / 180.0
    
    let x = elipseWidth.half*cos(radians)
    let y = elipseHeight.half*sin(radians)
    
    return (x,y)
}