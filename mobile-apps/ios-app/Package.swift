// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "CameraStreamer",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "CameraStreamer",
            targets: ["CameraStreamer"]),
    ],
    dependencies: [
        // SGPlayer for RTSP streaming support
        .package(url: "https://github.com/libobjc/SGPlayer.git", from: "4.0.0"),
        // Alamofire for HTTP networking
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.0"),
        // SwiftUI Navigation helpers
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.2.0")
    ],
    targets: [
        .target(
            name: "CameraStreamer",
            dependencies: [
                "SGPlayer",
                "Alamofire",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]),
        .testTarget(
            name: "CameraStreamerTests",
            dependencies: ["CameraStreamer"]),
    ]
)