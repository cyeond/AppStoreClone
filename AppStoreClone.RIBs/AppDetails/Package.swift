// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppDetails",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "AppDetails",
            targets: ["AppDetails"]),
        .library(
            name: "AppDetailsImp",
            targets: ["AppDetailsImp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/uber/RIBs", .upToNextMajor(from: Version(stringLiteral: "0.9.2"))),
        .package(path: "../Platform")
    ],
    targets: [
        .target(
            name: "AppDetails",
            dependencies: [
                "RIBs",
                .product(name: "Entities", package: "Platform")
            ]
        ),
        .target(
            name: "AppDetailsImp",
            dependencies: [
                "RIBs",
                "AppDetails",
                .product(name: "Entities", package: "Platform"),
                .product(name: "Network", package: "Platform"),
                .product(name: "ReuseableViews", package: "Platform"),
                .product(name: "ResourcesLibrary", package: "Platform"),
            ]
        ),
        .testTarget(
            name: "AppDetailsImpTests",
            dependencies: [
                "AppDetailsImp",
                .product(name: "RIBsTestSupport", package: "Platform"),
            ]
        )
    ]
)
