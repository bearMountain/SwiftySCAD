


import Foundation

func extruder_cullet() -> String {
    
    let smallHoleDiameter: Float = 5.5
    let largeHoleDiameter: Float = 9.4
    let largeHoleWallThickness: Float = 3.0
    let filamentDiameter: Float = 3.0
    let filamentOffset: Float = 0.5
    let smallHoleHeight: Float = 9.3
    let largeHoleThreadHeight: Float = 5.4
    let jointHeight: Float = 3.0
    
    
    let smallCylinder = translate(x: 0, y: 0, z: -smallHoleHeight/2.0) {
        cylinder(diameter: smallHoleDiameter, height: smallHoleHeight)
    }
    
    let bigCylinder = translate(x: 0, y: 0, z: -(smallHoleHeight+largeHoleThreadHeight/2.0)) {
        let bigCylinder = cylinder(diameter: largeHoleDiameter+largeHoleWallThickness*2, height: largeHoleThreadHeight+jointHeight)
        let threadPlaceholder = translate(x: 0, y: 0, z: -(epsilon_2+jointHeight)) {
            cylinder(diameter: largeHoleDiameter, height: largeHoleThreadHeight+epsilon)
        }
        
        return difference(shapes: [bigCylinder, threadPlaceholder])
    }
    
    
    
    let cylinders = union(shapes: [smallCylinder, bigCylinder])
    let filamentPlaceholder = cylinder(diameter: filamentDiameter+filamentOffset, height: 40)
    let piece = difference(shapes: [cylinders, filamentPlaceholder])

    return piece
}