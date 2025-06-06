//
//  GPXDocument.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 04/06/2025.
//

/// GPX is the root element in the XML file.
struct GPXDocument: XMLTagElement {
    // MARK: - Attributes

    // <xsd:attribute name="creator" type="xsd:string" use="required"/>
    var creator: String
    // <xsd:attribute name="version" type="xsd:string" use="required" fixed="1.1"/>
    var version: GpxVersion = .v1_1

    var allAdditionnalAttributes: [String: String] = [:]

    // MARK: - Elements

    // <xsd:element name="metadata" type="metadataType" minOccurs="0"/>
    var metadata: Metadata?

    // <xsd:element name="trk" type="trkType" minOccurs="0" maxOccurs="unbounded"/>
    var tracks: [Track] = []

    // <xsd:element name="wpt" type="wptType" minOccurs="0" maxOccurs="unbounded"/>
    // <xsd:element name="rte" type="rteType" minOccurs="0" maxOccurs="unbounded"/>

    // <xsd:element name="extensions" type="extensionsType" minOccurs="0"/>
    var extensions: Extensions?

    // MARK: - XMLTagElement

    var attributes: [String: String] {
        [
            "creator": creator,
            "version": version.rawValue,
        ].merging(allAdditionnalAttributes) { _, new in new }
    }

    var elementName: String = "gpx"

    var namespacePrefix: String?

    var content: String?

    var children: [any XMLTagElement] {
        ([metadata, extensions] as [(any XMLTagElement)?])
            .compactMap { $0 } + tracks
    }
}
