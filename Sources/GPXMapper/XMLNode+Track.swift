//
//  XMLNode+Track.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

extension XMLNode {
    func mapTrack() throws -> Track {
        try requireTag("trk")

        let name = try firstChild(tag: "name")?.mapValueElement(tag: "name")
        let type = try firstChild(tag: "type")?.mapValueElement(tag: "type")
        let trackSegments = try children(tag: "trkseg").compactMap { try $0.mapTrackSegment() }
        let extensions = try firstChild(tag: "extensions")?.mapExtensions()

        return Track(
            name: name,
            type: type,
            trackSegments: trackSegments,
            extensions: extensions,
            namespacePrefix: namespacePrefix)
    }
}
