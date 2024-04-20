//
//  LefthookPlugin.swift
//  csjones/lefthook-plugin
//
//  Copyright (c) 2023 GigaBitcoin LLC
//  Distributed under the MIT software license
//
//  See the accompanying file LICENSE for information
//

import Foundation
import PackagePlugin

@main
struct LefthookPlugin: CommandPlugin {
    func performCommand(
        context: PackagePlugin.PluginContext,
        arguments: [String]
    ) async throws {
        let binary = try context.tool(named: "lefthook")
        let process = Process()

        process.executableURL = URL(fileURLWithPath: binary.path.string)
        process.arguments = arguments

        try process.run()
        process.waitUntilExit()

        // Check whether the `template` invocation was successful.
        guard process.terminationReason == .exit && process.terminationStatus == 0 else {
            Diagnostics.error("""
                'lefthook' invocation failed with a nonzero exit code: '\(process.terminationStatus)'.

                Note: The lefthook plugin requires passing the '--disable-sandbox' flag
                to the Swift Package Manager because it requires local document access to
                read files. See 'swift package lefthook --help' for details.
                """
            )

            return
        }
    }
}
