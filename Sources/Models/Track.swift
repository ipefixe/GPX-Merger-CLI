//
//  Track.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 04/06/2025.
//

/// trk represents a track - an ordered list of points describing a path.
struct Track: XMLTagElement {
    // MARK: - Elements
    
    // <xsd:element name="name" type="xsd:string" minOccurs="0"/>
    var name: ValueElement?
    
    // <xsd:element name="type" type="xsd:string" minOccurs="0"/>
    var type: ValueElement?
    
    // <xsd:element name="trkseg" type="trksegType" minOccurs="0" maxOccurs="unbounded"/>
    var trackSegments: [TrackSegment] = []
    
    // <xsd:element name="cmt" type="xsd:string" minOccurs="0"/>
    // <xsd:element name="desc" type="xsd:string" minOccurs="0"/>
    // <xsd:element name="src" type="xsd:string" minOccurs="0"/>
    // <xsd:element name="link" type="linkType" minOccurs="0" maxOccurs="unbounded"/>
    // <xsd:element name="number" type="xsd:nonNegativeInteger" minOccurs="0"/>
    
    // <xsd:element name="extensions" type="extensionsType" minOccurs="0"/>
    var extensions: Extensions?
    
    // MARK: - XMLTagElement
    
    var attributes: [String: String] = [:]
    
    var elementName: String = "trk"
    
    var namespacePrefix: String?
        
    var content: String?
    
    var children: [any XMLTagElement] {
        ([name,
          type,
          extensions] as [(any XMLTagElement)?])
            .compactMap { $0 } + trackSegments
    }
}
