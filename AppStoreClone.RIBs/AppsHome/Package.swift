// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppsHome",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AppsHome",
            targets: ["AppsHome"]),
        .library(
            name: "ShowAllApps",
            targets: ["ShowAllApps"]),
        .library(
            name: "ShowAllAppsImp",
            targets: ["ShowAllAppsImp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/uber/RIBs", .upToNextMajor(from: Version(stringLiteral: "0.9.2"))),
        .package(path: "../Platform"),
        .package(path: "../AppDetails")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AppsHome",
            dependencies: [
                "RIBs",
                "ShowAllApps",
                .product(name: "AppDetails", package: "AppDetails"),
                .product(name: "Entities", package: "Platform"),
                .product(name: "Network", package: "Platform"),
                .product(name: "ReuseableViews", package: "Platform"),
                .product(name: "ResourcesLibrary", package: "Platform"),
            ]
        ),
        .target(
            name: "ShowAllApps",
            dependencies: [
                "RIBs",
                .product(name: "Entities", package: "Platform"),
                .product(name: "ReuseableViews", package: "Platform"),
            ]
        ),
        .target(
            name: "ShowAllAppsImp",
            dependencies: [
                "RIBs",
                "ShowAllApps",
                .product(name: "Entities", package: "Platform"),
                .product(name: "Network", package: "Platform"),
                .product(name: "ReuseableViews", package: "Platform"),
                .product(name: "ResourcesLibrary", package: "Platform"),
            ]
        ),
    ]
)
