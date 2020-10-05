import Foundation
import os.log

protocol ILogger {
    func handleLog(logLevel: LogLevel, tag: String?, category: String?, message: String?, error: Error?)
}

fileprivate var loggers: [ILogger] = []

class Logger {
    private init() {
        // contains only static functions
        // so therefore an instance will be never initiatated
    }

    static func e(tag: String? = nil, category: String? = nil, message: String? = nil, error: Error? = nil) {
        log(logLevel: .ERROR, tag: tag, category: category, message: message, error: error)
    }

    static func w(tag: String? = nil, category: String? = nil, message: String? = nil, error: Error? = nil) {
        log(logLevel: .WARNING, tag: tag, category: category, message: message, error: error)
    }

    static func d(tag: String? = nil, category: String? = nil, message: String? = nil, error: Error? = nil) {
        log(logLevel: .DEBUG, tag: tag, category: category, message: message, error: error)
    }

    static func i(tag: String? = nil, category: String? = nil, message: String? = nil, error: Error? = nil) {
        log(logLevel: .INFO, tag: tag, category: category, message: message, error: error)
    }

    static func log(logLevel: LogLevel, tag: String?, category: String?, message: String?, error: Error?) {
        loggers.forEach {
            $0.handleLog(logLevel: logLevel, tag: tag, category: category, message: message, error: error)
        }
    }

    static func plant(_ logger: ILogger...) {
        loggers += logger
    }
}

class OsLogLogger: ILogger {
    static let instance = OsLogLogger()

    private init() {
        // has no state. initializer needed only because of visibility
    }

    func handleLog(logLevel: LogLevel, tag: String?, category: String?, message: String?, error: Error?) {
        let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "DeliriumOver/\(category)")
        os_log("%@", log: log, type: logLevel.toOSLogType(), "Message: \(message). Stacktrace: \(error.debugDescription)")
    }
}

private extension LogLevel {
    func toOSLogType() -> OSLogType {
        switch self {
        case .ERROR:
            return .fault
        case .WARNING:
            return .error
        case .DEBUG:
            return .debug
        case .INFO:
            return .info
        }
    }
}

enum LogLevel: String, Codable {
    case ERROR
    case WARNING
    case DEBUG
    case INFO
}
