



import Foundation

// String Counting and Repetition
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

// Export Extensions
extension String {
    func createDirectory() {
        do {
            try NSFileManager.defaultManager().createDirectoryAtPath(self, withIntermediateDirectories: false, attributes: nil)
        } catch {}
    }
    
    func createFile() {
        NSFileManager.defaultManager().createFileAtPath(self, contents: nil, attributes: nil)
    }
    
    func writeContent(content: String) {
        do {
            try content.writeToFile(self, atomically: true, encoding: NSUTF8StringEncoding)
        } catch {}
    }
    
    func copyFile(toPath path: String) {
        do {
            try NSFileManager.defaultManager().copyItemAtPath(self, toPath: path)
        } catch {}
    }
}

