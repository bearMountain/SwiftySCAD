



import Foundation

//
// circle(r = 1, $fn =30);
//
func circle(diameter: Double, resolution: Int = 30) -> String {
    return "circle(r = \(diameter/2.0), $fn = \(resolution));"
}

//
// polygon(points=[[0,0],[100,0],[130,50],[30,50]]);
//
func polygon(points: [Point]) -> String {
    let pointsList = points.map{$0.scadOutput()}.joinWithSeparator(", ")
    return "polygon(points=[\(pointsList)]);"
}