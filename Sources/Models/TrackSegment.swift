//
//  TrackSegment.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 04/06/2025.
//

/// A Track Segment holds a list of Track Points which are logically connected in order. To represent a single GPS track where GPS reception was lost, or the GPS receiver was turned off, start a new Track Segment for each continuous span of track data.
struct TrackSegment: XMLTagElement {
    // MARK: - Elements

    // <xsd:element name="trkpt" type="wptType" minOccurs="0" maxOccurs="unbounded"/>
    var trackPoints: [Waypoint] = []

    // <xsd:element name="extensions" type="extensionsType" minOccurs="0"/>
    var extensions: Extensions?

    // MARK: - XMLTagElement

    var attributes: [String: String] = [:]

    var elementName: String = "trkseg"

    var namespacePrefix: String?

    var content: String?

    var children: [any XMLTagElement] {
        [
            extensions
        ]
        .compactMap { $0 } + trackPoints
    }
}
