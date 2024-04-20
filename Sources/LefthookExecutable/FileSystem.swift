import Foundation

class FileSystem {
    // The base absolute path when using "swift run"
    static var pathWhereBinaryExecutedFrom: String {
        return FileManager.default.currentDirectoryPath
    }
    
    // The base absolute path when using "mint run"
    static var pathWhereBinaryExists: String {
        let fileURL = Bundle.main.executableURL!
        let directoryURL = fileURL.deletingLastPathComponent()
        return directoryURL.path
    }
    
    // Given a relative path, return the expanded absolute path. Only return result if the path exists.
    // Depending on if the executable is run by "swift run" or "mint run", the absolute path will be different.
    // Get the absolute path to be able to find the artifact bundle and parse it.
    static func getAbsolutePathThatExists(relativePath: String) -> String? {
        let absolutePathSwiftRun = "\(pathWhereBinaryExecutedFrom)/\(relativePath)"
        let absolutePathMintRun = "\(pathWhereBinaryExists)/\(relativePath)"
        
        if doesPathExist(path: absolutePathSwiftRun) {
            return absolutePathSwiftRun
        } else if doesPathExist(path: absolutePathMintRun) {
            return absolutePathMintRun
        }
        
        return nil
    }
    
    static func doesPathExist(path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    static func getSubdirectories(atAbsolutePath path: String) -> [String] {
        let contents = (try? FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: path), includingPropertiesForKeys: nil)) ?? []
        
        var subdirectories: [String] = []
        
        for item in contents {
            var isDirectory: ObjCBool = false
            if FileManager.default.fileExists(atPath: item.path, isDirectory: &isDirectory) {
                if isDirectory.boolValue {
                    let absolutePathToSubdirectory = "\(path)/\(item.lastPathComponent)"
                    subdirectories.append(absolutePathToSubdirectory)
                }
            }
        }
        
        return subdirectories
    }
}
