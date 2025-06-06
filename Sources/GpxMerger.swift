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

        // Sample from my Strava account
        let gpxString = """
        <?xml version="1.0" encoding="UTF-8"?>
        <gpx xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd http://www.garmin.com/xmlschemas/GpxExtensions/v3 http://www.garmin.com/xmlschemas/GpxExtensionsv3.xsd http://www.garmin.com/xmlschemas/TrackPointExtension/v1 http://www.garmin.com/xmlschemas/TrackPointExtensionv1.xsd" creator="StravaGPX" version="1.1" xmlns="http://www.topografix.com/GPX/1/1" xmlns:gpxtpx="http://www.garmin.com/xmlschemas/TrackPointExtension/v1" xmlns:gpxx="http://www.garmin.com/xmlschemas/GpxExtensions/v3">
         <metadata>
          <time>2025-05-27T06:48:01Z</time>
         </metadata>
         <trk>
          <name>Sortie en vélo électrique le matin</name>
          <type>ebikeride</type>
          <trkseg>
           <trkpt lat="43.5881200" lon="1.4481640">
            <ele>145.2</ele>
            <time>2025-05-27T06:48:01Z</time>
            <extensions>
             <gpxtpx:TrackPointExtension>
              <gpxtpx:hr>118</gpxtpx:hr>
             </gpxtpx:TrackPointExtension>
            </extensions>
           </trkpt>
           <trkpt lat="43.5881190" lon="1.4481600">
            <ele>145.2</ele>
            <time>2025-05-27T06:48:02Z</time>
            <extensions>
             <gpxtpx:TrackPointExtension>
              <gpxtpx:hr>118</gpxtpx:hr>
             </gpxtpx:TrackPointExtension>
            </extensions>
           </trkpt>
           <trkpt lat="43.5881320" lon="1.4481810">
            <ele>145.2</ele>
            <time>2025-05-27T06:48:03Z</time>
            <extensions>
             <gpxtpx:TrackPointExtension>
              <gpxtpx:hr>117</gpxtpx:hr>
             </gpxtpx:TrackPointExtension>
            </extensions>
           </trkpt>
          </trkseg>
         </trk>
        </gpx>
        """

        let xmlBuilder = XMLBuilder()

        // Get a Data from GPX
        let gpxData = Data(gpxString.utf8)

        // Get a parser from these Data
        let xmlParser = XMLParser(data: gpxData)

        // Set the delegate
        xmlParser.delegate = xmlBuilder

        // Parse
        print("=== \(xmlParser.hash)")
        xmlParser.parse()
        print("🏁\n\(xmlBuilder.root?.description ?? "⚠️ FAILED")")

    }
}
