



import Foundation


func twelve() -> String {
    let space = -1.3
    let leftOne = NumberLibrary.one(centered: true)
        .translate(x: -NumberLibrary.oneWidth.half - space.half)
    let rightTwo = NumberLibrary.two(centered: true)
        .translate(x: NumberLibrary.twoWidth.half + space.half, y: 0.2)
    
    let twelve = [leftOne, rightTwo].and()
        .translate(x: (NumberLibrary.oneWidth+space.half), y: NumberLibrary.numberHeight.half)
    
    return twelve
}