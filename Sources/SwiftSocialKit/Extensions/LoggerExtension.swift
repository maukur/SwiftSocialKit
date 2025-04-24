import Foundation
import os.log

class LogManager {
    
    static let subsystem = "com.nicolaischneider.swiftsocialkit"
    
    @MainActor static let swiftSocialKit = LogManager(category: "SWIFTSOCIALKIT")
    
    private let osLog: OSLog
    
    init(category: String) {
        self.osLog = OSLog(subsystem: LogManager.subsystem, category: category)
    }
    
    func addLog(
        _ message: String,
        input: String? = nil,
        level: OSLogType = .default,
        shareWithCrashlytics: Bool = true
    ) {
        if let input = input {
            addlog("\(message): \(String(describing: input))", level: level)
        } else {
            addlog(message, level: level)
        }
    }
    
    func addLog(
        _ message: String,
        input: CGFloat,
        level: OSLogType = .default,
        shareWithCrashlytics: Bool = true
    ) {
        let text = "\(message): \(input)"
        addlog(text, level: level)
    }
    
    private func addlog(_ message: String, level: OSLogType) {
        switch level {
        case .debug:
            os_log("%{private}@", log: osLog, type: .debug, message)
        case .info:
            os_log("%{private}@", log: osLog, type: .info, message)
        case .error:
            os_log("%{private}@", log: osLog, type: .error, message)
        case .fault:
            os_log("%{private}@", log: osLog, type: .fault, message)
        default:
            os_log("%{private}@", log: osLog, type: .default, message)
        }
    }
}
