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
        .library(
            name: "AppDetailsTestSupport",
            targets: ["AppDetailsTestSupport"]),
    ],
    dependencies: [
        .package(url: "https://github.com/uber/RIBs", .upToNextMajor(from: Version(stringLiteral: "0.9.2"))),
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: Version(stringLiteral: "6.7.1"))),
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
                "AppDetails",
                .product(name: "Network", package: "Platform"),
                .product(name: "ReuseableViews", package: "Platform"),
                .product(name: "ResourcesLibrary", package: "Platform"),
            ]
        ),
        .target(
            name: "AppDetailsTestSupport",
            dependencies: [
                "AppDetailsImp",
                .product(name: "RIBsTestSupport", package: "Platform")
            ]
        ),
        .testTarget(
            name: "AppDetailsImpTests",
            dependencies: [
                "AppDetailsImp",
                "AppDetailsTestSupport",
                .product(name: "RIBsTestSupport", package: "Platform"),
                .product(name: "RxBlocking", package: "RxSwift")
            ]
        )
    ]
)
