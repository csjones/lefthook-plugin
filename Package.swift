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
            url: "https://github.com/csjones/lefthook-plugin/releases/download/1.11.4/lefthook.artifactbundle.zip",
            checksum: "9ec53679a6a376f84ab63c4fbda7f0f9f933ceed678110d091b275741354f0de"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
