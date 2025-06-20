// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreModule",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "CoreModule",
            targets: ["CoreModule"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CoreModule",
            dependencies: [],
            path: "Sources"
        )
    ]
)

