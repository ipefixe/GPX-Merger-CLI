//
//  XMLNode+TrackSegment.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

extension XMLNode {
    func mapTrackSegment() throws -> TrackSegment {
        try requireTag("trkseg")

        let trackPoints = try children(tag: "trkpt").compactMap { try $0.mapTrackPoint() }
        let extensions = try firstChild(tag: "extensions")?.mapExtensions()

        return TrackSegment(
            trackPoints: trackPoints,
            extensions: extensions,
            namespacePrefix: namespacePrefix)
    }
}
