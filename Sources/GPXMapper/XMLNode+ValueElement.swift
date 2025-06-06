//
//  XMLNode+ValueElement.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

extension XMLNode {
    func mapValueElement(tag: String) throws -> ValueElement {
        try requireTag(tag)

        return ValueElement(
            elementName: tag,
            namespacePrefix: namespacePrefix,
            content: content
        )
    }
}
