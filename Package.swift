// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GPXMergerCLI",
    dependencies: [
        .package(url: "https://github.com/apple/example-package-figlet", branch: "main"),
        .package(
            url: "https://github.com/apple/swift-argument-parser.git", exact: "1.5.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "GPXMergerCLI",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Figlet", package: "example-package-figlet"),
            ],
            path: "Sources"),
    ]
)
