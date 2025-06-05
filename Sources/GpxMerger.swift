//
//  GpxMerger.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 04/06/2025.
//

import ArgumentParser
import Figlet

@main
struct GpxMerger: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Will merge two GPX files into a new one")

    @Argument(help: "Path to the first GPX file")
    var firstGPXPath: String

    @Argument(help: "Path to the second GPX file")
    var secondGPXPath: String

    @Option(name: [.short, .customLong("output")], help: "Path to output GPX file")
    var outputGPXPath: String? = nil

    mutating func run() throws {
        Figlet.say("GPX Merger")

        outputGPXPath = outputGPXPath ?? firstGPXPath
            .replacingOccurrences(
                of: ".gpx",
                with: ".merged.gpx",
                options: [.caseInsensitive, .anchored, .backwards]
            )

        print("First GPX path = \(firstGPXPath)")
        print("Second GPX path = \(secondGPXPath)")
        print("Output path = \(outputGPXPath ?? "---")")

        // TODO: ERROR case if outputGPXPath == firstGPXPath
    }
}
