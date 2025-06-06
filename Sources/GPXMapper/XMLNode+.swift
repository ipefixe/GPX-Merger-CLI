//
//  XMLNode+.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

extension XMLNode {
    func firstChild(tag: String) -> XMLNode? {
        children.first { $0.tag == tag }
    }

    func children(tag: String) -> [XMLNode] {
        children.filter { $0.tag == tag }
    }

    func requireTag(_ tag: String) throws {
        guard self.tag == tag else {
            throw GPXMappingError.invalidElement(tag)
        }
    }
}
