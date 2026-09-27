// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "video_codec_plugin",
    platforms: [
        .iOS("12.0"),
    ],
    products: [
        .library(name: "video-codec-plugin", targets: ["video_codec_plugin"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "video_codec_plugin",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
