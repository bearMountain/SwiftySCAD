




import Foundation


extension CGFloat {
    var half: CGFloat {
        get {
            return self/2.0
        }
    }
}

func distance(elipseWidth elipseWidth: CGFloat, elipseHeight: CGFloat, angle: CGFloat) -> CGFloat {
    let radians = (CGFloat(M_PI) * angle) / 180.0
    
    let x = elipseWidth.half*cos(radians)
    let y = elipseHeight.half*sin(radians)
    let dist = sqrt(pow(x, 2) + pow(y, 2))
    
    return dist
}

func getXY(elipseWidth elipseWidth: CGFloat, elipseHeight: CGFloat, angle: CGFloat) -> (CGFloat, CGFloat) {
    let radians = (CGFloat(M_PI) * angle) / 180.0
    
    let x = elipseWidth.half*cos(radians)
    let y = elipseHeight.half*sin(radians)
    
    return (x,y)
}