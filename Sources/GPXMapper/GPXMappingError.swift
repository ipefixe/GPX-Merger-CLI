//
//  GPXMappingError.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 06/06/2025.
//

enum GPXMappingError: Error {
    case invalidElement(String)
    case missingAttribute(String)
    case invalidVersion(String)
}
