//
//  XMLElement.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

import Foundation

class XMLNode: CustomStringConvertible {
    var namespacePrefix: String?
    var tag: String
    var attributes = [String: String]()
    var content = ""
    var children = [XMLNode]()
    
    init(namespacePrefix: String? = nil,
         tag: String,
         attributes: [String: String] = [:],
         content: String = "",
         children: [XMLNode] = []) {
        self.namespacePrefix = namespacePrefix
        self.tag = tag
        self.attributes = attributes
        self.content = content
        self.children = children
    }
    
    private var attString: String {
        attributes.map { key, value in
            " \(key)=\"\(value)\""
        }
        .joined()
    }
    
    private var completeElementName: String {
        if let namespacePrefix {
            return "\(namespacePrefix):\(tag)"
        }
        return tag
    }
    
    private var openTag: String {
        return "<\(completeElementName)\(attString)>"
    }
    
    private var closeTag: String {
        "</\(completeElementName)>"
    }
    
    var description: String {
        if !content.isEmpty {
            return "\(openTag)\(content)\(closeTag)\n"
        }
        
        if !children.isEmpty {
            return "\(openTag)\n" +
                children.map { $0.description }.joined(separator: "") +
                "\(closeTag)\n"
        }
        
        return "<\(completeElementName)\(attString) />\n"
    }
}
