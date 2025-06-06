//
//  XMLNode+Metadata.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

extension XMLNode {
    func mapMetadata() throws -> Metadata {
        try requireTag("metadata")

        let time = try firstChild(tag: "time")?.mapValueElement(tag: "time")

        return Metadata(time: time, namespacePrefix: namespacePrefix)
    }
}
