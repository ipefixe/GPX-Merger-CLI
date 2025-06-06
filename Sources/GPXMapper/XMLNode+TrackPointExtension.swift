//
//  XMLNode+TrackPointExtension.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

extension XMLNode {
    func mapTrackPointExtension() throws -> TrackPointExtension {
        try requireTag("TrackPointExtension")
        
        let heartRate = try firstChild(tag: "hr")?.mapValueElement(tag: "hr")
        
        return TrackPointExtension(heartRate: heartRate, namespacePrefix: namespacePrefix)
    }
}
