//
//  Logger.swift
//  VeryGoodCoffee
//
//  Created by wellington ferreira on 24/11/25.
//


// Services/Logger.swift
import os.log
import Foundation

enum Logger {
    private static let subsystem = "com.wellingtonferreira.VeryGoodCoffee"
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let persistence = OSLog(subsystem: subsystem, category: "Persistence")
    static let ui = OSLog(subsystem: subsystem, category: "UI")
    
    static func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        os_log("ERROR: %{public}@ — %@:%d — %@", log: .default, type: .error,
               message, (file as NSString).lastPathComponent, line, function)
    }
    
    static func info(_ message: String) {
        os_log("%{public}@", log: .default, type: .info, message)
    }
}
