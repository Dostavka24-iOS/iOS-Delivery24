//
// Logger.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 20.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import SwiftPrettyPrint

final class Logger {
    private init() {}

    static func log(kind: Kind = .info, message: Any, fileName: String = #file, function: String = #function, line: Int = #line) {
        #if DEBUG
        let swiftFileName = fileName.split(separator: "/").last ?? "file not found"
        Swift.print("[ \(kind.rawValue.uppercased()) ]: [ \(Date()) ]: [ \(swiftFileName) ] [ \(function) ]: [ #\(line) ]")
        Pretty.prettyPrint(message)
        Swift.print()
        #endif
    }

    static func `print`(_ message: Any, line: Int = #line) {
        #if DEBUG
        Swift.print("[DEBUG]: #\(line):", message)
        #endif
    }

    enum Kind: String, Hashable {
        case info  = "ℹ️ info"
        case error = "⛔️ error"
        case debug = "⚙️ debug"
        case warning = "⚠️ warning"
    }
}
