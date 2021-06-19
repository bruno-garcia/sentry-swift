// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sentry",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9), .watchOS(.v3) // .windows, .linux - swift 5.3 won't compile it even though it's on the docs
        // https://developer.apple.com/documentation/swift_packages/platform/3112702-linux
    ],
    products: [
        .library(
            name: "Sentry",
            targets: ["Sentry"]),
    ],
    dependencies: [
        .package(name: "PLCrashReporter", url: "https://github.com/microsoft/plcrashreporter.git", .upToNextMajor(from: "1.7.2")),
        .package(name: "Breakpad", url: "../swift-breakpad/", .branch("main"))
    ],
    targets: [
        .target(
            name: "Sentry",
            dependencies: [
                .product(
                    name: "CrashReporter",
                    package: "PLCrashReporter",
                    condition: .when(platforms: [.macOS, .iOS, .watchOS, .tvOS])),
                .product(
                    name: "Breakpad",
                    package: "Breakpad",
                    condition: .when(platforms: [.linux, .macOS])), // macOS for testing
            ],
            exclude: ["Example"]),
        .target(
            name: "Example",
            dependencies: ["Sentry"],
            path: "Example"),
        .testTarget(
            name: "SentryTests",
            dependencies: [
                "Sentry",
            ]),
    ]
)


// https://github.com/stephencelis/SQLite.swift/blob/master/Package.swift
// #if os(Linux)
//     package.dependencies = [.package(url: "https://github.com/stephencelis/CSQLite.git", from: "0.0.3")]
//     package.targets = [
//         .target(name: "SQLite", exclude: ["Extensions/FTS4.swift", "Extensions/FTS5.swift"]),
//         .testTarget(name: "SQLiteTests", dependencies: ["SQLite"], path: "Tests/SQLiteTests", exclude: [
//             "FTS4Tests.swift",
//             "FTS5Tests.swift"
//         ])
//     ]
// #endif