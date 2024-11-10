// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MGOTPKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "MGOTPKit",
            targets: ["MGOTPKit"]),
    ],
    targets: [
        .target(
            name: "MGOTPKit"),
        .testTarget(
            name: "MGOTPKitTests",
            dependencies: ["MGOTPKit"]
        ),
    ]
)
