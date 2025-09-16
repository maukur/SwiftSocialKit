// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSocialKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SaveToDeviceKit",
            targets: ["SaveToDeviceKit"]
        ),
        .library(
            name: "InstagramShareKit",
            targets: ["InstagramShareKit"]
        ),
        .library(
            name: "TikTokShareKit",
            targets: ["TikTokShareKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/tiktok/tiktok-opensdk-ios", .upToNextMinor(from: "2.5.0"))
    ],
    targets: [
        .target(
            name: "SaveToDeviceKit"
        ),
        .target(
            name: "InstagramShareKit",
            dependencies: []
        ),
        .target(
            name: "TikTokShareKit",
            dependencies: [
                .product(name: "TikTokOpenSDKCore", package: "tiktok-opensdk-ios"),
                .product(name: "TikTokOpenShareSDK", package: "tiktok-opensdk-ios")
            ]
        )
    ]
)
