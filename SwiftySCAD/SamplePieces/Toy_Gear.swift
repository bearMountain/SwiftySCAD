



import Foundation

let thickness = 10.0
let baseWidth = 9.0
let gearRadius = 10.0


let sharpTooth: String = {
    let fin = bezierCurveSolid(p1: p(0,0), c1: p(1,2), c2: p(8,3.5), p2: p(baseWidth,3), focalPoint: p(baseWidth,0), height: thickness, hull: true)
    let cup = bezierCurveSolid(p1: p(7.5,0), c1: p(7.5,1), c2: p(8,2), p2: p(baseWidth,3), focalPoint: p(10,-1), height: thickness*2, hull: true)
        .translate(x: 0, y: 0, z: -thickness.half)
    
    let tipCutBlank = polygon([p(8.5,2.1), p(7.8,4), p(12,7)])
        .linearExtrusion(height: thickness*2)
        .translate(x: 0, y: 0, z: -thickness.half)
    
    
    return [fin, cup, tipCutBlank].difference()
}()

let roundBlank = cylinder(diameter: 0.88, height: thickness, center: false)
    .translate(x: 8.1, y: 2.65, z: 0)
let roundedTooth = [sharpTooth, roundBlank].union()

let gearBody = cylinder(radius: gearRadius+1, height: thickness, center: false)


let rim = roundedTooth
    .translate(x: -baseWidth.half, y: gearRadius, z: 0)
    .radialArray(10)

let gear = [rim, gearBody].union()


let c = cube(x: 10, y: 10, z: 3)