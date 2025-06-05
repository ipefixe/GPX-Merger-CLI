//
//  Waypoint.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 04/06/2025.
//

/// wpt represents a waypoint, point of interest, or named feature on a map.
struct Waypoint: XMLTagElement {
    // MARK: - Attributes

    // <xsd: attribute name="lat" type="latitudeType" use="required"/>
    var latitude: String

    // <xsd: attribute name="lon" type="longitudeType" use="required"/>
    var longitude: String

    // MARK: - Elements

    // <xsd: element name="ele" type="xsd:decimal" minOccurs="0"/>
    var elevation: ValueElement?

    // <xsd: element name="time" type="xsd:dateTime" minOccurs="0"/>
    var time: ValueElement?

    // <xsd: element name="magvar" type="degreesType" minOccurs="0"/>
    // <xsd: element name="geoidheight" type="xsd:decimal" minOccurs="0"/>
    // <xsd: element name="name" type="xsd:string" minOccurs="0"/>
    // <xsd: element name="cmt" type="xsd:string" minOccurs="0"/>
    // <xsd: element name="desc" type="xsd:string" minOccurs="0"/>
    // <xsd: element name="src" type="xsd:string" minOccurs="0"/>
    // <xsd: element name="link" type="linkType" minOccurs="0" maxOccurs="unbounded"/>
    // <xsd: element name="sym" type="xsd:string" minOccurs="0"/>
    // <xsd: element name="type" type="xsd:string" minOccurs="0"/>
    // <xsd: element name="fix" type="fixType" minOccurs="0"/>
    // <xsd: element name="sat" type="xsd:nonNegativeInteger" minOccurs="0"/>
    // <xsd: element name="hdop" type="xsd:decimal" minOccurs="0"/>
    // <xsd: element name="vdop" type="xsd:decimal" minOccurs="0"/>
    // <xsd: element name="pdop" type="xsd:decimal" minOccurs="0"/>
    // <xsd: element name="ageofdgpsdata" type="xsd:decimal" minOccurs="0"/>
    // <xsd: element name="dgpsid" type="dgpsStationType" minOccurs="0"/>

    // <xsd: element name="extensions" type="extensionsType" minOccurs="0"/>
    var extensions: Extensions?

    // MARK: - XMLTagElement

    var attributes: [String: String] {
        [
            "lat": latitude,
            "lon": longitude,
        ]
    }

    var elementName: String = "trkpt"

    var namespacePrefix: String?

    var namespaceURI: String?

    var content: String?

    var children: [any XMLTagElement] {
        ([elevation,
          time,
          extensions] as [(any XMLTagElement)?])
            .compactMap { $0 }
    }
}
