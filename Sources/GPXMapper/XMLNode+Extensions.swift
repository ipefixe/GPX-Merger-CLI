//
//  XMLNode+Extensions.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

extension XMLNode {
    func mapExtensions() throws -> Extensions {
        try requireTag("extensions")

        let trackPointExtension = try firstChild(tag: "TrackPointExtension")?.mapTrackPointExtension()

        return Extensions(trackPointExtension: trackPointExtension, namespacePrefix: namespacePrefix)
    }
}
