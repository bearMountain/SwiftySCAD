




import Foundation

let ProjectPath = "/Users/jeff/Documents/Branch Computing/SwiftySCAD/SwiftySCAD"

// Export
func openSCADExport(shape: String, directoryPath: String, fileName: String) {
    // Project Paths
    let projectFolderPath = directoryPath + "/" + fileName
    let shapePath = projectFolderPath + "/" + fileName + ".scad"
    
    // Lib Paths
    let libPath = ProjectPath + "/" + "SwiftySCAD/OpenSCADLibraries/LibBezier.scad"
    let libDestinationFolder = projectFolderPath + "/OpenSCADLibraries"
    let libDestinationPath = libDestinationFolder + "/LibBezier.scad"
    
    // Formatted Shape
    let formattedShape = postProcess(shape: shape, openSCADLibraryFolderPath: libDestinationFolder)
    
    
    // Write Project and Shape
    projectFolderPath.createDirectory()
    shapePath.createFile()
    shapePath.writeContent(formattedShape)
    
    // Add Libs
    libDestinationFolder.createDirectory()
    libPath.copyFile(toPath: libDestinationPath)
}

// Post Processing
func postProcess(shape shape: String, openSCADLibraryFolderPath libraryPath: String) -> String {
    let formattedShape = formatOutput(shape)
    let shapeWithLibs = addOpenSCADLibraries(toShape: formattedShape, libraryPath: libraryPath)
    
    return shapeWithLibs
}

//
// use </Users/jeff/Documents/OpenSCAD/OpenSCADLibraries/LibBezier.scad>;
//
private func addOpenSCADLibraries(toShape shape: String, libraryPath: String) -> String {
    let lib1 = "use <\(libraryPath)/LibBezier.scad>\n\n"
    let libsAdded = lib1 + shape
    
    return libsAdded
}

private func formatOutput(unformattedOutput: String) -> String {
    var formattedOutput = ""
    var indentationLevel: Int = 0
    
    for line in unformattedOutput.componentsSeparatedByString("\n") {
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










