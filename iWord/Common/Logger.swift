// Data of creation: 6/12/22
// Create by Denis Ulianov aka Денис Александрович Ульянов
// Using Swift 5.0
// Running on macOS 12.5
//
// Copyrights
//
// I do not allow any person to use this piece of software
// for any purposes. 
// This project and source code may use libraries or frameworks that are
// released under various Open-Source licenses. Use of those libraries and
// frameworks are governed by their own individual licenses.

import Foundation

enum Log {
    enum LogLevel {
        case error
        case warning
        case info
        case throwing
        
        fileprivate var prefix: String {
            switch self {
            case .error: return      "🚨 ERROR"
            case .warning: return    "❗️ WARNING"
            case .info: return       "⚠️ INFO"
            case .throwing: return   "⁉️ THROWING"
            }
        }
    }
    
    struct Context {
        let file: String
        let function: String
        let line: Int
        var description: String {
            return "File: \((file as NSString).lastPathComponent)\nLine: \(line)\nFunction: \(function)\n"
        }
    }
    
    static func error(_ staticText: StaticString, shouldLog: Bool = true, file: String = #file, function: String = #function, line: Int = #line ) {
        let context = Context(file: file, function: function, line: line)
        Log.handleLog(level: .error, text: staticText.description , shouldLogContext: shouldLog, context: context)
    }
    
    static func warning(_ staticText: StaticString, shouldLog: Bool = true, file: String = #file, function: String = #function, line: Int = #line ) {
        let context = Context(file: file, function: function, line: line)
        Log.handleLog(level: .warning, text: staticText.description , shouldLogContext: shouldLog, context: context)
    }
    
    static func info(_ staticText: StaticString, shouldLog: Bool = true, file: String = #file, function: String = #function, line: Int = #line ) {
        let context = Context(file: file, function: function, line: line)
        Log.handleLog(level: .info, text: staticText.description , shouldLogContext: shouldLog, context: context)
    }
    
    static func throwing(_ staticText: StaticString, shouldLog: Bool = true, file: String = #file, function: String = #function, line: Int = #line ) {
        let context = Context(file: file, function: function, line: line)
        Log.handleLog(level: .throwing, text: staticText.description , shouldLogContext: shouldLog, context: context)
    }
    
    fileprivate static func handleLog(level: LogLevel, text: String, shouldLogContext: Bool, context: Context) {
        let logComponent = [">>\(level.prefix)", text]
        var fullString = logComponent.joined(separator: "\n")
        if shouldLogContext {
            fullString += "\n\(context.description)>>"
        }
        
#if DEBUG
        print(fullString)
#endif
    }
}
