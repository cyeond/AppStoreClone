// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Search",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SearchHome",
            targets: ["SearchHome"]),
    ],
    dependencies: [
        .package(url: "https://github.com/uber/RIBs", .upToNextMajor(from: Version(stringLiteral: "0.9.2"))),
        .package(path: "../Platform"),
        .package(path: "../AppDetails")
    ],
    targets: [
        .target(
            name: "SearchHome",
            dependencies: [
                "RIBs",
                .product(name: "AppDetails", package: "AppDetails"),
                .product(name: "Entities", package: "Platform"),
                .product(name: "Network", package: "Platform"),
                .product(name: "ReuseableViews", package: "Platform"),
                .product(name: "ResourcesLibrary", package: "Platform"),
            ]
        ),
        .testTarget(
            name: "SearchHomeTests",
            dependencies: [
                "SearchHome",
                .product(name: "RIBsTestSupport", package: "Platform"),
            ]
        )
    ]
)
