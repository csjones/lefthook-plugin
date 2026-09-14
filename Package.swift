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
            url: "https://github.com/csjones/lefthook-plugin/releases/download/2.1.14/lefthook.artifactbundle.zip",
            checksum: "af5fb9588a27dcfb5c6e7f49801bd9acadc081c45a6f087b0002cdb5f5bd3ae1"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
