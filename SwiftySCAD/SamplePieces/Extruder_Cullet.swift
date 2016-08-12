


import Foundation

func extruder_collet() -> String {
    
    let smallHoleDiameter: Double = 5.5
    let largeHoleDiameter: Double = 9.4
    let largeHoleWallThickness: Double = 3.0
    let filamentDiameter: Double = 3.0
    let filamentOffset: Double = 0.5
    let smallHoleHeight: Double = 9.3
    let largeHoleThreadHeight: Double = 5.4
    let jointHeight: Double = 3.0
    
    
    let smallCylinder = cylinder(diameter: smallHoleDiameter, height: smallHoleHeight)
        .translate(x: 0, y: 0, z: -smallHoleHeight/2.0)
    
    
    let bigCylinder = cylinder(diameter: largeHoleDiameter+largeHoleWallThickness*2, height: largeHoleThreadHeight+jointHeight)
    let threadPlaceholder = cylinder(diameter: largeHoleDiameter, height: largeHoleThreadHeight+epsilon)
        .translate(x: 0, y: 0, z: -(epsilon_2+jointHeight))
    
    let together = [bigCylinder, threadPlaceholder].difference()
        .translate(x: 0, y: 0, z: -(smallHoleHeight+largeHoleThreadHeight/2.0))

    
    
    
    let cylinders = [smallCylinder, together].union()
    let filamentPlaceholder = cylinder(diameter: filamentDiameter+filamentOffset, height: 40)
    let piece = [cylinders, filamentPlaceholder].difference()

    return piece
}