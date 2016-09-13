

import Foundation


func ten() -> String {
    let space = -1.4
    let leftOne = NumberLibrary.one(centered: true)
        .translate(x: -NumberLibrary.oneWidth.half - space.half)
    let rightZero = NumberLibrary.zero(centered: true)
        .translate(x: NumberLibrary.zeroWidth.half + space.half, y: 0.3)
        .scale(x: 1.0, y: 1.0, z: 11.5)
    
    let ten = [leftOne, rightZero].and()
        .translate(x: NumberLibrary.tenWidth.half, y: NumberLibrary.numberHeight.half)
    
    return ten
}