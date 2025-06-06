//
//  XMLElement.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

import Foundation

class XMLNode: CustomStringConvertible {
    var tag = ""
    var attributes = [String: String]()
    var content = ""
    var children = [XMLNode]()
    
    init(tag: String = "", attributes: [String: String] = [:], content: String = "", children: [XMLNode] = []) {
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
    
    var description: String {
        if !content.isEmpty {
            return "<\(tag)\(attString)>\(content)</\(tag)>\n"
        }
        
        if !children.isEmpty {
            return "<\(tag)\(attString)>\n" +
                children.map { $0.description }.joined(separator: "") +
                "</\(tag)>\n"
        }
        
        return "<\(tag)\(attString) />\n"
    }
}
