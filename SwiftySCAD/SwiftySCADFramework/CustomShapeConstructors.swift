



import Foundation

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
        let obj = seedObject.translate(x: currentX, y: 0, z: yVal)
        placeholders.append(obj)
        
        currentX += displayStep
    }
    
    return placeholders.hull()
}

