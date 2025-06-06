//
//  Extensions.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 04/06/2025.
//

/// You can add extend GPX by adding your own elements from another schema here.
struct Extensions: XMLTagElement {
    // MARK: - Elements

    // <xsd:element name="TrackPointExtension" type="TrackPointExtension_t"/>
    var trackPointExtension: TrackPointExtension?

    // MARK: - XMLTagElement

    var attributes: [String: String] = [:]

    var elementName: String = "extensions"

    var namespacePrefix: String?

    var content: String?

    var children: [any XMLTagElement] {
        [
            trackPointExtension
        ]
        .compactMap { $0 }
    }
}
