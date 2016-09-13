



import Foundation


func eleven() -> String {
    let space = -2.0
    let leftOne = NumberLibrary.one(centered: true)
        .translate(x: -NumberLibrary.oneWidth.half - space.half)
    let rightOne = NumberLibrary.one(centered: true)
        .translate(x: NumberLibrary.oneWidth.half + space.half)
    
    let eleven = [leftOne, rightOne].and()
        .translate(x: NumberLibrary.elevenWidth.half, y: NumberLibrary.numberHeight.half)
    
    return eleven
}