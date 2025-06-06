//
//  XMLNode+TrackPoint.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

extension XMLNode {
    func mapTrackPoint() throws -> Waypoint {
        try requireTag("trkpt")
        
        guard let latitude = attributes["lat"],
              let longitude = attributes["lon"] else {
            throw GPXMappingError.missingAttribute("lat/lon")
        }
        
        let elevation = try firstChild(tag: "ele")?.mapValueElement(tag: "ele")
        let time = try firstChild(tag: "time")?.mapValueElement(tag: "time")
        let extensions = try firstChild(tag: "extensions")?.mapExtensions()
        
        return Waypoint(
            latitude: latitude,
            longitude: longitude,
            elevation: elevation,
            time: time,
            extensions: extensions,
            namespacePrefix: namespacePrefix
        )
    }
}
