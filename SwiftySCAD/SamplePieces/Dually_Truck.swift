//
//  Dually_Truck.swift
//  SwiftySCAD
//
//  Created by Jeffrey Camealy on 8/16/16.
//  Copyright © 2016 Branch Computing. All rights reserved.
//

import Foundation

func duallyTruck() -> String {
    // ================================================================================================
    // Constants
    // ================================================================================================
    
    let defaultCurveResolution = 20.0
    
    // Truck Body
    struct TBody {
        static let height = 52.5
        static let width = 52.0
        static let bigBlockWidth = 30.0
        static let smallBlockWidth = 35.0
        static let smallBlockHeight = TBody.height-20
        
        // Windshield Curve
        static let windshieldP1 = p(-15.5, 0)
        static let windshieldP2 = p(0, TBody.height-TBody.smallBlockHeight)
        static let windshieldC1 = p(-14.5, 9)
        static let windshieldC2 = p(-6.5, TBody.height-TBody.smallBlockHeight-2.0)
        
        // Hood Curve
        static let hoodP1 = p(-(TBody.smallBlockWidth+TBody.windshieldP1.x+3.0), 0.0)
        static let hoodP2 = p(0, 6)
        static let hoodC1 = p(TBody.hoodP1.x+3.5, 3.5)
        static let hoodC2 = p(-3.5, TBody.hoodP2.y-0.5)
    }
    
    
    
    let bumperWidth = 5.0
    let bumperPoints = [p(0,0), p(0, 17.5), p(-bumperWidth, 12.5), p(-bumperWidth, 4), p(-(bumperWidth-3.0), 0)]
    
    let wellCurveWidth = TBody.smallBlockWidth*0.75
    let wellCurveControlHeight = wellCurveWidth*0.25
    let wellCurveStartHeight = TBody.smallBlockHeight*0.3
    let wellStart = TBody.bigBlockWidth*0.8
    let wellTriangleHeight = 5.0
    
    let tireDiameter = wellCurveWidth*1.2
    let tireWidth = tireDiameter*0.4
    let tireLift = wellCurveWidth.half*0.8
    let tireOutOverhang = tireWidth*0.5
    
    let backWindowWidth = TBody.bigBlockWidth*0.4
    let windowBaseLine = TBody.smallBlockHeight+TBody.hoodP2.y
    let windowFrameWidth = 3.0
    let windowHeight = TBody.height-windowBaseLine-windowFrameWidth
    
    let frontWindowTopWidth = TBody.bigBlockWidth-(backWindowWidth+windowFrameWidth*2)
    let frontWindowBottomWidth = frontWindowTopWidth+TBody.smallBlockWidth*0.28
    
    let bigBlockTopSize = Size(width: TBody.bigBlockWidth, height: TBody.width)
    let sunroofSize = bigBlockTopSize.inset(widthBy: windowFrameWidth, heightBy: windowFrameWidth)
    let sunroofBlankHeight = TBody.height.half
    
    let personBlankDiameter = 17.5
    let personBlankHeight = 9.0
    
    let axelDiameter = 3.5
    
    
    // ================================================================================================
    // Construction
    // ================================================================================================
    
    //
    // Main Body
    //
    let bigBlock = cube(x: TBody.bigBlockWidth, y: TBody.width, z: TBody.height)
        .translate(x: -TBody.bigBlockWidth, y: 0, z: 0)
    
    let littleBlock = cube(x: TBody.smallBlockWidth, y: TBody.width, z: TBody.smallBlockHeight)
        .translate(x: -(TBody.bigBlockWidth+TBody.smallBlockWidth), y: 0, z: 0)
    
    
    let windshieldCurve = bezierCurveSolid(p1: TBody.windshieldP1, c1: TBody.windshieldC1, c2: TBody.windshieldC2, p2: TBody.windshieldP2, focalPoint: p(0,0), height: TBody.width, resolution: defaultCurveResolution, displayPoints: false)
        .rotate(x: 90, y: 0, z: 0)
        .translate(x: -TBody.bigBlockWidth, y: TBody.width, z: TBody.smallBlockHeight)
    
    let hoodCurve = bezierCurveSolid(p1: TBody.hoodP1, c1: TBody.hoodC1, c2: TBody.hoodC2, p2: TBody.hoodP2, focalPoint: p(0, 0), height: TBody.width, resolution: defaultCurveResolution, displayPoints: false)
        .rotate(x: 90, y: 0, z: 0)
        .translate(x: -(TBody.bigBlockWidth)-(TBody.smallBlockWidth+TBody.hoodP1.x), y: TBody.width, z: TBody.smallBlockHeight)
    
    let bumper = polygon(bumperPoints)
        .linearExtrusion(height: TBody.width)
        .rotate(x: 90, y: 0, z: 0)
        .translate(x: -(TBody.bigBlockWidth+TBody.smallBlockWidth), y: TBody.width, z: 0)
    
    
    //
    // Wheel Well
    //
    let wellCurve = [bezierCurveSolid(p1: p(-wellCurveWidth,0), c1: p(-wellCurveWidth, wellCurveControlHeight), c2: p(0, wellCurveControlHeight), p2: p(0,0), focalPoint: p(0,0), height: TBody.width)]
        .hull()
        .rotate(x: 90, y: 0, z: 0)
        .translate(x: -wellStart, y: TBody.width, z: wellCurveStartHeight)
    
    let wellSquare = cube(x: wellCurveWidth, y: TBody.width, z: wellCurveStartHeight)
        .translate(x: -(wellCurveWidth+wellStart), y: 0, z: 0)
    
    let wellTriangle = polygon([p(0,0), p(0, wellTriangleHeight), p(-(wellTriangleHeight+2.5),0)])
        .linearExtrusion(height: TBody.width)
        .rotate(x: 90, y: 0, z: 0)
        .translate(x: -(wellStart+wellCurveWidth), y: TBody.width, z: 0)
    let wellSliver = polygon([p(0,0), p(0,wellCurveStartHeight), p(wellCurveStartHeight*0.2,0)])
        .linearExtrusion(height: TBody.width)
        .rotate(x: 90, y: 0, z: 0)
        .translate(x: -(wellStart), y: TBody.width, z: 0)
    
    let well = [wellCurve, wellSquare, wellTriangle, wellSliver].union()
    
    //
    // Tires
    //
    let tire1 = cylinder(diameter: tireDiameter, height: tireWidth, center: false)
        .rotate(x: -90, y: 0, z: 0)
        .translate(x: -(wellCurveWidth.half+wellStart), y: -tireOutOverhang, z: -tireLift)
    let tire2 = tire1
        .translate(x: 0, y: TBody.width-(tireWidth-tireOutOverhang*2.0), z: 0)
    let tires = [tire1, tire2].union()
        .color(r: 0.3, g: 0.3, b: 0.3)
    
    //
    // Side Windows
    //
    let backWindowBlank = cube(x: backWindowWidth, y: TBody.width, z: windowHeight)
        .translate(x: -(windowFrameWidth+backWindowWidth), y: 0, z: TBody.height-(windowFrameWidth+windowHeight))
    
    let frontWindowBlank = polygon([
        p(0,0),
        p(0, windowHeight),
        p(-frontWindowTopWidth, windowHeight),
        p(-frontWindowBottomWidth,0)
        ])
        .linearExtrusion(height: TBody.width+big_epsilon)
        .rotate(x: 90, y: 0, z: 0)
        .translate(x: -(windowFrameWidth*2+backWindowWidth), y: TBody.width+big_epsilon, z: windowBaseLine)
    
    
    //
    // BigCutouts
    //
    let sunroofBlank = cube(x: sunroofSize.width, y: sunroofSize.height, z: sunroofBlankHeight)
        .translate(x: -(sunroofSize.width+windowFrameWidth), y: windowFrameWidth, z: TBody.height-sunroofBlankHeight)
    
    let windshieldBlank = cube(x: frontWindowBottomWidth, y: TBody.width-windowFrameWidth*2, z: windowHeight)
        .translate(x: -frontWindowBottomWidth-TBody.bigBlockWidth, y: windowFrameWidth, z: windowBaseLine)
    
    let personBlank1 = cylinder(diameter: personBlankDiameter, height: personBlankHeight, center: false)
        .translate(x: -TBody.bigBlockWidth.half, y: sunroofSize.height/4.0, z: 0)
    let personBlank2 = personBlank1
        .translate(x: 0, y: sunroofSize.height.half, z: 0)
    
    let peopleBlanks = [personBlank1, personBlank2].union()
        .translate(x: 0, y: windowFrameWidth, z: TBody.height-sunroofBlankHeight-personBlankHeight)
    
    let fullTruckLength = 135.0
    let truckBackLength = fullTruckLength - (TBody.bigBlockWidth+TBody.smallBlockWidth)
    let bedSpacerWidth = 2.0
    let bedLength = truckBackLength-bedSpacerWidth
    let toolboxHeight = TBody.height*0.2
    let toolboxWidth = bedLength*0.3
    let bedHeight = TBody.height-(bedSpacerWidth+toolboxHeight)
    let bedThickness = 5.0
    
    let lowerBed = cube(x: bedLength, y: TBody.width, z: bedThickness)
    let upperBed = cube(x: bedThickness, y: TBody.width, z: bedHeight)
    
    let toolBox = cube(x: toolboxWidth, y: TBody.width, z: toolboxHeight)
        .translate(x: bedSpacerWidth, y: 0, z: 0)
    let insetRatio = 0.9
    let toolBoxSpacer = toolBox.scale(x: 1, y: insetRatio, z: 1)
    let bedSpacer = upperBed.scale(x: 1, y: insetRatio, z: 1)
    let spacers = [toolBoxSpacer, bedSpacer].union()
        .translate(x: -bedSpacerWidth, y: (TBody.width*(1-insetRatio)).half, z: 0)
    
    
    let bed = [lowerBed, upperBed].union()
        .translate(x: bedSpacerWidth, y: 0, z: toolboxHeight)
    let bedAndBox = [bed, toolBox, spacers].union()
    
    
    let axelInset = 2.0
    let trapDepth = TBody.width - tireWidth*2.0
    let trapCircleDiameter = axelDiameter+axelInset*2.0
    let trapLift = 11.0
    let trapHeight = TBody.smallBlockHeight.half+trapLift
    let axelHeight = trapHeight*0.9
    let trapBaseWidth = TBody.smallBlockWidth+10.0
    
    let trap = trapezoid(topWidth: trapCircleDiameter, bottomWidth: trapBaseWidth, height: trapHeight, thickness: trapDepth)
    let trapTopper = cylinder(diameter: trapCircleDiameter, height: trapDepth)
        .rotate(x: 90, y: 0, z: 0)
        .translate(x: 0, y: 0, z: axelHeight)
    let roundedTrap = [trap, trapTopper].hull()
    let rodBlank = cylinder(diameter: axelDiameter, height: TBody.width)
        .rotate(x: 90, y: 0, z: 0)
        .translate(x: 0, y: 0, z: axelHeight)
    let axelTriangle = [roundedTrap, rodBlank].difference()
        .rotate(x: 180, y: 0, z: 0)
        .translate(x: -((trapBaseWidth.half+wellStart)-(wellCurveStartHeight*0.2))+7.0,
                   y: trapDepth.half+tireWidth,
                   z: wellCurveStartHeight+5.0)
    
    let backAxel = axelTriangle.translate(x: fullTruckLength*0.6, y: 0, z: 0)
    let axels = [axelTriangle, backAxel].union()
    
    
    
    // ================================================================================================
    // Assembly
    // ================================================================================================
    
    let truckBody = [bigBlock, littleBlock, windshieldCurve, hoodCurve, bumper].union()
    let bodyWithWell = [truckBody, well].difference()
    let cutouts = [frontWindowBlank, backWindowBlank, sunroofBlank, windshieldBlank, peopleBlanks].union()
    let bodyWithWindows = [bodyWithWell, cutouts].difference()
    let bodyAndTires = [bodyWithWindows, tires].and()
    let bodyAndBed = [bodyWithWindows, bedAndBox].union()
    let bodyWithAxels = [bodyAndBed, axels].union()
    


    return bodyWithAxels
}