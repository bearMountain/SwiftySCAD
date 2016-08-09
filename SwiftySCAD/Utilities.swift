




import Foundation

func write(string: String) {
    NSFileManager.defaultManager().createFileAtPath("/Users/jeff/Test.scad", contents: nil, attributes: nil)
    do {
        try string.writeToFile("/Users/jeff/Test.scad", atomically: true, encoding: NSUTF8StringEncoding)
    } catch {}
}

func openSCADExport(shape: String, directoryPath: String, fileName: String) {
    let filePath = directoryPath + "/" + fileName + ".scad"
    NSFileManager.defaultManager().createFileAtPath(filePath, contents: nil, attributes: nil)
    do {
        try shape.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
    } catch {}
}

func write(shapes: [String]) {
    write(shapes.joinWithSeparator("\n"))
}
