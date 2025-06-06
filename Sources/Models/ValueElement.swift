//
//  ValueElement.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 05/06/2025.
//

struct ValueElement: XMLTagElement {
    var attributes: [String: String] = [:]

    var elementName: String

    var namespacePrefix: String?

    var content: String?

    var children: [any XMLTagElement] = []
}
