



import Foundation

private let constrainHeight = 10.0

struct NumberLibrary {
    //MARK: - Numbers
    static func zero(centered centered: Bool = false) -> String {
        return loadNumber("one", convexity: 4, width: 8.9, centered: centered)
    }
    
    static func one(centered centered: Bool = false) -> String {
        return loadNumber("one", convexity: 6, width: 8.2, centered: centered)
    }
    
    static func two(centered centered: Bool = false) -> String {
        return loadNumber("two", convexity: 6, width: 6.3, centered: centered)
    }
    
    static func three(centered centered: Bool = false) -> String {
        return loadNumber("three", convexity: 6, width: 9.9, centered: centered)
    }
    
    static func four(centered centered: Bool = false) -> String {
        return loadNumber("four", convexity: 6, width: 6.2, centered: centered)
    }
    
    static func five(centered centered: Bool = false) -> String {
        return loadNumber("five", convexity: 6, width: 8.5, centered: centered)
    }
    
    static func nine(centered centered: Bool = false) -> String {
        return loadNumber("nine", convexity: 6, width: 6.5, centered: centered)
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
