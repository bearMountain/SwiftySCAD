




import Foundation

func write(string: String) {
    NSFileManager.defaultManager().createFileAtPath("/Users/jeff/Test.scad", contents: nil, attributes: nil)
    do {
        try string.writeToFile("/Users/jeff/Test.scad", atomically: true, encoding: NSUTF8StringEncoding)
    } catch {}
}

func openSCADExport(shape: String, directoryPath: String, fileName: String) {
    let formattedShape = formatOutput(shape)
    
    let filePath = directoryPath + "/" + fileName + ".scad"
    NSFileManager.defaultManager().createFileAtPath(filePath, contents: nil, attributes: nil)
    do {
        try formattedShape.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
    } catch {}
}

func write(shapes: [String]) {
    write(shapes.joinWithSeparator("\n"))
}


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










