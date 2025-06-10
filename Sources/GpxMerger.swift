//
//  GpxMerger.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 04/06/2025.
//

import ArgumentParser
import Figlet
import Foundation

@main
struct GpxMerger: ParsableCommand {
    // MARK: Error

    private enum MergerError: LocalizedError {
        case invalidURLs([String])
        case readingGPX(Error)
        case nothingToMerger
        case oneFileToMerge

        var errorDescription: String? {
            return switch self {
            case .invalidURLs(let paths):
                "Some paths could not be resolved to URLs: \(paths.joined(separator: ", "))"
            case .readingGPX(let error):
                "Error reading GPX files: \(error.localizedDescription)"
            case .nothingToMerger:
                "Nothing to merge"
            case .oneFileToMerge:
                "Only one file to merge, nothing to merge"
            }
        }
    }

    // MARK: Command

    static let configuration = CommandConfiguration(abstract: "Will merge two GPX files into a new one")

    @Argument(help: "Paths to GPX files to merge")
    var paths: [String]

    @Option(name: [.short, .customLong("output")], help: "Path to output GPX file")
    var outputGPXPath: String? = nil

    // MARK: Private properties

    private var timestamp: String {
        return "\(Int(Date.timeIntervalBetween1970AndReferenceDate))"
    }

    private var outputPath: String {
        outputGPXPath ?? "~/Desktop/\(timestamp).gpx"
            .replacingOccurrences(
                of: ".gpx",
                with: ".merged.gpx",
                options: [.caseInsensitive, .anchored, .backwards]
            )
    }

    // MARK: RUN

    mutating func run() throws {
        Figlet.say("GPX Merger")

        var data: [Data] = []
        do {
            data = try readData(from: paths)
        } catch {
            print("❌ \(error.localizedDescription). Exiting...")
            return
        }

        var gpxDocuments: [GPXDocument] = []
        do {
            gpxDocuments = try data.compactMap { try parse(gpxData: $0) }
        } catch {
            print("❌ Error while parsing GPX. \(error.localizedDescription). Exiting...")
            return
        }

        let gpxDocumentsOrdered = sortedGPX(gpxDocuments: gpxDocuments)

        var gpxMerged: GPXDocument?
        do {
            gpxMerged = try merged(gpxDocuments: gpxDocumentsOrdered)
        } catch {
            print("❌ \(error.localizedDescription). Exiting...")
            return
        }

        guard let gpxMerged else {
            print("")
            return
        }

        try write(gpxDocument: gpxMerged, to: outputPath)

        print("✅ FINISHED")
    }

    // MARK: Private methods

    private func readData(from paths: [String]) throws -> [Data] {
        print("Read data from GPX files...")

        let urls = paths.compactMap { URL(string: "file://\($0)") }
        if urls.count != paths.count {
            throw MergerError.invalidURLs(paths)
        }

        do {
            return try urls.compactMap { try Data(contentsOf: $0) }
        } catch {
            throw MergerError.readingGPX(error)
        }
    }

    private func parse(gpxData: Data) throws -> GPXDocument? {
        print("Parse GPX data...")

        let xmlBuilder = XMLBuilder()

        let xmlParser = XMLParser(data: gpxData)

        xmlParser.delegate = xmlBuilder

        xmlParser.parse()

        return try xmlBuilder.root?.mapGPXDocument()
    }

    private func sortedGPX(gpxDocuments: [GPXDocument]) -> [GPXDocument] {
        gpxDocuments.sorted {
            guard let date0 = $0.metadata?.time?.content?.date,
                  let date1 = $1.metadata?.time?.content?.date else {
                return true
            }
            return date0 < date1
        }
    }

    private func merged(gpxDocuments: [GPXDocument]) throws -> GPXDocument {
        print("Merge GPX documents...")

        guard var gpxMerged = gpxDocuments.first else {
            throw MergerError.nothingToMerger
        }

        let gpxToMerge = gpxDocuments.dropFirst()
        if gpxToMerge.count <= 1 {
            throw MergerError.oneFileToMerge
        }

        let tracks = gpxToMerge.compactMap { $0.tracks }

        gpxMerged.tracks.append(contentsOf: tracks.flatMap { $0 })

        return gpxMerged
    }

    private func write(gpxDocument: GPXDocument, to outputPath: String) throws {
        print("Write merged GPX to file \(outputPath)...")

        guard let url = URL(string: "file://\(outputPath)") else {
            return
        }

        try gpxDocument.description.write(to: url, atomically: true, encoding: .utf8)
    }
}
