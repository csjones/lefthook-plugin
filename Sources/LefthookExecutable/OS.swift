import Foundation

/// Utility that helps determine what OS Swift is being executed on. 
/// Helpful to determine the right binary to run for the given OS. 
class OS {
    /// Get the system triple that represents the OS that Swift is being executed on.
    /// Based on the Swift Package Manager's implementation:
    /// https://github.com/apple/swift-package-manager/blob/1c68e6cab56a3acba30d3ecea0c09209c6c7f565/Sources/Basics/Triple%2BBasics.swift#L84-L121
    static func getSystemTriple() -> String? {
        let process = Process()        
        let stdoutPipe = Pipe()

        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["swift", "-print-target-info"]
        process.standardOutput = stdoutPipe

        do {
            try process.run()
            process.waitUntilExit()
        } catch {
            print("Error running process: \(error)")
            return nil 
        }
        
        let stdoutString = stdoutPipe.fileHandleForReading.readDataToEndOfFile()
        guard let stdoutParsed: SwiftTargetInfo = try? JSONDecoder().decode(SwiftTargetInfo.self, from: stdoutString) else {
            print("Unexpected error. Unable to parse JSON: \(stdoutString) into data type \(SwiftTargetInfo.self)")
            return nil
        }

        return stdoutParsed.target.unversionedTriple
    }

    // Run "swift -print-target-info" on your computer. This struct is used to parse the output of that command.
    struct SwiftTargetInfo: Codable {
        let target: Target
        
        struct Target: Codable {
            let unversionedTriple: String
        }
    }
}
