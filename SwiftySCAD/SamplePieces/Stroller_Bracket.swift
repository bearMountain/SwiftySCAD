




import Foundation

func stroller_bracket() -> String {
    let span: Double = 330
    let gripBonus: Double = 3
//    let barDiameter: Double = 6.5
//    let forkWidth: Double = 50
    
    let length = span+gripBonus*2
//    let blank = cube(x: length, y: forkWidth, z: length)
    
    

    
    let bracketCurve: (Double)->(Double) = { x in
        -pow(x, 10)
    }
    
    let blankSeed = cube(x: 5, y: 80, z: 5)
    let blankSize = Size(width: length, height: 50)
    let curvedBlank = solidFrom(curve: bracketCurve,
                           resolution: 30,
                          displaySize: blankSize,
                           seedObject: blankSeed)
    
    let voidSeed = cube(x: 5, y: 80+5, z: 5)
    let voidSize = Size(width: length-10, height: 50)
    let blankVoid = solidFrom(curve: bracketCurve,
                         resolution: 30,
                        displaySize: voidSize,
                         seedObject: voidSeed)
    let droppedCopy = blankVoid.translate(x: 0, y: 0, z: -15)
    
    let piece = [curvedBlank, droppedCopy].difference()
    
    return piece
}
