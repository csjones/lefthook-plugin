import Foundation

/// Parses the lefthook artifact bundle to find the correct executable binary to run for the given OS. 
/// 
/// This code is heavily inspired by the Swift Package Manager's implementation of parsing artifact bundles. Links to reference code are provided in the comments.
class ArtifactParser {
    
    /// Parses the unzipped artifact bundle to find the correct lefthook binary to run for the given OS.
    ///
    /// Reference: https://github.com/apple/swift-package-manager/blob/1c68e6cab56a3acba30d3ecea0c09209c6c7f565/Sources/SPMBuildCore/BinaryTarget%2BExtensions.swift#L59-L85    
    static func getPathToLefthookBinary() -> String? {
        // 1. Get the tuple.
        // https://github.com/apple/swift-package-manager/blob/1c68e6cab56a3acba30d3ecea0c09209c6c7f565/Sources/SPMBuildCore/BinaryTarget%2BExtensions.swift#L61
        // 
        // If you look in an artifactbundle.zip, you will see a file called info.json that defines what executables belong to what OS. 
        // Swift uses a term "triples" to determine the OS and architecture of the system.
        // To be able to find the correct binary to execute, we need to get the system triple. 
        guard let systemTriple = OS.getSystemTriple() else {
            return nil
        }

        // 2. Parse the artifact bundle's info.json manifest file to get list of all available executable binaries. 
        // https://github.com/apple/swift-package-manager/blob/1c68e6cab56a3acba30d3ecea0c09209c6c7f565/Sources/SPMBuildCore/BinaryTarget%2BExtensions.swift#L63-L66
        // 
        // Luckily, SPM has already downloaded and unzipped the remote artifactbundle.zip by the time this executable target is compiled.
        // SPM downloads the artifactbundle.zip because we define a binaryTarget dependency. It unzips it to the .build directory because we define a pre-build plugin that's executed before this target is compiled.                
        guard let rootDirectoryOfArtifactBundle = getArtifactBundlePath() else {
            print("Unexpected error. Unable to find an artifact bundle directory that contains lefthook executables.")
            return nil
        }
        
        let infoJsonPath = "\(rootDirectoryOfArtifactBundle)/info.json"
        guard let infoJsonFileContents: Data = try? Data(contentsOf: URL(fileURLWithPath: infoJsonPath)) else {
            print("Unexpected error. Unable to read info.json file. Perhaps the path is incorrect? Given path: \(infoJsonPath)")
            return nil
        }
        
        guard let infoJsonParsed: ArtifactBundleInfo = try? JSONDecoder().decode(ArtifactBundleInfo.self, from: infoJsonFileContents) else {
            print("Unexpected error. Unable to parse manifest file json. Check if \(infoJsonPath) format is compatible with \(ArtifactBundleInfo.self) data type.")
            return nil
        }

        // 3. Lastly, take the system tuple and use that to find the 1 binary that we should run. 
        // https://github.com/apple/swift-package-manager/blob/1c68e6cab56a3acba30d3ecea0c09209c6c7f565/Sources/SPMBuildCore/BinaryTarget%2BExtensions.swift#L75-L81
        guard let binaryFileNameForOS = infoJsonParsed.artifacts.lefthook.variants.first(where: { $0.supportedTriples.contains(systemTriple) })?.path else {
            print("According to the artifact bundle manifest file, no lefthook binary exists for the given OS: \(systemTriple)")
            return nil
        }

        return "\(rootDirectoryOfArtifactBundle)/\(binaryFileNameForOS)"
    }
    
    // Get the path to the root directory of the artifact bundle. The root is considered to be the path where the info.json file exists.
    // Depending on how you execute the executable target, the artifact bundle path will be different.
    static func getArtifactBundlePath() -> String? {
        // For local "swift run" development, the path is:
        let localDevelopmentPath = ".build/artifacts/lefthook-plugin/lefthook"
        if let absolutePath = FileSystem.getAbsolutePathThatExists(relativePath: localDevelopmentPath) {
            return absolutePath
        }
        
        // If you run the executable with mint, the path relative to the executable will follow this pattern:
        // "artifacts/github.com_*/lefthook"
        // The path name is determined by the github repository name.
        if let absolutePathToMintResources = FileSystem.getAbsolutePathThatExists(relativePath: "artifacts"),
           let absoluteMintArtifactPath = FileSystem.getSubdirectories(atAbsolutePath: absolutePathToMintResources).first(where: { $0.contains("github.com_") })?.appending("/lefthook") {
            return absoluteMintArtifactPath
        }
        
        return nil
    }

    // Struct to parse the info.json file that is in the artifact bundle.
    struct ArtifactBundleInfo: Codable {
        let artifacts: Artifact 

        struct Artifact: Codable {
            let lefthook: LefthookArtifact

            struct LefthookArtifact: Codable {
                let variants: [ArtifactVariant]

                struct ArtifactVariant: Codable {
                    let path: String
                    let supportedTriples: [String]
                }
            }
        }
    }
}
