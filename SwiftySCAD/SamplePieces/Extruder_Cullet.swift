


import Foundation

func extruder_cullet() -> String {
    
    let smallHoleDiameter: Double = 5.5
    let largeHoleDiameter: Double = 9.4
    let largeHoleWallThickness: Double = 3.0
    let filamentDiameter: Double = 3.0
    let filamentOffset: Double = 0.5
    let smallHoleHeight: Double = 9.3
    let largeHoleThreadHeight: Double = 5.4
    let jointHeight: Double = 3.0
    
    
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