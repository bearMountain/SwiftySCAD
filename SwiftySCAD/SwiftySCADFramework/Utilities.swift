




import Foundation

let ProjectPath = "/Users/jeff/Documents/Branch Computing/SwiftySCAD/SwiftySCAD"


func openSCADExport(shape: String, directoryPath: String, fileName: String) {
    let formattedShape = formatOutput(shape)
    let projectFolderPath = directoryPath + "/" + fileName
    let filePath = projectFolderPath + "/" + fileName + ".scad"
    
    do {
        try NSFileManager.defaultManager().createDirectoryAtPath(projectFolderPath, withIntermediateDirectories: false, attributes: nil)
    } catch {}
    
    NSFileManager.defaultManager().createFileAtPath(filePath, contents: nil, attributes: nil)
    do {
        try formattedShape.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
    } catch {}
    
    
    do {
        let j = NSBundle.mainBundle().resourcePath
        let p = NSFileManager.defaultManager().currentDirectoryPath
        try NSFileManager.defaultManager().copyItemAtPath("", toPath: "")
    } catch {}

}

//private func write(content content: String, toPath path: String) {
//    NSFileManager.defaultManager().createDirectoryAtPath("", withIntermediateDirectories: false, attributes: nil)
//    
//    NSFileManager.defaultManager().createFileAtPath(path, contents: nil, attributes: nil)
//    do {
//        try content.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
//    } catch {}
//}



func formatOutput(unformattedOutput: String) -> String {
    var formattedOutput = ""
    var indentationLevel: Int = 0
    
    for line in unformattedOutput.componentsSeparatedByString("\n") {
//        let top = line.numberOf("{")
        let bottom = line.numberOf("}")
        if (bottom > 1) {
            print("j")
        }
        
//        print("number of '{': \()")
//        print("number of '}': \(line.numberOf("}"))")
        
        if line.containsString("}") {
            indentationLevel -= 1
        }
        
        let tabs = "\t".repeatBy(indentationLevel)
        formattedOutput += tabs + line + "\n"
        
        if line.containsString("{") {
            indentationLevel += 1
        }
    }
    
    return formattedOutput
}










