



import Foundation

private let constrainHeight = 10.0


struct NumberLibrary {
    //MARK: - Dimension Constant Vars
    static var numberHeight: Double {
        return 10.0
    }
    
    static var zeroWidth: Double {
        return 8.9
    }
    
    static var oneWidth: Double {
        return 8.2
    }
    
    static var twoWidth: Double {
        return 6.3
    }
    
    static var threeWidth: Double {
        return 9.9
    }
    
    static var fourWidth: Double {
        return 6.2
    }
    
    static var fiveWidth: Double {
        return 8.5
    }
    
    static var sixWidth: Double {
        return 7.7
    }
    
    static var sevenWidth: Double {
        return 5.2
    }
    
    static var eightWidth: Double {
        return 5.9
    }
    
    static var nineWidth: Double {
        return 6.5
    }
    
    static var tenWidth: Double {
        return 15.7
    }
    
    static var elevenWidth: Double {
        return 14.4
    }
    
    static var twelveWidth: Double {
        return 13.2
    }

    
    //MARK: - Numbers
    static func zero(centered centered: Bool = false) -> String {
        return loadNumber("zero", convexity: 4, width: zeroWidth, centered: centered)
    }
    
    static func one(centered centered: Bool = false) -> String {
        return loadNumber("one", convexity: 6, width: oneWidth, centered: centered)
    }
    
    static func two(centered centered: Bool = false) -> String {
        return loadNumber("two", convexity: 6, width: twoWidth, centered: centered)
    }
    
    static func three(centered centered: Bool = false) -> String {
        return loadNumber("three", convexity: 6, width: threeWidth, centered: centered)
    }
    
    static func four(centered centered: Bool = false) -> String {
        return loadNumber("four", convexity: 6, width: fourWidth, centered: centered)
    }
    
    static func five(centered centered: Bool = false) -> String {
        return loadNumber("five", convexity: 6, width: fiveWidth, centered: centered)
    }
    
    static func six(centered centered: Bool = false) -> String {
        return loadNumber("six", convexity: 6, width: sixWidth, centered: centered)
    }
    
    static func seven(centered centered: Bool = false) -> String {
        return loadNumber("seven", convexity: 4, width: sevenWidth, centered: centered)
    }
    
    static func eight(centered centered: Bool = false) -> String {
        return loadNumber("eight", convexity: 6, width: eightWidth, centered: centered)
    }
    
    static func nine(centered centered: Bool = false) -> String {
        return loadNumber("nine", convexity: 6, width: nineWidth, centered: centered)
    }
    
    static func ten(centered centered: Bool = false) -> String {
        return loadNumber("ten", convexity: 8, width: tenWidth, centered: centered)
    }
    
    static func eleven(centered centered: Bool = false) -> String {
        return loadNumber("eleven", convexity: 7, width: elevenWidth, centered: centered)
    }
    
    static func twelve(centered centered: Bool = false) -> String {
        return loadNumber("twelve", convexity: 8, width: elevenWidth, centered: centered)
    }
    
    //MARK: - Helper
    private static func loadNumber(fileName: String, convexity: Int, width: Double, centered: Bool) -> String {
        if (centered) {
            return bc_import(fileName, convexity: convexity)
                .translate(x: -width.half, y: -constrainHeight.half, z: 0)
        }
        
        return bc_import(fileName, convexity: convexity)
    }
}
