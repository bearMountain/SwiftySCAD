



import Foundation

// Dimensions
let WheelDiameter: Double = 39.84
let WheelWidth: Double = 21.84
let HubDiameter: Double = 17.25
let WheelTopChamferDiameter: Double = (WheelDiameter-HubDiameter)/2.0
let InternalCylinderHeight = WheelWidth.half-WheelTopChamferDiameter.half

let RodDiameter: Double = 2.0
let RodTipLength: Double = 5.2

let ConeBaseDiameter: Double = 2.5
let ConeHeight: Double = 3.0
let TrapTopWidth: Double = 1.0
let TrapBaseWidth: Double = 3.5
let TrapThickness: Double = 2.0

let TredWidth: Double = 3.0
let TredLength: Double = 13.5
let TredDepth: Double = 1.5
let TredAngle: Double = 20.0
let TredNum: Int = 19

// Construction
func wheel() -> String {
    let cOffset = WheelDiameter.half-WheelTopChamferDiameter.half
    
    let c1 = circle(WheelTopChamferDiameter)
        .translate_(x: cOffset, y: 5, z: 0)
    let c2 = mirror(x: 0, y: 1, z: 0, shape: c1)
    
    let raceTrack = [c1, c2]
        .hull_()
    let raceTrackTorus = rotate_extrude(resolution: 100, shape: raceTrack)
    
    let internalCylinder = cylinder(diameter: WheelDiameter-WheelTopChamferDiameter*2.0, height: InternalCylinderHeight)
        .translate_(x: 0, y: 0, z: InternalCylinderHeight.half)
    
    let wheelWithInternalCylinder = [raceTrackTorus, internalCylinder].union_()
    
    let rodNegative = cylinder(diameter: RodDiameter, height: RodTipLength+epsilon)
        .translate_(x: 0, y: 0, z: RodTipLength.half)
    
    let wheelWithRodSlot = [wheelWithInternalCylinder, rodNegative].difference_()
    
    return wheelWithRodSlot
}

func hub() -> String {
    let cone = cylinder(topDiameter: 0, bottomDiameter: ConeBaseDiameter, height: ConeHeight)
        .translate_(x: 0, y: 0, z: TrapThickness.half)
    
    let trapHeight = HubDiameter*0.7
    let trap = trapezoid(topWidth: TrapTopWidth, bottomWidth: TrapBaseWidth,
        height: trapHeight, thickness: TrapThickness)
        .rotate_(x: 90, y: 0, z: 0)
        .translate_(x: 0, y: trapHeight, z: 0)
        .radialArray(5)
    
    return [cone, trap].union_()
}

func truckWheel() -> String {
    let raisedHub = hub().translate_(x: 0, y: 0, z: InternalCylinderHeight+TrapThickness.half)
    
    let together = [wheel(), raisedHub].union_()
    
    //
    
    let cut = cube(x: TredWidth, y: TredLength, z: TredDepth*2.0)
        .translate_(x: 0, y: TredLength.half, z: 0)
        .skew(xOnY: TredAngle)
        .rotate_(x: 90, y: 0, z: 0)
        .translate_(x: 0, y: WheelDiameter.half, z: 0)
        .radialArray(TredNum+1)
    let cut2 = mirror(x: 0, y: 0, z: 1, shape: cut)
        .rotate_(x: 0, y: 0, z: TredAngle.half)
    let cuts = [cut, cut2].and()
    
    let ridged = [together, cuts].difference_()
    
    return ridged
}