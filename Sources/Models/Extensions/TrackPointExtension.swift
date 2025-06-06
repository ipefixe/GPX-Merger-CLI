//
//  TrackPointExtension.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 04/06/2025.
//

/// The root element is intended to be used as a child element of the "extensions" elements in the trkpt element in the GPX 1.1 schema.
/// https://www8.garmin.com/xmlschemas/TrackPointExtensionv1.xsd
struct TrackPointExtension: XMLTagElement {
    // MARK: - Elements

    // <xsd:element name="hr" type="BeatsPerMinute_t" minOccurs="0"/>
    var heartRate: ValueElement?

    // <xsd:element name="atemp" type="DegreesCelsius_t" minOccurs="0"/>
    // <xsd:element name="wtemp" type="DegreesCelsius_t" minOccurs="0"/>
    // <xsd:element name="depth" type="Meters_t" minOccurs="0"/>
    // <xsd:element name="cad" type="RevolutionsPerMinute_t" minOccurs="0"/>
    // <xsd:element name="Extensions" type="Extensions_t" minOccurs="0"/>

    // MARK: - XMLTagElement

    var attributes: [String: String] = [:]

    var elementName: String = "TrackPointExtension"

    var namespacePrefix: String?

    var content: String?

    var children: [any XMLTagElement] {
        [
            heartRate
        ]
        .compactMap { $0 }
    }
}
