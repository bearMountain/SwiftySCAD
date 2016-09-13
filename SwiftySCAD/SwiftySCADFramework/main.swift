



import Foundation

let ProjectPath = "/Users/jeff/Documents/Branch Computing/SwiftySCAD/SwiftySCAD"
let DestinationDirectoryPath = "/Users/jeff/Documents/OpenSCAD"



let numbers = [
    NumberLibrary.three(centered: true).scale(1.1),
    NumberLibrary.two(centered: true).scale(1.1),
    NumberLibrary.one(centered: true).scale(1.1),
    NumberLibrary.twelve(centered: true),
    NumberLibrary.eleven(centered: true),
    NumberLibrary.ten(centered: true),
    NumberLibrary.nine(centered: true).scale(1.2).translate(x: -1.0),
    NumberLibrary.eight(centered: true),
    NumberLibrary.seven(centered: true).scale(1.15),
    NumberLibrary.six(centered: true),
    NumberLibrary.five(centered: true),
    NumberLibrary.four(centered: true).scale(1.2),
]

let clock = numbers.distributeOnCircle(radius: 40)

//







clock.exportAsOpenSCAD(destinationDirectoryPath: DestinationDirectoryPath, fileName: "fin", swiftySCADProjectPath: ProjectPath)





