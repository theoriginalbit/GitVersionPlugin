// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "GitVersionPlugin",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .plugin(name: "GitVersionPlugin", targets: ["GitVersionPlugin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", exact: "509.1.1"),
    ],
    targets: [
        .plugin(name: "GitVersionPlugin", capability: .buildTool(), dependencies: [
            .target(name: "GitStatus"),
        ]),
        .executableTarget(name: "GitStatus", dependencies: [
            .product(name: "SwiftSyntax", package: "swift-syntax"),
            .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        ]),
    ]
)
