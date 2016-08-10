



import Foundation

extension String {
    func repeatBy(numRepeats: Int) -> String {
        var output = ""
        for _ in 0..<numRepeats {
            output += self
        }
        
        return output
    }
    
    func numberOf(string: String) -> Int {
        let components = self.componentsSeparatedByString(string)
        return components.count - 1
    }
}

