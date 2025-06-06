//
//  GpxParser.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

import Foundation

class XMLBuilder: NSObject, XMLParserDelegate {
    private var stack = [XMLNode]()
    var root: XMLNode?
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("[\(parser.hash)] ⚪️ Start of the document")
        print("[\(parser.hash)] Line number: \(parser.lineNumber)")
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("[\(parser.hash)] ⚫️ End of the document")
        print("[\(parser.hash)] Line number: \(parser.lineNumber)")
    }
    
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String] = [:]) {
        let newElement = XMLNode(tag: elementName, attributes: attributeDict)
        if let parent = stack.last {
            parent.children.append(newElement)
        }
        stack.append(newElement)
    }
    
    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?) {
        let last = stack.popLast()
        if stack.isEmpty {
            root = last
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let cleanString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if !cleanString.isEmpty,
           let parent = stack.last {
            parent.content.append(contentsOf: cleanString)
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: any Error) {
        print("❌ \(parseError)")
    }
    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: any Error) {
        print("❌ \(validationError)")
    }
}
