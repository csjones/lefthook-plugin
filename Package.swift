// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "lefthook",
    platforms: [.macOS(.v10_15)],
    products: [
        .executable(name: "lefthook", targets: ["LefthookExecutable"]),
        .plugin(name: "LefthookPlugin",targets: ["LefthookPlugin"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "LefthookExecutable",
            plugins: [
                .plugin(name: "ArtifactExpander")
            ]
        ),
        .plugin(
            name: "ArtifactExpander",
            capability: .buildTool(),
            dependencies: ["lefthook"]
        ),
        .plugin(
            name: "LefthookPlugin",
            capability: .command(
                intent: .custom(
                    verb: "lefthook",
                    description: "Execute commands defined in lefthook.yml."
                )
            ),
            dependencies: ["lefthook"]
        ),
        .binaryTarget(
            name: "lefthook",
            url: "https://github.com/csjones/lefthook-plugin/releases/download/2.1.11/lefthook.artifactbundle.zip",
            checksum: "f29ef28183f44c1f079d5e8b4b00ccfae123e4ac5ab1900101b1ed6ba4da280d"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
