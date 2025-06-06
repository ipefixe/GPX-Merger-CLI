//
//  XMLNode+GPXDocument.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

extension XMLNode {
    func mapGPXDocument() throws -> GPXDocument {
        try requireTag("gpx")

        guard let creator = attributes["creator"] else {
            throw GPXMappingError.missingAttribute("creator")
        }
        guard let version = attributes["version"] else {
            throw GPXMappingError.missingAttribute("version")
        }
        guard let gpxVersion = GpxVersion(rawValue: version) else {
            throw GPXMappingError.invalidVersion(version)
        }

        let additionalAttributes = attributes.filter { $0.key != "creator" && $0.key != "version" }

        let metadata = try firstChild(tag: "metadata")?.mapMetadata()
        let tracks = try children(tag: "trk").compactMap { try $0.mapTrack() }
        let extensions = try firstChild(tag: "extensions")?.mapExtensions()

        return GPXDocument(
            creator: creator,
            version: gpxVersion,
            allAdditionnalAttributes: additionalAttributes,
            metadata: metadata,
            tracks: tracks,
            extensions: extensions
        )
    }
}
