// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "lefthook",
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
            url: "https://github.com/csjones/lefthook-plugin/releases/download/2.0.4/lefthook.artifactbundle.zip",
            checksum: "ce7fe218af153c116525212b39b0881d1bf45eea64efb5246c4ce0393122d0a8"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
