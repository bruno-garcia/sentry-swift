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
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Sentry",
            targets: ["Sentry"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Sentry",
            dependencies: [],
            exclude: [ "Example" ]),
        .target(
            name: "Example",
            dependencies: [ "Sentry" ],
            path: "Example"),
        .testTarget(
            name: "SentryTests",
            dependencies: ["Sentry"]),
    ]
)
