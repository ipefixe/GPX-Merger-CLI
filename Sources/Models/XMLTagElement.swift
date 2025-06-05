//
//  XMLTagElement.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 05/06/2025.
//

protocol XMLTagElement: CustomStringConvertible {
    // MARK: Properties

    /// All attributes present in this element
    var attributes: [String: String] { get }
    /// The local name of the XML element
    var elementName: String { get }
    /// Namespace prefix, if any
    var namespacePrefix: String? { get }
    /// Namespace URI, if any
    var namespaceURI: String? { get }

    /// Text content if the element contains only a simple value
    var content: String? { get }
    /// All child XML elements contained within this element
    var children: [XMLTagElement] { get }

    // MARK: Helper

    /// Full name, including namespace prefix if present
    var completeElementName: String { get }
    /// The opening XML tag, including attributes
    var openTag: String { get }
    /// The closing tag
    var closeTag: String { get }
}

extension XMLTagElement {
    var completeElementName: String {
        if let namespacePrefix {
            return "\(namespacePrefix):\(elementName)"
        }
        return elementName
    }

    var openTag: String {
        let attributesString = attributes.map { key, value in
            " \(key)=\"\(value)\""
        }.joined()
        return "<\(completeElementName)\(attributesString)>"
    }

    var closeTag: String {
        "</\(completeElementName)>"
    }
}

extension XMLTagElement {
    var description: String {
        if let content {
            return "\(openTag)\(content)\(closeTag)"
        }

        if !children.isEmpty {
            return openTag +
                children.map { $0.description }.joined() +
                closeTag
        }

        return "\(openTag)\(closeTag)"
    }
}
