




import Foundation

func stroller_bracket() -> String {
    let span: CGFloat = 330
    let gripBonus: CGFloat = 3
    let barDiameter: CGFloat = 6.5
    let forkWidth: CGFloat = 50
    
    let length = span+gripBonus*2
    let blank = cube(x: length, y: forkWidth, z: length)
    
    
    func graph(f: (CGFloat)->(CGFloat), maxX: CGFloat = 1, resolution: CGFloat = 10, displaySize: CGSize, seedObject: String) -> String
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
    
    let square: (CGFloat)->(CGFloat) = { x in
        -pow(x, 10)
    }
    
    let blankSeed = cube(x: 5, y: 80, z: 5)
    let blankSize = CGSize(width: length, height: 50)
    let curvedBlank = graph(square,
                            resolution: 30,
                            displaySize: blankSize,
                            seedObject: blankSeed)
    
    let voidSeed = cube(x: 5, y: 80+5, z: 5)
    let voidSize = CGSize(width: length-10, height: 50)
    let blankVoid = graph(square,
                          resolution: 30,
                          displaySize: voidSize,
                          seedObject: voidSeed)
    let droppedCopy = translate(x: 0, y: 0, z: -15, shape: blankVoid)
    
    let piece = difference(shapes: [curvedBlank, droppedCopy])
    
    return piece
}
