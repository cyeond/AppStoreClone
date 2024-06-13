// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Platform",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Entities",
            targets: ["Entities"]),
        .library(
            name: "Network",
            targets: ["Network"]),
        .library(
            name: "ReuseableViews",
            targets: ["ReuseableViews"]),
        .library(
            name: "Extensions",
            targets: ["Extensions"]),
        .library(
            name: "ResourcesLibrary",
            targets: ["ResourcesLibrary"]),
    ],
    dependencies: [
        .package(url: "https://github.com/uber/RIBs", .upToNextMajor(from: Version(stringLiteral: "0.9.2"))),
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: Version(stringLiteral: "6.7.1")))
    ],
    targets: [
        .target(
            name: "Entities",
            dependencies: [
                "Extensions"
            ]
        ),
        .target(
            name: "Network",
            dependencies: [
                "RxSwift",
                "Entities"
            ]
        ),
        .target(
            name: "Extensions",
            dependencies: [
                "RIBs",
                "ResourcesLibrary"
            ]
        ),
        .target(
            name: "ReuseableViews",
            dependencies: [
                "RxSwift",
                "Entities",
                "Network",
                "ResourcesLibrary"
            ]
        ),
        .target(
            name: "ResourcesLibrary",
            resources: [
                .process("Resources/Assets.xcassets")
            ]
        ),
    ]
)
