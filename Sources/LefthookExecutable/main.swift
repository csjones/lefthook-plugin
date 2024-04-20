import Foundation

// Get arguments that were passed into this executable that we will forward to lefthook as args. 
let lefthookArgs = Array(ProcessInfo.processInfo.arguments.dropFirst())

guard let lefthookBinaryPath = ArtifactParser.getPathToLefthookBinary() else {
    print("Error: Unable to find lefthook binary. Unable to run lefthook.")
    exit(1)
}

// Run lefthook binary with the arguments that were passed into this executable.
let process = Process()
process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
process.arguments = [lefthookBinaryPath] + lefthookArgs

do {
    try process.run()
    process.waitUntilExit()
} catch {
    print("Error running process: \(error)")
}
