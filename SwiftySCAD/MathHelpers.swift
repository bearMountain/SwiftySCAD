




import Foundation


extension Float {
    var half: Float {
        get {
            return self/2.0
        }
    }
}

func distance(elipseWidth elipseWidth: Float, elipseHeight: Float, angle: Float) -> Float {
    let radians = (Float(M_PI) * angle) / 180.0
    
    let x = elipseWidth.half*cos(radians)
    let y = elipseHeight.half*sin(radians)
    let dist = sqrt(pow(x, 2) + pow(y, 2))
    
    return dist
}

func getXY(elipseWidth elipseWidth: Float, elipseHeight: Float, angle: Float) -> (Float, Float) {
    let radians = (Float(M_PI) * angle) / 180.0
    
    let x = elipseWidth.half*cos(radians)
    let y = elipseHeight.half*sin(radians)
    
    return (x,y)
}