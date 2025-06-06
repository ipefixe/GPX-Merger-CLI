//
//  Metadata.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 04/06/2025.
//

/// Information about the GPX file, author, and copyright restrictions goes in the metadata section. Providing rich, meaningful information about your GPX files allows others to search for and use your GPS data.
struct Metadata: XMLTagElement {
    // MARK: - Elements

    // <xsd:element name="time" type="xsd:dateTime" minOccurs="0"/>
    var time: ValueElement?

    // <xsd:element name="name" type="xsd:string" minOccurs="0"/>
    // <xsd:element name="desc" type="xsd:string" minOccurs="0"/>
    // <xsd:element name="keywords" type="xsd:string" minOccurs="0"/>
    // <xsd:element name="author" type="personType" minOccurs="0"/>
    // <xsd:element name="copyright" type="copyrightType" minOccurs="0"/>
    // <xsd:element name="link" type="linkType" minOccurs="0" maxOccurs="unbounded"/>
    // <xsd:element name="bounds" type="boundsType" minOccurs="0"/>
    // <xsd:element name="extensions" type="extensionsType" minOccurs="0"/>

    // MARK: - XMLTagElement

    var attributes: [String: String] = [:]

    var elementName: String = "metadata"

    var namespacePrefix: String?

    var content: String?

    var children: [any XMLTagElement] {
        [
            time
        ]
        .compactMap { $0 }
    }
}
