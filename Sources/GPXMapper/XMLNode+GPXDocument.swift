//
//  XMLNode+GPXDocument.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

extension XMLNode {
    func mapGPXDocument() throws -> GPXDocument {
        try requireTag("gpx")

        guard let creator = self.attributes["creator"] else {
            throw GPXMappingError.missingAttribute("creator")
        }
        guard let version = self.attributes["version"] else {
            throw GPXMappingError.missingAttribute("version")
        }
        guard let gpxVersion = GpxVersion(rawValue: version) else {
            throw GPXMappingError.invalidVersion(version)
        }

        let metadata = try firstChild(tag: "metadata")?.mapMetadata()
        let tracks = try children(tag: "trk").compactMap { try $0.mapTrack() }
        let extensions = try firstChild(tag: "extensions")?.mapExtensions()

        return GPXDocument(
            creator: creator,
            version: gpxVersion,
            metadata: metadata,
            tracks: tracks,
            extensions: extensions
        )
    }
}

extension XMLNode {
    func mapValueElement(tag: String) throws -> ValueElement {
        try requireTag(tag)

        return ValueElement(elementName: tag, content: content)
    }
}

extension XMLNode {
    func mapMetadata() throws -> Metadata {
        try requireTag("metadata")

        let time = try self.firstChild(tag: "time")?.mapValueElement(tag: "time")

        return Metadata(time: time)
    }
}

extension XMLNode {
    func mapTrack() throws -> Track {
        try requireTag("trk")

        let name = try firstChild(tag: "name")?.mapValueElement(tag: "name")
        let type = try firstChild(tag: "type")?.mapValueElement(tag: "type")
        let trackSegments = try children(tag: "trkseg").compactMap { try $0.mapTrackSegment() }
        let extensions = try firstChild(tag: "extensions")?.mapExtensions()

        return Track(name: name, type: type, trackSegments: trackSegments, extensions: extensions)
    }
}

extension XMLNode {
    func mapTrackSegment() throws -> TrackSegment {
        try requireTag("trkseg")

        let trackPoints = try children(tag: "trkpt").compactMap { try $0.mapTrackPoint() }
        let extensions = try firstChild(tag: "extensions")?.mapExtensions()

        return TrackSegment(trackPoints: trackPoints, extensions: extensions)
    }
}

extension XMLNode {
    func mapTrackPoint() throws -> Waypoint {
        try requireTag("trkpt")

        guard let latitude = self.attributes["lat"],
              let longitude = self.attributes["lon"] else {
            throw GPXMappingError.missingAttribute("lat or lon")
        }

        let elevation = try firstChild(tag: "ele")?.mapValueElement(tag: "ele")
        let time = try firstChild(tag: "time")?.mapValueElement(tag: "time")
        let extensions = try firstChild(tag: "extensions")?.mapExtensions()

        return Waypoint(
            latitude: latitude,
            longitude: longitude,
            elevation: elevation,
            time: time,
            extensions: extensions
        )
    }
}

extension XMLNode {
    func mapExtensions() throws -> Extensions {
        try requireTag("extensions")

        let trackPointExtension = try firstChild(tag: "gpxtpx:TrackPointExtension")?.mapTrackPointExtension()

        return Extensions(trackPointExtension: trackPointExtension)
    }
}

extension XMLNode {
    func mapTrackPointExtension() throws -> TrackPointExtension {
        try requireTag("gpxtpx:TrackPointExtension")

        let heartRate = try firstChild(tag: "gpxtpx:hr")?.mapValueElement(tag: "gpxtpx:hr")

        return TrackPointExtension(heartRate: heartRate)
    }
}
